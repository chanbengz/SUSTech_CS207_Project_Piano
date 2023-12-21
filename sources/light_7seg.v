// Convert information to display on SINGLE 7-segment display

module light_7seg(
    input      [3:0] seg_in,  // data to display
    output reg [7:0] seg_out  // 7-segment display
    );
    
    always @(*) begin
        case(seg_in)
            4'b0000: seg_out = 8'b1111_1100; // Display '0' for first song
            4'b0001: seg_out = 8'b0110_0000; // Display '1' for second song
            4'b0010: seg_out = 8'b1101_1010; // Display '2' for third song
            4'b0011: seg_out = 8'b1111_0010; // Display '3' for fourth song
            4'b0100: seg_out = 8'b0000_1010; // Display 'R'
            4'b0101: seg_out = 8'b1011_0110; // Display 'S'
            4'b0110: seg_out = 8'b0110_1110; // Display 'H'
            4'b0111: seg_out = 8'b0001_1100; // Display 'L'
            4'b1000: seg_out = 8'b0011_1000; // Display 'u'
            4'b1001: seg_out = 8'b0001_1110; // Display 't'
            4'b1010: seg_out = 8'b1110_1110; // Display 'A'
            4'b1011: seg_out = 8'b0011_1010; // Display 'o'
            4'b1100: seg_out = 8'b1001_1100; // Display 'C'
            4'b1101: seg_out = 8'b0000_0000; // Empty
            4'b1110: seg_out = 8'b1001_1110; // Display 'E'
            4'b1111: seg_out = 8'b1000_1110; // Display 'F'
            default: seg_out = 8'b0000_0000; // Display nothing
        endcase
    end
endmodule
