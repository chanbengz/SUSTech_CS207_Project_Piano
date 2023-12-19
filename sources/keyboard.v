module keyboard(
    input [6:0] key,
    input [1:0] pitch,
    input clk, rst_n,
    output speaker
    );

reg [4:0] note;
buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

always @(key, rst_n, pitch) begin
    if(!rst_n) begin
        note = 0;
    end else begin
        case({pitch, key})
            9'b010000001: note = 1;
            9'b010000010: note = 2;
            9'b010000100: note = 3;
            9'b010001000: note = 4;
            9'b010010000: note = 5;
            9'b010100000: note = 6;
            9'b011000000: note = 7;
            9'b000000001: note = 8;
            9'b000000010: note = 9;
            9'b000000100: note = 10;
            9'b000001000: note = 11;
            9'b000010000: note = 12;
            9'b000100000: note = 13;
            9'b001000000: note = 14;
            9'b100000001: note = 15;
            9'b100000010: note = 16;
            9'b100000100: note = 17;
            9'b100001000: note = 18;
            9'b100010000: note = 19;
            9'b100100000: note = 20;
            9'b101000000: note = 21;
            default: note = 0;
        endcase
    end
end

endmodule