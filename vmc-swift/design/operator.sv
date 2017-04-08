module operator (
    input logic rst,
    input logic clk,
    input logic [31:0] reg_addr,
    input logic [31:0] reg_wr_data,
    input logic reg_wr,
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] c,
    output logic [63:0] z
);

    logic [1:0] op_type;
    logic [31:0] reg_addr_d;
    logic [31:0] reg_wr_data_d;
    logic reg_wr_d;
    logic [31:0] a_d;
    logic [31:0] b_d;
    logic [31:0] c_d;
    logic [63:0] z_d;


    always_ff @(posedge clk)
    begin
        if (rst) begin
            a_d <= 0;
            b_d <= 0;
            c_d <= 0;
            reg_addr_d <= 0;
            reg_wr_data_d <= 0;
            reg_wr_d <= 0;
            z <= 0;
        end
        else begin
            a_d <= a;
            b_d <= b;
            c_d <= c;
            reg_addr_d <= reg_addr;
            reg_wr_data_d <= reg_wr_data;
            reg_wr_d <= reg_wr;
            z <= z_d;
        end
    end

    calculate ical(
        .clk(clk),
        .rst(rst),
        .a(a_d),
        .b(b_d),
        .c(c_d),
        .z(z_d),
        .op_type(op_type));

    registers ireg(
        .clk(clk),
        .rst(rst),
        .reg_addr(reg_addr_d),
        .reg_wr_data(reg_wr_data_d),
        .reg_wr(reg_wr_d),
        .op_type(op_type));
endmodule
