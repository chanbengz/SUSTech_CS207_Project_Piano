// Free Mode Top Module
`include "const.v"

module keyboard(
    input       clk,           // Clock
    input [6:0] key,           // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input [1:0] pitch,         // 01: low, 00:middle, 10: high
    input [2:0] mode,          // 011: auto, 001: manual, 111: learning
    output      speaker        // PWM Signal
    );

reg [4:0] note;
buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

always @(key, mode, pitch) begin
    if(mode != `MODEFREE) begin
        note = 0;             // Reset
    end else begin
        case({pitch, key})
            `KEYL1: note = 1;  // C3
            `KEYL2: note = 2;  // D3
            `KEYL3: note = 3;  // E3
            `KEYL4: note = 4;  // F3
            `KEYL5: note = 5;  // G3
            `KEYL6: note = 6;  // A3
            `KEYL7: note = 7;  // B3
            `KEYM1: note = 8;  // C4
            `KEYM2: note = 9;  // D4
            `KEYM3: note = 10; // E4
            `KEYM4: note = 11; // F4
            `KEYM5: note = 12; // G4
            `KEYM6: note = 13; // A4
            `KEYM7: note = 14; // B4
            `KEYH1: note = 15; // C5
            `KEYH2: note = 16; // D5
            `KEYH3: note = 17; // E5
            `KEYH4: note = 18; // F5
            `KEYH5: note = 19; // G5
            `KEYH6: note = 20; // A5
            `KEYH7: note = 21; // B5
           default: note = 0;  // silence
        endcase
    end
end

endmodule