/*
 * Article:
 *  SystemVerilog Randomization & Random Number Generation
 *
 * Description:
 *  Code used in example 1 
 *
 * Run instructions:
 *  This code has been run with Synopsys VCS and with Mentor Graphics Questa Sim.
 *  General format
 *  ./run_vcs.sh prng1.sv +define+<example_number> +SEED=<seed>
 *  ./run_questa.sh prng1.sv +define+<example_number> +SEED=<seed>
 *
 *  For example:
 *  ./run_vcs.sh prng1.sv +define+EX_1_1 +SEED=20
 *  ./run_questa.sh prng1.sv +define+EX_1_1 +SEED=20
 *
 * ARG1 (Required): +define+<example_number> 
 *  The <example_number> argument corresponds to the example number in
 *  the article. So, to run example 1.2 you have to pass the command
 *  line arg +define+EX_1_2
 * 
 * ARG2 (Optional): +SEED=<seed>
 *  This is an optional argument, use it if the example involves using it.
 *
 * Commands to run each example:
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 * example 1.1: ./run_vcs.sh prng1.sv +define+EX_1_1 
 * example 1.2: ./run_vcs.sh prng1.sv +define+EX_1_2
 * example 1.3: ./run_vcs.sh prng1.sv +define+EX_1_3
 * example 1.4: ./run_vcs.sh prng1.sv +define+EX_1_4
 * example 1.5A:./run_vcs.sh prng1.sv +define+EX_1_5A +SEED=20
 * example 1.5B:./run_vcs.sh prng1.sv +define+EX_1_5B +SEED=20
 */
program automatic test;
    class pkt;
        rand logic [7:0] saddr, daddr;
        rand logic [3:0] etype;
        logic [15:0] pkt_size;

        function new();
            pkt_size = 100; 
        endfunction: new
        
        function logic [7:0] get_num();
            logic [7:0] scope_var;

            `ifdef EX_1_1
            // Using the class's in-built randomize
            randomize(pkt_size);
            // Using SV std lib's scope randomize
            std::randomize(scope_var);
            `endif

            `ifdef EX_1_2
            /* Interchanging the class & scope randomize usage */
            // Using SV std lib's scope randomize
            std::randomize(pkt_size);
            // Using the class's in-built randomize
            randomize(scope_var);
            `endif

            `ifdef EX_1_3
            // Using the class's in-built randomize
            randomize(pkt_size) with {
                pkt_size inside {[10:50]};
            };
            // Using SV std lib's scope randomize
            std::randomize(scope_var) with {
                scope_var inside {10, 20, 30};
            };
            `endif

            $display("pkt.get_num: pkt_size %0d scope_var %0d", pkt_size, scope_var);
        endfunction: get_num

        function void seeding(int seed);
            logic [7:0] scope_var;
            $display("seeding: seed is %0d", seed);
            // Call srandom only if the seed arg is non-zero
            if (seed != 0)
                srandom(seed);
            randomize(pkt_size);
            std::randomize(scope_var);

            $display("pkt.seeding: pkt_size %0d scope_var %0d", pkt_size, scope_var);
        endfunction: seeding
    endclass: pkt

    initial begin
        pkt p;
        int unsigned var_a;
        logic [47:0] var_b;
        logic [7:0] var_c;
        integer seed;

        $display("running test");
        p = new();

        `ifndef EX_1_4
            `ifndef EX_1_5A `ifndef EX_1_5B
            // Don't call this piece of code for examples 1.4, 1.5A & 1.5B
                p.get_num();
            `endif `endif
        `elsif EX_1_4
        for (int i=0; i<5; i++) begin
            /* Calling randomize() on an object does not randomize 
             * non-rand variables
             */
            p.randomize();
            $display("p[%0d] -> saddr %d, daddr %d, etype %d, pkt_size %d",
                i ,p.saddr, p.daddr, p.etype, p.pkt_size);
        end
        `endif

        `ifdef EX_1_5A
        if ($value$plusargs("SEED=%d", seed)) begin
            $display("SEED entered %0d", seed);
        end else begin
            seed = 0;
        end
        p.seeding(seed);
        `endif

        `ifdef EX_1_5B
        if ($value$plusargs("SEED=%d", seed)) begin
            $display("SEED entered %0d", seed);
        end else begin
            seed = 0;
        end
        p.srandom(seed);
        // Pass seed function arg as 0 so that the seeding function
        // does not call srandom.
        p.seeding(0);
        `endif

        `ifdef EX_1_6
        for (int i=0; i<5; i++) begin
            p.randomize();
            $display("p[%0d] -> saddr %d, daddr %d, etype %d",
                i ,p.saddr, p.daddr, p.etype);
        end
        std::randomize(var_a, var_c);
        $display("var_a 0x%x var_c 0x%x", var_a, var_c);
        `endif

    end
endprogram
