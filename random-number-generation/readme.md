## Article:
SystemVerilog Randomization & Random Number Generation

## Description:
Commands to run examples 

## Run instructions:
This code has been run with Synopsys VCS and with Mentor Graphics Questa Sim.
General format

    ./run_vcs.sh prng1.sv +define+<example_number> +SEED=<seed>
    ./run_questa.sh prng1.sv +define+<example_number> +SEED=<seed>

For example:

    ./run_vcs.sh prng1.sv +define+EX_1_1 +SEED=20
    ./run_questa.sh prng1.sv +define+EX_1_1 +SEED=20

ARG1 (Required): `+define+<example_number>` 

 The `<example_number>` argument corresponds to the example number in
 the article. So, to run example 1.2 you have to pass the command
 line arg `+define+EX_1_2`

ARG2 (Optional): `+SEED=<seed>`

 This is an optional argument, use it if the example involves using it.

## Commands to run example 1:
(use `run_questa.sh` instead of `run_vcs.sh` to run with Mentor simulator):
    
    example 1.1: ./run_vcs.sh prng1.sv +define+EX_1_1 
    example 1.2: ./run_vcs.sh prng1.sv +define+EX_1_2
    example 1.3: ./run_vcs.sh prng1.sv +define+EX_1_3
    example 1.4: ./run_vcs.sh prng1.sv +define+EX_1_4
    example 1.5A:./run_vcs.sh prng1.sv +define+EX_1_5A +SEED=20
    example 1.5B:./run_vcs.sh prng1.sv +define+EX_1_5B +SEED=20

## Commands to run example 2:

    example 2.1: ./run_vcs.sh prng2.sv +define+EX_2_1
    example 2.2: ./run_vcs.sh prng2.sv +define+EX_2_2 +SEED=20

## Commands to run example 3:

    example 3.1: ./run_vcs.sh prng3.sv +define+EX_3_1
    example 3.2: ./run_vcs.sh prng3.sv +define+EX_3_2
    example 3.3: ./run_vcs.sh prng3.sv +define+EX_3_3
    example 3.4: ./run_vcs.sh prng3.sv +define+EX_3_4
