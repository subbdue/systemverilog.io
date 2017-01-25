/*
 * Article:
 *  SystemVerilog Random Stability
 *
 * Description:
 *  This file has example 1.1
 * 
 * Run instructions
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 *  ./run_vcs.sh randomstability1.sv
 */
program automatic test;
    class pkt;
        int unsigned class_var_a;
        string name;

        function new(string name="p");
            this.name = name;
        endfunction: new

        function int unsigned getrand();
            process local_proc;

            local_proc = process::self();
            $display("%s: class-function randstate %s", name, local_proc.get_randstate());
        endfunction
    endclass: pkt

    initial begin
        int unsigned var_a;
        pkt p;
        process pp, pt;
        string pp_randstate, pc_randstate, pt_randstate;

        // Get handle to program-block's process
        pp = process::self();
        // Get and print program-block's RNG's randstate
        pp_randstate = pp.get_randstate();
        $display("program-block randstate %s", pp_randstate);

        fork
        begin
            // Get handle to thread's process
            pt = process::self();
            // Get thread's internal RNG randstate
            pt_randstate = pt.get_randstate();
            $display("thread-block randstate %s", pt_randstate);
        end
        join

        p = new("p");
        // Classes have an in-built process defined. You can get object's
        // .. internal RNG's randstate by calling obj.get_randstate.
        pc_randstate = p.get_randstate();
        $display("class-object randstate %s", pc_randstate);

        // This function call is a process is itself. Within this function
        // .. we can fetch the process handle and print randstate
        p.getrand();
    end
endprogram
