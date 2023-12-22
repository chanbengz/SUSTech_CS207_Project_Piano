// Convert information to display on SINGLE 7-segment display
`include "const.v"

module light_7seg(
    input      [4:0] seg_in,  // data to display
    output reg [7:0] seg_out  // 7-segment display
    );
    
    always @(*) begin
        case(seg_in)
            `IN0: seg_out = `SEG0; // Display '0' for first song
            `IN1: seg_out = `SEG1; // Display '1' for second song
            `IN2: seg_out = `SEG2; // Display '2' for third song
            `IN3: seg_out = `SEG3; // Display '3' for fourth song
            `IN4: seg_out = `SEG4; // Display '4'
            `IN5: seg_out = `SEG5; // Display 'S'
            `IN6: seg_out = `SEG6; // Display '6'
            `IN7: seg_out = `SEG7; // Display '7'
            `IN8: seg_out = `SEG8; // Display '8'
            `IN9: seg_out = `SEG9; // Display '9'
            `INA: seg_out = `SEGA; // Display 'A'
            `INB: seg_out = `SEGB; // Display 'b'
            `INC: seg_out = `SEGC; // Display 'C'
            `IND: seg_out = `SEGD; // Display 'd'
            `INE: seg_out = `SEGE; // Display 'E'
            `INF: seg_out = `SEGF; // Display 'F'
            `INH: seg_out = `SEGH; // Display 'H'
            `INL: seg_out = `SEGL; // Display 'L'
            `INo: seg_out = `SEGo; // Display 'o'
            `INR: seg_out = `SEGR; // Display 'R'
            `INt: seg_out = `SEGt; // Display 't'
            `INu: seg_out = `SEGu; // Display 'u'
            `INn: seg_out = `SEGn; // Display 'n'
            `INN: seg_out = `SEGN; // Display 'N'
            `INU: seg_out = `SEGU; // Display 'U'
         default: seg_out = 0; // Display nothing
        endcase
    end
endmodule
