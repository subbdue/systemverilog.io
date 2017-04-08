module registers (
    input logic rst,
    input logic clk,
    input logic [31:0] reg_addr,
    input logic [31:0] reg_wr_data,
    input logic reg_wr,
    output logic [1:0] op_type
);

    logic [31:0] reg_op_ctrl;
    logic [31:0] reg_op_ctrl_d;

    assign op_type = reg_op_ctrl[1:0];

    assign reg_op_ctrl_d = (reg_addr == 32'd10 & reg_wr) ? reg_wr_data : reg_op_ctrl; 

    always_ff @(posedge clk)
    begin
        if (rst) begin
            reg_op_ctrl <= 0;
        end
        else begin
            reg_op_ctrl <= reg_op_ctrl_d;
        end
    end

    task bd_force_op_type(input logic [1:0] value);
        force op_type = value;
    endtask: bd_force_op_type
endmodule
