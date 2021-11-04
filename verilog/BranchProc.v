module BranchProc (
    input wire[31:0] instr, // Src: Instr(ID)
    input wire[31:0] GPR_rs_data, // Src: RegFile.rdata1(ID)
    input wire[31:0] GPR_rt_data, // Src: RegFile.rdata2(ID)
    input wire[31:0] pc, // Src: IF_ID_reg.pc_out(ID)

    output wire is_branch,
    output wire[31:0] branch_pc
);
    wire is_branch_instr = ~instr[31] & ~instr[29] & instr[28] & ~instr[27];
    wire is_jump_instr = ~instr[31] & ~instr[29] & ~instr[28] & instr[27];

    wire should_branch = (|(GPR_rs_data ^ GPR_rt_data)) ^~ instr[26];
    
    assign is_branch = is_jump_instr | (is_branch & should_branch);

    wire[31:0] branch_instr_pc_offset = is_branch_instr & should_branch ? {{15{instr[15]}}, instr[14:0], 2'b00} : 32'h8;

    assign branch_pc = is_jump_instr ? {pc[31:28], instr[25:0], 2'b00} :
                        pc + branch_instr_pc_offset;
endmodule