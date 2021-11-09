`timescale 1ns/1ps
module soc_tb();
    reg clk;
    reg reset;
    reg[7:0] opr1;
    reg[7:0] opr2;

    wire[15:0] result;

    integer load_branch_conflict_cnt;

    SoC soc(
        .base_clk(clk),
        .reset(reset),
        .opr1(opr1),
        .opr2(opr2),
        .result(result)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        $dumpfile("result.vcd");
        $dumpvars(5);

        reset = 0;
        opr1 = 3;
        opr2 = 15;

        load_branch_conflict_cnt = 0;

        #6
        reset = 1;

        #10
        if (soc.core0.load_branch_conflict) begin // calc ipc
            load_branch_conflict_cnt = load_branch_conflict_cnt + 1;
        end

        #50000
        $finish;
    end
    
endmodule