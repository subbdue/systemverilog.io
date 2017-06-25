# Article
SystemVerilog Generate Construct

# Run instructions

## Example 1: 16 input mux 

This is a simple example. Compile and simulate like you usually would with your simulator of choice

    vcs -sverilog -full64 tb_mux_16.sv mux_16.sv
    ./simv

## Example 2.1: conditional generate

Related file is `conditional_generate.sv`. There's no sample TB for this example, it mainly meant for demonstration purposes. The code itself compiles though. Feel free to write a TB around it and experiment with the code.

## Example 2.1: crc polynomial select

Related files are `crc_gen.sv`, `tb_crc_gen.sv` and `Makefile`.

The Makefile is setup to run with Synopsys VCS. To run this example:
    
    make run   -> Run without waves
    make waves -> Dump waves if using Synopsys VCS
    make clean -> Delete logs and working dirs

