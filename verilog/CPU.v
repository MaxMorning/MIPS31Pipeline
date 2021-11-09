module CPU (
    input wire clk,
    input wire reset,
    input wire cpu_ena,

    input wire[31:0] IMEM_rdata,
    input wire[31:0] DMEM_rdata,

    output wire[31:0] IMEM_raddr,
    output wire[31:0] DMEM_addr,
    output wire[31:0] fetch_DMEM_addr,
    output wire[31:0] DMEM_wdata,
    output wire DMEM_we
);

    wire load_branch_conflict;
    wire if_id_ena;
    wire id_exe_ena;
    wire exe_mem_ena;
    wire mem_wb_ena;

    // IF
    wire[31:0] if_pc_out;
    wire[31:0] if_imem_rdata;

    // ID
    wire id_should_branch;
    wire[31:0] id_branch_pc;
    wire[1:0] id_ext_select;
    wire id_GPR_we;
    wire[4:0] id_GPR_waddr;
    wire[1:0] id_GPR_wdata_select;
    wire[31:0] id_pc_out;
    wire[31:0] id_instr_out;

    wire id_is_branch_instr;

    wire[31:0] id_ori_rs_data;
    wire[31:0] id_ori_rt_data;

    wire[31:0] id_ext_result;

    wire[31:0] id_valid_rs_data;
    wire[31:0] id_valid_rt_data;

    // EXE
    wire exe_GPR_we;
    wire[4:0] exe_GPR_waddr;
    wire[1:0] exe_GPR_wdata_select;
    wire[31:0] exe_pc_out;
    wire[31:0] exe_instr_out;

    wire[31:0] exe_alu_opr1;
    wire[31:0] exe_alu_opr2;
    wire[3:0] exe_alu_contorl;
    wire[31:0] exe_alu_result;

    wire[31:0] exe_GPR_rt_out;

    wire exe_alu_not_change;

    wire[31:0] exe_valid_alu_opr1;
    wire[31:0] exe_valid_alu_opr2;
    wire[31:0] exe_valid_rt_data;

    // MEM
    wire mem_GPR_we;
    wire[4:0] mem_GPR_waddr;
    wire[1:0] mem_GPR_wdata_select;
    wire[31:0] mem_pc_out;
    wire[31:0] mem_instr_out;
    wire[31:0] mem_alu_result;
    wire[31:0] mem_mem_rdata;

    wire mem_mem_we;
    wire[31:0] mem_GPR_rt_out;

    // WB
    wire wb_GPR_we;
    wire[4:0] wb_GPR_waddr;
    wire[31:0] wb_GPR_wdata;


    assign load_branch_conflict = (if_id_ena & id_is_branch_instr) // instr in ID is a branch instr
                                    &
                                    (id_exe_ena & exe_GPR_we & ~(| exe_GPR_wdata_select))// instr in EXE is a load instr
                                    & ((exe_instr_out[20:16] == id_instr_out[25:21]) | (exe_instr_out[20:16] == id_instr_out[20:16])) // instrs in ID and EXE have WaR hazard, should stall
                                    ;

    assign if_imem_rdata = IMEM_rdata;
    assign mem_mem_rdata = DMEM_rdata;

    assign IMEM_raddr = if_pc_out;
    assign fetch_DMEM_addr = mem_alu_result;
    assign DMEM_addr = exe_alu_result; // for block memory
    assign DMEM_wdata = exe_GPR_rt_out; // for block memory
    wire exe_mem_we = id_exe_ena & exe_instr_out[31] & exe_instr_out[29];
    assign DMEM_we = exe_mem_we; // for block memory

    PipelineController pipeline_ctrl_inst(
        .clk(clk),
        .reset(reset),
        .ena(cpu_ena),

        .if_id_ena(if_id_ena),
        .id_exe_ena(id_exe_ena),
        .exe_mem_ena(exe_mem_ena),
        .mem_wb_ena(mem_wb_ena)
    );

    // IF

    PC pc_inst(
        .clk(clk),
        .reset(reset),
        .we(~load_branch_conflict), // this is for solving branch after load conflict

        .pc_in(id_should_branch ? id_branch_pc : if_pc_out + 4),

        .pc_out(if_pc_out)
    );

    // ID
    IF_ID_reg if_id_reg_inst(
        .clk(clk),
        .reset(reset),
        .ena(if_id_ena & ~load_branch_conflict),

        .if_pc_in(if_pc_out),
        .if_instr_in(if_imem_rdata),

        .ExtSelect_out(id_ext_select),
        .id_GPR_we(id_GPR_we),
        .id_GPR_waddr(id_GPR_waddr),
        .id_GPR_wdata_select(id_GPR_wdata_select),
        .id_pc_out(id_pc_out),
        .id_instr_out(id_instr_out)
    );
    
    RegFile gpr_inst(
        .clk(clk),
        .reset(reset),
        .we(wb_GPR_we),
        .raddr1(id_instr_out[25:21]),
        .raddr2(id_instr_out[20:16]),

        .waddr(wb_GPR_waddr),
        .wdata(wb_GPR_wdata),

        .rdata1(id_ori_rs_data),
        .rdata2(id_ori_rt_data)
    );

    ImmExt imm_ext_inst(
        .Imm16(id_instr_out[15:0]),
        .ExtSelect(id_ext_select),

        .extResult(id_ext_result)
    );

    GPRByPassProc gpr_bypass_proc_inst(
        .EXE_is_wb(exe_GPR_we),
        .EXE_rd(exe_GPR_waddr),
        .EXE_wdata_select(exe_GPR_wdata_select),
        .EXE_alu_result(exe_alu_result),
        .EXE_pc_out(exe_pc_out),

        .MEM_is_wb(mem_GPR_we),
        .MEM_rd(mem_GPR_waddr),
        .MEM_wdata_select(mem_GPR_wdata_select),
        .MEM_alu_result(mem_alu_result),
        .MEM_pc_out(mem_pc_out),
        .MEM_mem_rdata(mem_mem_rdata),

        .WB_is_wb(wb_GPR_we),
        .WB_rd(wb_GPR_waddr),
        .WB_result(wb_GPR_wdata),

        .rs_addr(id_instr_out[25:21]),
        .rs_data(id_ori_rs_data),

        .rt_addr(id_instr_out[20:16]),
        .rt_data(id_ori_rt_data),

        .rs_valid_data(id_valid_rs_data),
        .rt_valid_data(id_valid_rt_data)
    );

    BranchProc branch_proc_inst(
        .instr(id_instr_out),
        .GPR_rs_data(id_valid_rs_data),
        .GPR_rt_data(id_valid_rt_data),
        .delay_slot_pc(if_pc_out),

        .id_is_branch_instr(id_is_branch_instr),
        .is_branch(id_should_branch),
        .branch_pc(id_branch_pc)
    );

    // EXE

    ID_EXE_reg id_exe_reg_inst(
        .clk(clk),
        .reset(reset),
        .ena(id_exe_ena),

        .id_instr_in(load_branch_conflict ? 32'h0 : id_instr_out), // this mux is for solving branch after load conflict
        .id_pc_in(id_pc_out),

        .ext_result_in(id_ext_result),
        .id_GPR_rs_in(id_valid_rs_data),
        .id_GPR_rt_in(id_valid_rt_data),

        .id_GPR_we_in(id_GPR_we),
        .id_GPR_waddr_in(id_GPR_waddr),
        .id_GPR_wdata_select_in(id_GPR_wdata_select),

        .exe_alu_opr1_out(exe_alu_opr1),
        .exe_alu_opr2_out(exe_alu_opr2),
        .exe_alu_contorl(exe_alu_contorl),

        .exe_GPR_we(exe_GPR_we),
        .exe_GPR_waddr(exe_GPR_waddr),
        .exe_GPR_wdata_select(exe_GPR_wdata_select),
        .exe_GPR_rt_out(exe_GPR_rt_out),
        .exe_pc_out(exe_pc_out),
        .exe_instr_out(exe_instr_out)
    );

    EXE_load_alu_ByPassProc exe_load_bypass_proc_inst(
        .mem_ena(exe_mem_ena),
        .mem_rt_addr_in(mem_instr_out[20:16]),
        .mem_GPR_wdata_select_in(mem_GPR_wdata_select),
        .mem_load_data(mem_mem_rdata),

        .exe_instr_in(exe_instr_out),

        .ori_alu_opr1(exe_alu_opr1),
        .ori_alu_opr2(exe_alu_opr2),
        .ori_rt_data(exe_GPR_rt_out),

        .valid_alu_opr1(exe_valid_alu_opr1),
        .valid_alu_opr2(exe_valid_alu_opr2),
        .valid_rt_data(exe_valid_rt_data)
    );

    ALU alu_inst(
        .opr1(exe_valid_alu_opr1),
        .opr2(exe_valid_alu_opr2),
        .ALUControl(exe_alu_contorl),

        .ALUResult(exe_alu_result),
        .not_change(exe_alu_not_change)
    );

    // MEM
    EXE_MEM_reg exe_mem_reg_inst(
        .clk(clk),
        .reset(reset),
        .ena(exe_mem_ena),

        .exe_instr_in(exe_instr_out),
        .exe_pc_in(exe_pc_out),
        .exe_GPR_rt_in(exe_valid_rt_data),
        .exe_alu_result(exe_alu_result),

        .exe_GPR_we_in(exe_GPR_we & ~exe_alu_not_change),
        .exe_GPR_waddr_in(exe_GPR_waddr),
        .exe_GPR_wdata_select_in(exe_GPR_wdata_select),

        .DMEM_we(mem_mem_we),
        .mem_alu_result(mem_alu_result),

        .mem_GPR_rt_out(mem_GPR_rt_out),
        .mem_GPR_we(mem_GPR_we),
        .mem_GPR_waddr(mem_GPR_waddr),
        .mem_GPR_wdata_select(mem_GPR_wdata_select),
        .mem_pc_out(mem_pc_out),
        .mem_instr_out(mem_instr_out)
    );

    // WB
    MEM_WB_reg mem_wb_reg_inst(
        .clk(clk),
        .reset(reset),
        .ena(mem_wb_ena),

        .mem_instr_in(mem_instr_out),
        .mem_pc_in(mem_pc_out),
        .mem_dmem_rdata_in(mem_mem_rdata),
        .mem_alu_result_in(mem_alu_result),

        .mem_GPR_we_in(mem_GPR_we),
        .mem_GPR_waddr_in(mem_GPR_waddr),
        .mem_GPR_wdata_select_in(mem_GPR_wdata_select),

        .wb_GPR_we(wb_GPR_we),
        .wb_GPR_waddr(wb_GPR_waddr),
        .wb_GPR_wdata(wb_GPR_wdata)
    );
endmodule