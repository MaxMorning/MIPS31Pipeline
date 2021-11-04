module SoC (
    input wire clk,
    input wire reset,
    input wire system_ena
);

    wire[31:0] IMEM_rdata;
    wire[31:0] DMEM_rdata;

    wire[31:0] IMEM_raddr;
    wire[31:0] DMEM_addr;
    wire[31:0] DMEM_wdata;
    wire DMEM_we;

    IMEM imem_inst(
        .a(IMEM_raddr),

        .spo(IMEM_rdata)
    );

    
    DMEM dmem_inst(
        .clk(clk),
        .we(DMEM_we),
        .addr(DMEM_addr),
        .wdata(DMEM_wdata),

        .rdata(DMEM_rdata)
    );

    CPU core0(
        .clk(clk),
        .reset(reset),
        .cpu_ena(system_ena),

        .IMEM_rdata(IMEM_rdata),
        .DMEM_rdata(DMEM_rdata),

        .IMEM_raddr(IMEM_raddr),
        .DMEM_addr(DMEM_addr),
        .DMEM_wdata(DMEM_wdata),
        .DMEM_we(DMEM_we)
    );
    
endmodule