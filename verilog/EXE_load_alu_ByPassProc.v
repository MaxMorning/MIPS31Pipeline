module EXE_load_alu_ByPassProc (
    input wire mem_ena, // Src: EXE_MEM_reg.ena
    input wire[4:0] mem_rt_addr_in, // Src: Instr(MEM)[20:16]
    input wire[1:0] mem_GPR_wdata_select_in, // Src: Src: EXE_MEM_reg.mem_GPR_waddr(MEM)
    input wire[31:0] mem_load_data, // Src: IMEM.rdata

    input wire[31:0] exe_instr_in, // Src: Instr(EXE)

    input wire[31:0] ori_alu_opr1,
    input wire[31:0] ori_alu_opr2,
    input wire[31:0] ori_rt_data,

    output wire[31:0] valid_alu_opr1,
    output wire[31:0] valid_alu_opr2,
    output wire[31:0] valid_rt_data
);

    wire mem_is_load_instr = mem_ena & ~(| mem_GPR_wdata_select_in); // 00 means load instr

    wire alu_opr1_use_gpr = ~(~exe_instr_in[29] & ~exe_instr_in[28] & ~exe_instr_in[27] & ~exe_instr_in[26] & ~exe_instr_in[5] & ~exe_instr_in[2]);
    wire alu_opr2_use_gpr = ~(exe_instr_in[29] | exe_instr_in[31]);

    wire change_rt = mem_is_load_instr &
                    (|exe_instr_in[20:16]) & // rt no zero
                    (exe_instr_in[20:16] == mem_rt_addr_in);

    assign valid_alu_opr1 = mem_is_load_instr &
                            alu_opr1_use_gpr &
                            (|exe_instr_in[25:21]) & //rs no zero
                            (exe_instr_in[25:21] == mem_rt_addr_in) 
                            ? mem_load_data : ori_alu_opr1;

    assign valid_alu_opr2 = change_rt &
                            alu_opr2_use_gpr
                            ? mem_load_data : ori_alu_opr2;

    assign valid_rt_data = change_rt
                           ? mem_load_data : ori_rt_data;
    
endmodule