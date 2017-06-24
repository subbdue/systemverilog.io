`timescale 1ns/1ps
/**
 * Testbench to exercise the mux_16 module.
 * Here we instantiate the mux 4 times. Each instance is
 * fed a different input with different input `select` and
 * the output is observed.
 */
module tb_mux_16;

logic               clk;
logic [0:15][127:0] test_in[4];
logic [3:0]         test_select[4];
logic [127:0]       test_out[4];

int i, j, k;

initial begin
    clk = 0;
    forever #1ns clk = ~clk;
end

initial begin
    // Set inputs
    for (i=0; i < 4; i++) begin
        for (j=0; j < 16; j++) begin
            test_in[i][j] = 127'habcd_0000 + (i << 8) + j;
        end
        test_select[i] = i;
    end
    #2ns;
    // Print outputs
    for(k=0; k < 4; k++) begin
        $display("test_out[%0d] = 0x%x", k, test_out[k]);
    end
    #2ns;

    // Change input select 
    for (i=0; i < 4; i++) begin
        test_select[i] = 10 + i;
    end
    #2ns;
    // Print outputs again
    for(k=0; k < 4; k++) begin
        $display("test_out[%0d] = 0x%x", k, test_out[k]);
    end
    #10ns;
    $finish;
end

genvar m;
generate
    for (m=0; m < 4; m++) begin: MUX
       mux_16 imux_16 (
           .mux_in(test_in[m]),
           .select(test_select[m]),
           .mux_out(test_out[m])
       ); 
    end
endgenerate
endmodule: tb_mux_16
