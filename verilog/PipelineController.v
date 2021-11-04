/*
File Name : PipelineController.v
Create time : 2021.11.03 00:56
Author : Morning Han
License : MIT
Function : 
    Pipeline Controller

*/

module PipelineController (
    input wire clk,
    input wire reset,
    input wire ena,

    output wire if_id_ena,
    output wire id_exe_ena,
    output wire exe_mem_ena,
    output wire mem_wb_ena
);
    reg[3:0] pipeline_status;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            pipeline_status <= {3'b000, ena};
        end
        else begin
            pipeline_status[0] <= ena;
            pipeline_status[1] <= pipeline_status[0];
            pipeline_status[2] <= pipeline_status[1];
            pipeline_status[3] <= pipeline_status[2];
        end
    end

    assign if_id_ena = pipeline_status[0];
    assign id_exe_ena = pipeline_status[1];
    assign exe_mem_ena = pipeline_status[2];
    assign mem_wb_ena = pipeline_status[3];
endmodule