module light_7seg(
    input [3:0] seg_in,
    output reg [7:0] seg_out
    );
    
    always @(*) begin
        case(seg_in)
            4'b0000: seg_out = 8'b1111_1100; // Display '0' for first song
            4'b0001: seg_out = 8'b0110_0000; // Display '1' for second song
            4'b0010: seg_out = 8'b1101_1010; // Display '2' for third song
            4'b0011: seg_out = 8'b1111_0010; // Display '3' for replay
            4'b0100: seg_out = 8'b0000_1010; // Display 'R'
            4'b0101: seg_out = 8'b1011_0110; // Display 'S' for study mode
            4'b0110: seg_out = 8'b0110_1110; // Display 'H'
            4'b0111: seg_out = 8'b0001_1100; // Display 'L'
//            4'b1000: seg_out = 8'b1111_1110; // Display '8'
//            4'b1001: seg_out = 8'b1110_0110; // Display '9'
            4'b1010: seg_out = 8'b1110_1110; // Display 'A' for autoplay mode
            4'b1011: seg_out = 8'b0011_1110; // Display 'B'
            4'b1100: seg_out = 8'b1001_1100; // Display 'C'
            // 4'b1101: seg_out = 8'b0111_1010; // Display 'D'
            4'b1110: seg_out = 8'b1001_1110; // Display 'E'
            4'b1111: seg_out = 8'b1000_1110; // Display 'F' for freeplay mode
            default: seg_out = 8'b0000_0000; // Display nothing
        endcase
    end
endmodule
