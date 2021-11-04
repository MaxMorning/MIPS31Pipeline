# MIPS31Pipeline
A MIPS pipeline processor support 31 instructions  
2021-2022学年秋季学期 计算机系统结构 31条MIPS流水线处理器设计  
## Components
#### PipelineController.v
```verilog
input wire clk,
input wire reset,
input wire ena, // Src: CPU.ena

output wire if_id_ena,
output wire id_exe_ena,
output wire exe_mem_ena,
output wire mem_wb_ena
```
### IF part
#### PC.v
```verilog
input wire clk,
input wire reset,
input wire we, // Src: 1'b1

input wire[31:0] pc_in, // BranchProc.branch_pc(ID)

output reg[31:0] pc_out
```

#### IMEM.v
```verilog
input wire[31:0] a, // Src: PC.pc_out(IF)

output wire[31:0] spo
```
### ID part
#### IF_ID_reg.v
```verilog
input wire clk,
input wire reset,
input wire ena, // Src: PipelineController.if_id_ena
input wire[31:0] if_pc_in, // Src: PC.pc_out(IF)
input wire[31:0] if_instr_in, // Src: IMEM.spo(IF)

output wire[1:0] ExtSelect_out,
output wire id_GPR_we,
output wire[4:0] id_GPR_waddr,
output wire[1:0] id_GPR_wdata_select,
output reg[31:0] id_pc_out,
output reg[31:0] id_instr_out
```

#### RegFile.v
```verilog
input wire clk,
input wire reset,
input wire we, // Src: MEM_WB_reg.gpr_we(WB)
input wire[4:0] raddr1, // Src: Instr(ID)[25:21]
input wire[4:0] raddr2, // Src: Instr(ID)[20:16]
input wire[4:0] waddr, // Src: MEM_WB_reg.wb_GPR_waddr
input wire[31:0] wdata, 
/*
    Src: 
    (DMEM.rdata(MEM), 
    ALU.ALUresult(EXE) 
        => EXE_MEM_reg.alu_result(MEM),
    PC.pc_out(IF)
        => IF_ID_reg.pc_out(ID)
            => ID_EXE_reg.pc_out(EXE)
                => EXE_MEM_reg.pc_out(MEM))
    => MEM_WB_reg.gpr_wdata(WB)
*/

output wire[31:0] rdata1,
output wire[31:0] rdata2
```

#### ImmExt.v
```verilog
input wire[15:0] Imm16, // Src: Instr(ID)[15:0]
input wire[1:0] ExtSelect, // Src: IF_ID_reg.ExtSelect(ID)

output wire[31:0] extResult
```

#### GPRByPassProc.v
```verilog
input wire EXE_is_wb, // Src: ID_EXE_reg.exe_GPR_we
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
```

#### BranchProc.v
```verilog
input wire[31:0] instr, // Src: Instr(ID)
input wire[31:0] GPR_rs_data, // Src: RegFile.rdata1(ID)
input wire[31:0] GPR_rt_data, // Src: RegFile.rdata2(ID)
input wire[31:0] pc, // Src: IF_ID_reg.pc_out(ID)

output wire is_branch,
output wire[31:0] branch_pc
```

### EXE part
#### ID_EXE_reg.v
```verilog
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
```

#### ALU.v
```verilog
input wire[31:0] opr1, // Src: (RegFile.rdata1(ID), ImmExt.extResult(ID)) => ID_EXE_reg.ALU_opr1(EXE)
input wire[31:0] opr2, // Src: (RegFile.rdata2(ID), ImmExt.extResult(ID)) => ID_EXE_reg.ALU_opr2(EXE)
input wire[3:0] ALUControl, // Src: ID_EXE_reg.ALU_control(EXE)

output wire[31:0] ALUResult,
output wire overflow,
output wire zero
```

### MEM part
#### EXE_MEM_reg.v
```verilog
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
```

#### DMEM.v
```verilog
input wire clk,
input wire we, // Src: EXE_MEM_reg.DMEM_we
input wire[31:0] addr, // Src: ALU.ALUResult(EXE) => EXE_MEM_reg.alu_result(MEM)
input wire[31:0] wdata, // Src: RegFile.rdata2(ID) => ID_EXE_reg.GPR_rt_data(EXE) => EXE_MEM_reg.GPR_rt_data(MEM)
    
output wire[31:0] rdata
```
WB part
#### MEM_WB_reg.v
```verilog
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
```
