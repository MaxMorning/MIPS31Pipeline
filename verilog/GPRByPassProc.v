/*
File Name : GPRByPassProc.v
Create time : 2021.07.14 1:05
Author : Morning Han
Function : 
    ByPass data Process on GPR read.

*/

module GPRByPassProc(
    input wire EXE_is_wb, // Src: ID_EXE_reg.exe_GPR_we & ~(~GPR_wdata_select(EXE)[1] & ~GPR_wdata_select(EXE)[0])
    input wire[4:0] EXE_rd, // Src: ID_EXE_reg.exe_GPR_waddr
    input wire[1:0] EXE_wdata_select, // Src: GPR_wdata_select(EXE)
    input wire[31:0] EXE_alu_result,
    input wire[31:0] EXE_pc_out,

    input wire MEM_is_wb, // Src: mem_GPR_we
    input wire[4:0] MEM_rd, // Src: mem_GPR_waddr
    input wire[1:0] MEM_wdata_select, // Src: GPR_wdata_select(MEM)
    input wire[31:0] MEM_alu_result,
    input wire[31:0] MEM_pc_out,
    input wire[31:0] MEM_mem_rdata,

    input wire WB_is_wb,
    input wire[4:0] WB_rd,
    input wire[31:0] WB_result,

    input wire[4:0] rs_addr,
    input wire[31:0] rs_data,

    input wire[4:0] rt_addr,
    input wire[31:0] rt_data,

    output wire[31:0] rs_valid_data,
    output wire[31:0] rt_valid_data
);

    wire exe_actual_we = EXE_is_wb & (| EXE_wdata_select);
    wire[31:0] exe_actual_result = EXE_wdata_select[0] ? EXE_alu_result : EXE_pc_out;

    wire[31:0] mem_actual_result;
    Mux4 mem_result_select_inst(
        .in0(MEM_mem_rdata),
        .in1(MEM_alu_result),
        .in2(MEM_pc_out),
        .in3(MEM_pc_out),
        .sel(MEM_wdata_select),

        .out(mem_actual_result)
    );

    reg[31:0] rs_valid_data_reg;

    always @(*) begin
        if (EXE_rd == rs_addr && EXE_rd != 5'h0 && exe_actual_we)
            rs_valid_data_reg = exe_actual_result;
        else if (MEM_rd == rs_addr && MEM_rd != 5'h0 && MEM_is_wb)
            rs_valid_data_reg = mem_actual_result;
        else if (WB_rd == rs_addr && WB_rd != 5'h0 && WB_is_wb)
            rs_valid_data_reg = WB_result;
        else
            rs_valid_data_reg = rs_data;
    end

    assign rs_valid_data = rs_valid_data_reg;


    reg[31:0] rt_valid_data_reg;

    always @(*) begin
        if (EXE_rd == rt_addr && EXE_rd != 5'h0 && exe_actual_we)
            rt_valid_data_reg = exe_actual_result;
        else if (MEM_rd == rt_addr && MEM_rd != 5'h0 && MEM_is_wb)
            rt_valid_data_reg = mem_actual_result;
        else if (WB_rd == rt_addr && WB_rd != 5'h0 && WB_is_wb)
            rt_valid_data_reg = WB_result;
        else
            rt_valid_data_reg = rt_data;
    end

    assign rt_valid_data = rt_valid_data_reg;
endmodule