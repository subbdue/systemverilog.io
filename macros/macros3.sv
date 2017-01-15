/*
 * Article:
 *  SystemVerilog Macros
 *
 * Description:
 *  Example 3 - observe the compile time warning flagged due to
 *  macro re-definition
 * 
 * Run instructions
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 *  ./run_vcs.sh macros3.sv
 */
program automatic test;
    class base;
        `define debug(msg) $display("%s, %0d: %s", `__FILE__, `__LINE__, msg)
    endclass: base

    class child;
        `define debug(msg) $display("Overwritten>>%s, %0d: %s", `__FILE__, `__LINE__, msg)
        function void printvar(string msg);
            `debug(msg);
        endfunction: printvar
    endclass: child


    initial begin
        child c;

        c = new();
        c.printvar("test");
    end
endprogram: test
