module ID_EXE_reg (
    input wire clk,
    input wire reset,
    input wire ena, // Src: PipelineController.id_exe_ena
    input wire[31:0] id_instr_in, // Src: Instr(ID)
    input wire[31:0] id_pc_in, // Src: ID_pc_out(ID)

    input wire[31:0] ext_result_in, // Src: ImmExt.ExtResult(ID)
    input wire[31:0] id_GPR_rs_in, // Src: RegFile.rdata1(ID)
    input wire[31:0] id_GPR_rt_in, // Src: RegFile.rdata2(ID)

    input wire id_GPR_we_in, // Src: IF_ID_reg.id_GPR_we(ID)
    input wire[4:0] id_GPR_waddr_in, // Src: IF_ID_reg.id_GPR_waddr(ID)
    input wire[1:0] id_GPR_wdata_select_in, // Src: IF_ID_reg.id_GPR_wdata_select(ID)


    output reg[31:0] exe_alu_opr1_out,
    output reg[31:0] exe_alu_opr2_out,
    output wire[3:0] exe_alu_contorl,
    output reg exe_GPR_we,
    output reg[4:0] exe_GPR_waddr,
    output reg[1:0] exe_GPR_wdata_select,
    output reg[31:0] exe_GPR_rt_out,
    output reg[31:0] exe_pc_out,
    output reg[31:0] exe_instr_out
);

    wire alu_opr1_select = ~exe_instr_out[29] & ~exe_instr_out[28] & ~exe_instr_out[27] & ~exe_instr_out[26] & ~exe_instr_out[5] & ~exe_instr_out[2];
    wire alu_opr2_select = (exe_instr_out[29] | exe_instr_out[31]);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            exe_pc_out <= 32'h00000000;
            exe_instr_out <= 32'h00000000;

            exe_alu_opr1_out <= 0;
            exe_alu_opr2_out <= 0;
            exe_GPR_waddr <= 0;
            exe_GPR_wdata_select <= 0;
            exe_GPR_rt_out <= 0;
            exe_GPR_we <= 0;
        end
        else if (ena) begin
            exe_pc_out <= id_pc_in;
            exe_instr_out <= id_instr_in;

            exe_alu_opr1_out <= alu_opr1_select ? ext_result_in : id_GPR_rs_in;
            exe_alu_opr2_out <= alu_opr2_select ? ext_result_in : id_GPR_rt_in;

            exe_GPR_we <= id_GPR_we_in & ena;
            exe_GPR_waddr <= id_GPR_waddr_in;
            exe_GPR_wdata_select <= id_GPR_wdata_select_in;
            exe_GPR_rt_out <= id_GPR_rt_in;
        end
    end

    assign exe_alu_contorl = exe_instr_out[31] ? 4'b0001 : // lw/sw
                        (exe_instr_out[29] ? // 1xxx
                            (exe_instr_out[28] ? // 11xx
                                (exe_instr_out[27] ? // 111x
                                    (exe_instr_out[26] ? 4'b1110 : 4'b0110) : //1111 lui   1110 xori
                                    {1'b0, exe_instr_out[28:26]} //1101 ori   1100 andi
                                    // (exe_instr_out[26] ? 4'b0101 : 4'b0100) //1101 ori   1100 andi
                                ) : // 10xx
                                {exe_instr_out[27], exe_instr_out[28:26]}
                                // (exe_instr_out[27] ? 
                                //     (exe_instr_out[26] ? 4'b1011 : 4'b1010) : //1011 sltiu    1010 slti
                                //     (exe_instr_out[26] ? 4'b0001 : 4'b0000) //1001 addiu   1000 addi
                                // )
                            ) : // 0xxx
                            (exe_instr_out[28] ? // 01xx
                                4'b0110 : // 00xx
                                // (exe_instr_out[27] ? 
                                //     (exe_instr_out[26] ? 4'b1110 : 4'b0110) : //0111 NA  0110 NA
                                //     (exe_instr_out[26] ? 4'b0110 : 4'b0110) //0101 bne   0100 beq
                                // ) :
                                (exe_instr_out[27] ? // 001x
                                    {2'b00, exe_instr_out[27:26]} : // 000x
                                    // (exe_instr_out[26] ? 4'b1011 : 4'b1010) : //0011 jal   0010 j
                                    (exe_instr_out[26] ? 4'b0001 : {4{exe_instr_out[5]}} ~^ {exe_instr_out[3], exe_instr_out[5] & exe_instr_out[2], exe_instr_out[1:0]}) //0001 NA   0000 R type
                                )
                            )
                        );
endmodule