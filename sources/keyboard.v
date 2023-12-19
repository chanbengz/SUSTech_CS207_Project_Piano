module keyboard(
    input [6:0] key,
    input clk, rst_n,
    output speaker
    );

reg [4:0] note;
buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

always @(key, rst_n) begin
    if(!rst_n) begin
        note = 0;
    end else begin
        case(key)
            7'b0000001: note = 8;
            7'b0000010: note = 9;
            7'b0000100: note = 10;
            7'b0001000: note = 11;
            7'b0010000: note = 12;
            7'b0100000: note = 13;
            7'b1000000: note = 14;
            default: note = 0;
        endcase
    end
end

endmodule