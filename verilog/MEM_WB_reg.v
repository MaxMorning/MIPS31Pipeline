module MEM_WB_reg (
    input wire clk,
    input wire reset,
    input wire ena, // Src: PipelineController.mem_wb_ena

    input wire[31:0] mem_instr_in, // Src: Instr(MEM)
    input wire[31:0] mem_pc_in, // Src: PC(MEM)
    input wire[31:0] mem_dmem_rdata_in, // Src: DMEM.rdata(MEM)
    input wire[31:0] mem_alu_result_in, // Src: EXE_MEM_reg.alu_result_out(MEM)

    input wire mem_GPR_we_in, // Src: EXE_MEM_reg.mem_GPR_we(MEM)
    input wire[4:0] mem_GPR_waddr_in, // Src: EXE_MEM_reg.mem_GPR_waddr(MEM)
    input wire[1:0] mem_GPR_wdata_select_in, // Src: EXE_MEM_reg.exe_GPR_wdata_select(MEM)

    output reg wb_GPR_we,
    output reg[4:0] wb_GPR_waddr,
    output reg[31:0] wb_GPR_wdata
);
    wire[31:0] gpr_wdata;

    Mux4 gpr_wdata_select_inst(
        .in0(mem_dmem_rdata_in),
        .in1(mem_alu_result_in),
        .in2(mem_pc_in),
        .in3(mem_pc_in),
        .sel(mem_GPR_wdata_select_in),

        .out(gpr_wdata)
    );

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            wb_GPR_we <= 0;
            wb_GPR_waddr <= 0;
            wb_GPR_wdata <= 0;
        end
        else if (ena) begin
            wb_GPR_we <= ena & mem_GPR_we_in;
            wb_GPR_waddr <= mem_GPR_waddr_in;
            wb_GPR_wdata <= gpr_wdata;
        end
    end
endmodule