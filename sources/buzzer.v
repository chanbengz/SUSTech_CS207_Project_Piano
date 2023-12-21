// Control the pwm signal of the buzzer
`include "const.v"

module buzzer(
    input       clk,
    input [4:0] note,
    output      speaker
    );

wire [31:0] notes [21:0];
reg  [31:0] cnt;
reg         pwm;

assign notes[0]  = 0;
assign notes[1]  = `L1; // C3
assign notes[2]  = `L2; // D3
assign notes[3]  = `L3; // E3
assign notes[4]  = `L4; // F3
assign notes[5]  = `L5; // G3
assign notes[6]  = `L6; // A3
assign notes[7]  = `L7; // B3
assign notes[8]  = `M1; // C4
assign notes[9]  = `M2; // D4
assign notes[10] = `M3; // E4
assign notes[11] = `M4; // F4
assign notes[12] = `M5; // G4
assign notes[13] = `M6; // A4
assign notes[14] = `M7; // B4
assign notes[15] = `H1; // C5
assign notes[16] = `H2; // D5
assign notes[17] = `H3; // E5
assign notes[18] = `H4; // F5
assign notes[19] = `H5; // G5
assign notes[20] = `H6; // A5
assign notes[21] = `H7; // B5

initial begin
    pwm = 0;
    cnt = 0;
end

always @(posedge clk) begin
    if((cnt < notes[note]) | note == 0) begin
        cnt <= cnt + 1'b1;
    end else begin
        pwm =~ pwm;
        cnt <= 0;
    end
end
assign speaker = pwm;

endmodule