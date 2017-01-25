/*
 * Article:
 *  SystemVerilog Random Stability
 *
 * Description:
 *  This file has example 3.1 and 3.2
 * 
 * Run instructions
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 *  ./run_vcs.sh randomstability3.sv +define+EX_3 +define+EX_3_1
 *  ./run_vcs.sh randomstability3.sv +define+EX_3 +define+EX_3_2
 */

`ifdef EX_3
program automatic test;
    class pkt;
        rand int randvar;
    endclass:pkt

    initial begin
        int unsigned var_a;
        process pp, pt, pc;
        string pp_randstate, pt_randstate, pc_randstate;
        pkt p;

        // Record the state of the program block's RNG right
        // at the beginning of the initial block
        pp = process::self();
        pp_randstate = pp.get_randstate();
        $display("program-block randstate %s", pp_randstate);

        
        `ifdef EX_3_1
        // Generate 5 random numbers using the program-block's
        // Random Number Generator (RNG)
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("program-block var_a %d", var_a);
        end

        fork
        begin
            // Since sofar we've generated 5 random numbers using
            // the program-block's RNG, 
            // this thread's RNG state gets initialized by the
            // 6th random number of the program-block's RNG
            pt = process::self();
            pt_randstate = pt.get_randstate();
            $display("thread-block randstate %s", pt_randstate);
            for (int ii=0; ii<5; ii++) begin
                var_a = $urandom();
                $display("thread var_a %d", var_a);
            end
        end
        join
        `endif

        `ifdef EX_3_2
        // Generate 5 random numbers using the program-block's
        // Random Number Generator (RNG)
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("program-block var_a %d", var_a);
        end

        fork
        begin
            // This thread's RNG state gets initialized by the
            // 6th random number of the program-block's RNG,
            // but we over-write this RNG's state to `pp_randstate`
            // which was the program-block's state at the start of
            // execution.
            // Observe the output the 5 random numbers generated 
            // below should be the same as the above for-loop.
            pt = process::self();
            pt.set_randstate(pp_randstate);
            pt_randstate = pt.get_randstate();
            $display("thread-block randstate %s", pt_randstate);
            for (int ii=0; ii<5; ii++) begin
                var_a = $urandom();
                $display("thread var_a %d", var_a);
            end
        end
        join
        `endif
    end
endprogram
`endif
