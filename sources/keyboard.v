// Free Mode Top Module

module keyboard(
    input       clk,
    input [6:0] key,   // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input [1:0] pitch, // 01: low, 00:middle, 10: high
    input [2:0] mode,  // 011: auto, 001: manual, 111: learning
    output      speaker
    );

reg [4:0] note;
buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

always @(key, mode, pitch) begin
    if(mode != 3'b001) begin
        note = 0;
    end else begin
        case({pitch, key})
            9'b010000001: note = 1;  // C3
            9'b010000010: note = 2;  // D3
            9'b010000100: note = 3;  // E3
            9'b010001000: note = 4;  // F3
            9'b010010000: note = 5;  // G3
            9'b010100000: note = 6;  // A3
            9'b011000000: note = 7;  // B3
            9'b000000001: note = 8;  // C4
            9'b000000010: note = 9;  // D4
            9'b000000100: note = 10; // E4
            9'b000001000: note = 11; // F4
            9'b000010000: note = 12; // G4
            9'b000100000: note = 13; // A4
            9'b001000000: note = 14; // B4
            9'b100000001: note = 15; // C5
            9'b100000010: note = 16; // D5
            9'b100000100: note = 17; // E5
            9'b100001000: note = 18; // F5
            9'b100010000: note = 19; // G5
            9'b100100000: note = 20; // A5
            9'b101000000: note = 21; // B5
            default:      note = 0;  // silence
        endcase
    end
end

endmodule