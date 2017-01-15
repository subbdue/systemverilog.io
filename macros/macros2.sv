/*
 * Article:
 *  SystemVerilog Macros
 *
 * Description:
 *  Example 2 code  
 * 
 * Run instructions
 * (use run_questa.sh instead of run_vcs.sh to run with Mentor simulator):
 *  ./run_vcs.sh macros2.sv
 */
`define test1(A) $display(`"1 Color A`")
`define test2(A=blue, B, C=green) $display(`"3 Colors A, B, C`")
`define test3(A=str1, B, C=green) \
    if (A == "orange")$display("Oooo .. I received an Orange!"); \
    else $display(`"3 Colors %s, B, C`", A);

`define debug1(MODNAME, MSG) \
    $display(`" ``MODNAME`` >> %s, %0d: %s`", `__FILE__, `__LINE__, MSG)
`define debug2(MODNAME, MSG) \
    $display(`"%s >> %s, %0d: %s`", MODNAME, `__FILE__, `__LINE__, MSG)

program automatic test;
    initial begin
        string str1, str2;
        
        str1 = "gray";
        str2 = "orange";

        // No args provided even without default value
        `test1();
        `test2(,,);

        // Passing some args
        `test1(black);
        `test2(,pink,);

        // Passing a var (str1, str2) as an arg
        `test3(str1,mistygreen,babypink);
        `test3(str2,mistygreen,babypink);

        `debug1(program-block, "this is a debug message");
        `debug2("program-block", "this is a debug message");

        /* The following will result in an Error
         * `test2(); // no args provided
         * `test2(,); // insufficient args provided
         *
         * // arg1 is used as a var in an if statement,
         * // This will compile fail because the macro
         * // will expand to *if ( == "orange")*
         * `test(, blue, pink)
         */
    end
    
endprogram: test
