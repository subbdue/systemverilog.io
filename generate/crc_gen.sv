/**
 * CRC generator module. Select the desired polynomial
 * using the CRC_SEL parameter.
 * 
 * Default polynomial : x^16 + x^15 + x^2 + 1 
 * CRC_SEL = 0        : x^16 + x^1 + 1
 * CRC_SEL = 1        : x^16 + x^12 + x^5 + 1
 *
 * USAGE:
 * + Strobe `start` when driving the first valid byte
 * + Strobe `done` one clk after driving the last valid byte
 * + The final CRC is available 1 clk after the last valid byte
 *   is driven. This is the same cycle you'll drive `done`.
 *
 * The CRC functions were generated using this online tool
 * http://www.easics.com/services/freesics/crctool.html
 */
module crc_gen
    #(parameter CRC_SEL = 0)
    (
        input  logic clk,
        input  logic rst,
        input  logic start,
        input  logic done,
        input  logic [7:0] data_in,
        input  logic [15:0] crc_in,
        output logic [15:0] crc_out
    );

    logic [7:0]  data_in_d;
    logic [15:0] crc_in_d;

    assign crc_in_d = (start | done) ? 16'd0 : crc_in;
    assign data_in_d = (done) ? 8'd0 : data_in;
    always_ff @(posedge clk) begin
        if (rst) begin
            crc_out <= 'd0;
        end
        else begin
            // Generate blocks are always assigned a name. If
            // you don't name the generate block, it will be
            // given a default auto generated name.
            //
            // To invoke a function within a generate block,
            // hierarchically call it 
            // <generate_blk_name>.<function_name>
            crc_out <= crc_poly.nextCRC16_D8(data_in_d, crc_in_d);
        end
    end

    // Once again the generate-endgenerate keywords are optional
    // It is the act of using a parameter, CRC_SEL, in the case
    // statement that makes it a generate block
    //
    // Also notice how all the generate blocks are given the same
    // name `crc_poly` and all the function names are the same
    // `nextCRC16_D8`. This is correct because only one of the
    // function declarations is compiled in during elaboration
    // phase.
    generate
    case (CRC_SEL)
        0: 
        begin: crc_poly
            // polynomial: x^16 + x^1 + 1
            // data width: 8
            // convention: the first serial bit is D[7]
            function automatic [15:0] nextCRC16_D8;
            
                input [7:0] Data;
                input [15:0] crc;
                reg [7:0] d;
                reg [15:0] c;
                reg [15:0] newcrc;

                d = Data;
                c = crc;
                
                newcrc[0] = d[0] ^ c[8];
                newcrc[1] = d[1] ^ d[0] ^ c[8] ^ c[9];
                newcrc[2] = d[2] ^ d[1] ^ c[9] ^ c[10];
                newcrc[3] = d[3] ^ d[2] ^ c[10] ^ c[11];
                newcrc[4] = d[4] ^ d[3] ^ c[11] ^ c[12];
                newcrc[5] = d[5] ^ d[4] ^ c[12] ^ c[13];
                newcrc[6] = d[6] ^ d[5] ^ c[13] ^ c[14];
                newcrc[7] = d[7] ^ d[6] ^ c[14] ^ c[15];
                newcrc[8] = d[7] ^ c[0] ^ c[15];
                newcrc[9] = c[1];
                newcrc[10] = c[2];
                newcrc[11] = c[3];
                newcrc[12] = c[4];
                newcrc[13] = c[5];
                newcrc[14] = c[6];
                newcrc[15] = c[7];
                nextCRC16_D8 = newcrc;
            endfunction
        end
        1:
        begin: crc_poly
            // polynomial: x^16 + x^12 + x^5 + 1
            // data width: 8
            // convention: the first serial bit is D[7]
            function automatic [15:0] nextCRC16_D8;
            
                input [7:0] Data;
                input [15:0] crc;
                reg [7:0] d;
                reg [15:0] c;
                reg [15:0] newcrc;

                d = Data;
                c = crc;
                
                newcrc[0] = d[4] ^ d[0] ^ c[8] ^ c[12];
                newcrc[1] = d[5] ^ d[1] ^ c[9] ^ c[13];
                newcrc[2] = d[6] ^ d[2] ^ c[10] ^ c[14];
                newcrc[3] = d[7] ^ d[3] ^ c[11] ^ c[15];
                newcrc[4] = d[4] ^ c[12];
                newcrc[5] = d[5] ^ d[4] ^ d[0] ^ c[8] ^ c[12] ^ c[13];
                newcrc[6] = d[6] ^ d[5] ^ d[1] ^ c[9] ^ c[13] ^ c[14];
                newcrc[7] = d[7] ^ d[6] ^ d[2] ^ c[10] ^ c[14] ^ c[15];
                newcrc[8] = d[7] ^ d[3] ^ c[0] ^ c[11] ^ c[15];
                newcrc[9] = d[4] ^ c[1] ^ c[12];
                newcrc[10] = d[5] ^ c[2] ^ c[13];
                newcrc[11] = d[6] ^ c[3] ^ c[14];
                newcrc[12] = d[7] ^ d[4] ^ d[0] ^ c[4] ^ c[8] ^ c[12] ^ c[15];
                newcrc[13] = d[5] ^ d[1] ^ c[5] ^ c[9] ^ c[13];
                newcrc[14] = d[6] ^ d[2] ^ c[6] ^ c[10] ^ c[14];
                newcrc[15] = d[7] ^ d[3] ^ c[7] ^ c[11] ^ c[15];
                nextCRC16_D8 = newcrc;
            endfunction
        end
        default: 
            begin: crc_poly
            // polynomial: x^16 + x^15 + x^2 + 1
            // data width: 8
            // convention: the first serial bit is D[7]
            function automatic [15:0] nextCRC16_D8;
            
                input [7:0] Data;
                input [15:0] crc;
                reg [7:0] d;
                reg [15:0] c;
                reg [15:0] newcrc;

                d = Data;
                c = crc;
                
                newcrc[0] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
                newcrc[1] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
                newcrc[2] = d[1] ^ d[0] ^ c[8] ^ c[9];
                newcrc[3] = d[2] ^ d[1] ^ c[9] ^ c[10];
                newcrc[4] = d[3] ^ d[2] ^ c[10] ^ c[11];
                newcrc[5] = d[4] ^ d[3] ^ c[11] ^ c[12];
                newcrc[6] = d[5] ^ d[4] ^ c[12] ^ c[13];
                newcrc[7] = d[6] ^ d[5] ^ c[13] ^ c[14];
                newcrc[8] = d[7] ^ d[6] ^ c[0] ^ c[14] ^ c[15];
                newcrc[9] = d[7] ^ c[1] ^ c[15];
                newcrc[10] = c[2];
                newcrc[11] = c[3];
                newcrc[12] = c[4];
                newcrc[13] = c[5];
                newcrc[14] = c[6];
                newcrc[15] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[7] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
                nextCRC16_D8 = newcrc;
            endfunction
        end
    endcase
    endgenerate

endmodule: crc_gen
