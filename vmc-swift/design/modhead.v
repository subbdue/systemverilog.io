

module OPERATOR_IP(rst, clk, reg_addr, reg_wr_data, reg_wr, a, b, c, z);

input				rst;
input				clk;
input		[31:0]		reg_addr;
input		[31:0]		reg_wr_data;
input				reg_wr;
input		[31:0]		a;
input		[31:0]		b;
input		[31:0]		c;
output		[63:0]		z;

logic				rst;
logic				clk;
logic		[31:0]		reg_addr;
logic		[31:0]		reg_wr_data;
logic				reg_wr;
logic		[31:0]		a;
logic		[31:0]		b;
logic		[31:0]		c;
logic		[63:0]		z;



    OPERATOR_IP_SWIFT SWIFT_WRAPPER(
	 rst ,
	 clk ,
	 reg_addr ,
	 reg_wr_data ,
	 reg_wr ,
	 a ,
	 b ,
	 c ,
	 z
    );


endmodule
