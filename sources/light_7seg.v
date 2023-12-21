// Convert information to display on SINGLE 7-segment display

module light_7seg(
    input      [5:0] seg_in,  // data to display
    output reg [7:0] seg_out  // 7-segment display
    );
    
    always @(*) begin
        case(seg_in)
            5'b00000: seg_out = 8'b1111_1100; // Display '0' for first song
            5'b00001: seg_out = 8'b0110_0000; // Display '1' for second song
            5'b00010: seg_out = 8'b1101_1010; // Display '2' for third song
            5'b00011: seg_out = 8'b1111_0010; // Display '3' for fourth song
            5'b00100: seg_out = 8'b0110_0110; // Display '4'
            5'b00101: seg_out = 8'b1011_0110; // Display 'S'
            5'b00110: seg_out = 8'b1011_1110; // Display '6'
            5'b00111: seg_out = 8'b1110_0000; // Display '7'
            5'b01000: seg_out = 8'b1111_1110; // Display '8'
            5'b01001: seg_out = 8'b1111_0110; // Display '9'
            5'b01010: seg_out = 8'b1110_1110; // Display 'A'
            5'b01011: seg_out = 8'b0011_1110; // Display 'b'
            5'b01100: seg_out = 8'b1001_1100; // Display 'C'
            5'b01101: seg_out = 8'b0111_1010; // Display 'd'
            5'b01110: seg_out = 8'b1001_1110; // Display 'E'
            5'b01111: seg_out = 8'b1000_1110; // Display 'F'
            5'b10000: seg_out = 8'b0110_1110; // Display 'H'
            5'b10001: seg_out = 8'b0001_1100; // Display 'L'
            5'b10010: seg_out = 8'b0011_1010; // Display 'o'
            5'b10011: seg_out = 8'b0000_1010; // Display 'R'
            5'b10100: seg_out = 8'b0001_1110; // Display 't'
            5'b10101: seg_out = 8'b0011_1000; // Display 'u'
            5'b10110: seg_out = 8'b0010_1010; // Display 'n'
            5'b10111: seg_out = 8'b1110_1100; // Display 'N'
            5'b11000: seg_out = 8'b0111_1100; // Display 'U'
            default:  seg_out = 8'b0000_0000; // Display nothing
        endcase
    end
endmodule
