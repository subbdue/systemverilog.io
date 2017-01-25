

`ifdef EX_4
program automatic test;
    class pkt;
        rand int randvar;
    endclass:pkt

    initial begin
        int unsigned var_a;
        process pp, pt, pc;
        string pp_randstate, pt_randstate, pc_randstate;
        pkt p;

        pp = process::self();
        pp_randstate = pp.get_randstate();
        $display("program-block randstate %s", pp_randstate);


        `ifdef EX_4_1
        fork
        begin
            pt = process::self();
            $display("thread-block randstate %s", pt.get_randstate());
            pt.srandom(1234);
            $display("Changing thread-block randstate %s", pt.get_randstate());
            for (int ii=0; ii<5; ii++) begin
                var_a = $urandom();
                $display("var_a %d", var_a);
            end
        end
        join
        p = new();
        $display("object's randstate %s", p.get_randstate());
        pt.srandom(6666);
        $display("Changing object's randstate %s", p.get_randstate());
        for(int ii=0; ii<5; ii++) begin
            p.randomize();
            $display("p: p.randvar %d", p.randvar);
        end
        `endif
        
        `ifdef EX_4_2
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("program-block var_a %d", var_a);
        end

        fork
        begin
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

        `ifdef EX_4_3
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("program-block var_a %d", var_a);
        end

        fork
        begin
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

        `ifdef EX_4_4
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("var_a %d", var_a);
        end
        p = new();
        for(int ii=0; ii<5; ii++) begin
            p.randomize();
            $display("p: p.randvar %d", p.randvar);
        end
        `endif

        `ifdef EX_4_5
        for (int ii=0; ii<5; ii++) begin
            var_a = $urandom();
            $display("var_a %d", var_a);
        end

        p = new();
        p.set_randstate(pp_randstate);
        for(int ii=0; ii<5; ii++) begin
            p.randomize();
            $display("p: p.randvar %d", p.randvar);
        end
        `endif
    end
endprogram
`endif
