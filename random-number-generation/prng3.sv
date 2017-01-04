/*
 * Article:
 *  SystemVerilog Randomization & Random Number Generation
 *
 * Description:
 *  Code used in example 3 
 *
 * Run instructions:
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 * example 3.1: ./run_vcs.sh prng3.sv +define+EX_3_1
 * example 3.2: ./run_vcs.sh prng3.sv +define+EX_3_2
 * example 3.3: ./run_vcs.sh prng3.sv +define+EX_3_3
 * example 3.4: ./run_vcs.sh prng3.sv +define+EX_3_4
 */
program automatic test;
    initial begin
        int var_a, var_b, var_c, seed, seed1, seed2, seed3;
        string str, str2;

        `ifdef EX_3_1
        for (int i=0; i<5; i++) begin
            var_a = $random;
            var_b = $dist_poisson(seed, 100);
            $display("%0d -> var_a %d var_b %d", i, var_a, var_b);
        end
        `endif

        `ifdef EX_3_2
        // Using 3 different seed vars for a specific reason. Read the seeding section
        // of the article to find out why.
        seed1 = 10;
        seed2 = 10;
        seed3 = 10;
        for (int i=0; i<5; i++) begin
            var_a = {$random(seed1)}; var_b = $random(seed2)%50; var_c = {$random(seed3)}%50;
            $display("$random %0d -> var_a %d var_b %3d var_c %3d", i, var_a, var_b, var_c);
        end
        `endif

        `ifdef EX_3_3
        seed = 10;
        for (int i=0; i<5; i++) begin
            // "seed" is an INOUT var, calling $random, $dist_normal, etc
            // take the seed as an input and does 2 things on return -
            // 1. returns a 32-bit random number, which is stored in var_a
            // 2. changes the value of "seed" so that the next call to random
            // .. uses this "new" seed set by the previous call to generate the
            // .. next random number. 
            // This is how $random guarantees that for a given starting seed,
            // the sequence of random numbers generated is always the same.
            var_a = $random(seed);
            $display("Loop #%0d. var_a %d next-seed %0d", i, var_a, seed);
        end
        `endif

        `ifdef EX_3_4
        if ($value$plusargs("SEED=%d", seed)) begin
            $display("SEED entered %0d", seed);
        end else begin
            seed = 20;
        end
        seed1 = seed;
        seed2 = seed;
        for (int i=0; i<5; i++) begin
            var_a = $random(seed1); var_b = $random(seed2);
            $display("$random %0d -> var_a %d var_b %d", i, var_a, var_b);
        end
        `endif
    end
endprogram
