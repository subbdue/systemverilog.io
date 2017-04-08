module calculate (
    input logic rst,
    input logic clk,
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    input logic [1:0] op_type,
    output logic [63:0] z
);


    always_ff @(posedge clk)
    begin
        if (rst) begin
            z <= 0;
        end
        else begin
            if (op_type == 2'h1) begin
                z <= a + b - c;
            end
            else if (op_type == 2'h2) begin
                z <= a - b - c;
            end
            else begin
                z <= a + b + c;
            end
        end
    end
endmodule
