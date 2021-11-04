module EXE_MEM_reg (
    input wire clk,
    input wire reset,
    input wire ena, // Src: PipelineController.exe_mem_ena

    input wire[31:0] exe_instr_in, // Src: Instr(EXE)
    input wire[31:0] exe_pc_in, // Src: PC(EXE)
    input wire[31:0] exe_GPR_rt_in, // Src: ID_EXE_reg.exe_GPR_rt_out(EXE)
    input wire[31:0] exe_alu_result, // Src: ALU.alu_result(EXE)

    input wire exe_GPR_we_in, // Src: ID_EXE_reg.exe_GPR_we(EXE)
    input wire[4:0] exe_GPR_waddr_in, // Src: ID_EXE_reg.exe_GPR_waddr(EXE)
    input wire[1:0] exe_GPR_wdata_select_in, // Src: ID_EXE_reg.exe_GPR_wdata_select(EXE)

    output wire DMEM_we,
    output reg[31:0] mem_alu_result,
    output reg[31:0] mem_GPR_rt_out,
    output reg mem_GPR_we, // for ByPass process
    output reg[4:0] mem_GPR_waddr,
    output reg[1:0] mem_GPR_wdata_select,
    output reg[31:0] mem_pc_out,
    output reg[31:0] mem_instr_out
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            mem_pc_out <= 32'h00000000;
            mem_instr_out <= 32'h00000000;

            mem_alu_result <= 0;
            mem_GPR_rt_out <= 0;
            mem_GPR_waddr <= 0;
            mem_GPR_wdata_select <= 0;
            mem_GPR_we <= 0;
        end
        else if (ena) begin
            mem_pc_out <= exe_pc_in;
            mem_instr_out <= exe_instr_in;

            mem_alu_result <= exe_alu_result;
            mem_GPR_rt_out <= exe_GPR_rt_in;
            mem_GPR_waddr <= exe_GPR_waddr_in;
            mem_GPR_wdata_select <= exe_GPR_wdata_select_in;
            mem_GPR_we <= exe_GPR_we_in & ena;
        end
    end

    assign DMEM_we = ena & mem_instr_out[31] & mem_instr_out[29];
    
endmodule