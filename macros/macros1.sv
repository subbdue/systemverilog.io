/*
 * Article:
 *  SystemVerilog Macros
 *
 * Description:
 *  This file has examples 1.1, 1.2 and 1.3. The run command will run
 *  all 3 examples
 * 
 * Run instructions
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 *  ./run_vcs.sh macros1.sv
 */
/* Example 1.1 */
`define simplemacro $display("\n This is a simple macro\n");
`define append_front_1_bad(MOD) "MOD.master"
`define append_front_1_good(MOD) `"MOD.master`"

/* Example 1.2 */
`define append_front_2a(MOD) `"MOD.master`"
`define append_front_2b(MOD) `"MOD master`"
`define append_front_2c_bad(MOD) `"MOD_master`"
`define append_front_2c_good(MOD) `"MOD``_master`"
`define append_middle(MOD) `"top_``MOD``_master`"
`define append_end(MOD) `"top_``MOD`"
`define append_front_3(MOD) `"MOD``.master`"

/* Example 1.3 */
`define complex_string(ARG1, ARG2) \
    `"This `\`"Blue``ARG1`\`" is Really `\`"ARG2`\`"`"

program automatic test;
    initial begin
        /* Example 1.1 */
        `simplemacro
        $display(`append_front_1_bad(clock1));
        $display(`append_front_1_good(clock1));
        
        /* Example 1.2 */
        $display(`append_front_2a(clock2a));
        $display(`append_front_2b(clock2b));
        $display(`append_front_2c_bad(clock2c));
        $display(`append_front_2c_good(clock2c));
        $display(`append_front_3(clock3));
        $display(`append_middle(clock4));
        $display(`append_end(clock5));

        /* Example 1.3 */
        $display(`complex_string(Beast, Black));
    end
endprogram: test
