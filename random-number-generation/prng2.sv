/*
 * Article:
 *  Deep Dive: SystemVerilog Randomization & Random Number Generation
 *
 * Description:
 *  Code used in example 2 
 *
 * Run instructions:
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 * example 2.1: ./run_vcs.sh prng2.sv +define+EX_2_1
 * example 2.2: ./run_vcs.sh prng2.sv +define+EX_2_2 +SEED=20
 */
program automatic test;
    initial begin
        int unsigned var_a, var_d;
        logic [63:0] var_b;
        logic [7:0] var_c;
        int seed;

        `ifdef EX_2_1
        var_a = $urandom();
        var_c = $urandom_range(10, 20);
        $display("var_a 0x%x var_c 0x%x", var_a, var_c);

        var_b = $urandom();
        $display("Using $urandom() to randomize 64bit var, var_b = 0x%x", var_b);

        var_b = {$urandom(), $urandom()};
        $display("Using shifted $urandom(), var_b = 0x%x", var_b);

        std::randomize(var_b);
        $display("std::randomize(var_b) = 0x%x", var_b);
        `endif
         
        `ifdef EX_2_2
        if ($value$plusargs("SEED=%d", seed)) begin
            $display("SEED entered %0d", seed);
        end else begin
            seed = 0;
        end
        if (seed != 0) begin
            var_a = $urandom(seed);
        end else begin
            var_a = $urandom();
        end
        var_b = $urandom();
        var_d = $urandom_range(10, 2000);
        $display("var_a 0x%x var_b 0x%x var_d 0x%x", var_a, var_b, var_d);
        `endif
    end
endprogram
