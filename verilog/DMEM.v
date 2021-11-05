module DMEM (
    input wire clk,
    input wire we,
    input wire[31:0] addr,
    input wire[31:0] wdata,
    
    output wire[31:0] rdata
);
    reg[31:0] data_array[0:255];
    assign rdata = data_array[addr[9:2]];

    always @(posedge clk) begin
        if (we) begin
            data_array[addr[9:2]] <= wdata;
        end
    end
endmodule