`timescale 1ns/1ps

module tb_top;

    /* Clocks */
    // .. 500MHz
    bit clk, rst, reg_wr;
    logic [31:0] a, b, c, reg_wr_data, reg_addr;
    logic [63:0] z;

    initial begin
        clk = 1'b0;
        forever #1ns clk = ~clk;
    end

    initial begin
        // Apply reset to design
        a = 0;
        b = 0;
        c = 0;
        reg_wr = 0;
        reg_wr_data = 0;
        reg_addr = 0;
        rst = 1'b1;
        #10ns;
        rst = 1'b0;
        #10ns;

        //duv.ireg.bd_force_op_type(3);

        // Configure register to 1 (a+b-c)
        reg_addr = 10;
        reg_wr_data = 1;
        reg_wr = 1;
        #10ns;
        reg_wr = 0;
        #10ns;

        // Calculate result 1
        a = 100;
        b = 50;
        c = 10;
        #10ns;
        $display("z is %0d", z);
        
        // Configure register to 2 (a-b-c)
        #10ns;
        reg_addr = 10;
        reg_wr_data = 2;
        reg_wr = 1;
        #10ns;
        reg_wr = 0;
        #10ns;

        // Calculate result 2
        a = 100;
        b = 50;
        c = 10;
        #10ns;
        $display("z is %0d", z);
        #500ns;
        $finish;

    end

    //operator duv(.*);
    operator_ip duv(.*);
endmodule: tb_top
