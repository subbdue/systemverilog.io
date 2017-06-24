`timescale 1ns/1ps
/**
 * A simple testbench to test the working of the crc_gen module
 *
 * We create 3 instances of the crc_gen module each selecting one
 * of the 3 CRC polynomials. The same data array is injected into 
 * each of the 3 instances and the CRC output in observed.
 *
 * USAGE:
 * + make run   -> Run without waves
 * + make waves -> Dump waves if using Synopsys VCS
 * + make clean -> Delete logs and working dirs
 */
module tb_crc_gen;

logic           clk;
logic           rst;
logic           start;
logic           done;
logic [7:0]     data_in;
logic [15:0]    crc_in;
logic [15:0]    crc_out[3];

logic [7:0]     darray[8];

/* Enable waves by passing +define+SNPS on the cmdline */
`ifdef SNPS
initial 
    $vcdpluson;
`endif

/* Clock gen */
initial begin
    clk = 0;
    forever #1ns clk = ~clk;
end

/* Drive test data */
initial begin
    // apply reset
    reset();

    // Calculate CRC for an 8 byte chunk 
    darray = '{8'ha1, 8'ha2, 8'ha3, 8'ha4, 8'hff, 8'h12, 8'h43, 8'h99};
    driver(darray);

    // Calculate CRC for another 8 byte chunk 
    repeat(4) @(posedge clk);
    darray = '{8'h11, 8'h22, 8'h33, 8'h44, 8'h91, 8'h87, 8'ha9, 8'h60};
    driver(darray);

    repeat(10) @(posedge clk);
    $finish;
end

/*
 * Reset
 */
task reset;
    rst     <= 1;
    start   <= 0;
    done    <= 0;
    data_in <= 0;
    crc_in  <= 0;
    repeat(10) @(posedge clk);
    rst     <= 0;
    repeat(10) @(posedge clk);
endtask: reset

/*
 * Main interface driver
 */
task driver;
    input logic [7:0] din[8];

    for (int i=0; i < 8; i++) begin
        start <= ( i== 0) ? 1 : 0;
        data_in <= din[i];
        @(posedge clk);
    end
    done <= 1;
    data_in <= 0;
    @(posedge clk);
    print_crc_out();
    done <= 0;
    @(posedge clk);
endtask: driver

/*
 * Print convenience function
 */
function automatic void print_crc_out;
    string str, s;

    $display("=== Printing outputs from all 3 CRC blocks ===");
    for (int i=0; i<8; i++) begin
        $sformat(s, "0x%x ", darray[i]);
        str = {str, s};
    end
    $display("Data In: %s", str);
    for (int i=0; i < 3; i++) begin
        $display("crc_out[%0d] = 0x%x", i, crc_out[i]);
    end
endfunction: print_crc_out

/*
 * 3 instances of crc_gen module each with a different
 * CRC_SEL parameter selected
 */
genvar k;
generate 
    for (k=0; k < 3; k++) begin: crc_gen_blk
        crc_gen #(k) icrc_gen
        (
            .clk(clk),
            .rst(rst),
            .start(start),
            .done(done),
            .data_in(data_in),
            .crc_in(crc_out[k]),
            .crc_out(crc_out[k])
        ); 
    end
endgenerate
endmodule: tb_crc_gen
