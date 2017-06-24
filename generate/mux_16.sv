/**
 * 16 input mux
 *
 * Example of how to use Loop Generate Construct
 */
module mux_16(
    input  logic [0:15] [127:0] mux_in,
    input  logic [3:0] select,
    output logic [127:0] mux_out 
);

    logic [0:15] [127:0] temp;

    // The for-loop creates 16 assign statements
    genvar i;
    generate
        for (i=0; i < 16; i++) begin
            assign temp[i] = (select == i) ? mux_in[i] : 0;
        end
    endgenerate

    assign mux_out = temp[0] | temp[1] | temp[2] | temp[3] |
                      temp[4] | temp[5] | temp[6] | temp[7] |
                      temp[8] | temp[9] | temp[10] | temp[11] |
                      temp[12] | temp[13] | temp[14] | temp[15];
endmodule: mux_16
