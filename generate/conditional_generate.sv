/**
 * A simple generate example. Paramerter OPERATION_TYPE,
 * passed when this module is instantiated, is used to select
 * the operation between inputs `a` and `b`.
 */
module conditional_generate
    #(parameter OPERATION_TYPE = 0)
    (
        input  logic [31:0] a,
        input  logic [31:0] b,
        output logic [63:0] z
    );

    // The generate-endgenerate keywords are optional.
    // It is the act of doing a conditional operation
    // on a parameter that makes this a generate block.
    generate
        if (OPERATION_TYPE == 0) begin
            assign z = a + b;
        end
        else if (OPERATION_TYPE == 1) begin
            assign z = a - b;
        end
        else if (OPERATION_TYPE == 2) begin
            assign z = (a << 1) + b; // 2a+b
        end
        else begin
            assign z = b - a;
        end
    endgenerate
endmodule: conditional_generate
