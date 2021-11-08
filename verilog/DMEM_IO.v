module DMEM_io (
    input wire clk,
    input wire we,
    input wire[31:0] addr,
    input wire[31:0] wdata,
    
    output wire[31:0] rdata,


    input wire[7:0] opr1,
    input wire[7:0] opr2,
    output wire[15:0] result
);
    wire[31:0] bram_result;
    wire bram_we = ~addr[31] & we;


    assign rdata = addr[31] ? (addr[2] ? {24'h0, opr2} : {24'h0, opr1})
                    : bram_result;

    reg[15:0] display_result;
    assign result = display_result;

    bram bram_inst (
        .clka(clk),    // input wire clka
        .ena(1'b1),      // input wire ena
        .wea(bram_we),      // input wire [0 : 0] wea
        .addra(addr[15:2]),  // input wire [13 : 0] addra
        .dina(wdata),    // input wire [31 : 0] dina
        .douta(bram_result)  // output wire [31 : 0] douta
    );

    always @(posedge clk) begin
        if (we) begin
            if (addr[31] & addr[3]) begin
                display_result <= wdata[15:0];
            end
        end
    end
endmodule