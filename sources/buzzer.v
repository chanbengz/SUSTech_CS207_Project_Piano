module buzzer(
    input clk,
    input [6:0] note,
    output speaker
    );

wire [31:0] notes [21:0];
reg [31:0] cnt;
reg pwm;

assign notes[1]  = 769230; // C3 
assign notes[2]  = 680272; // D3
assign notes[3]  = 606061; // E3
assign notes[4]  = 571428; // F3
assign notes[5]  = 510204; // G3
assign notes[6]  = 454545; // A3
assign notes[7]  = 404858; // B3
assign notes[8]  = 381680; // C4
assign notes[9]  = 340136; // D4
assign notes[10] = 303030; // E4
assign notes[11] = 285714; // F4
assign notes[12] = 255102; // G4
assign notes[13] = 227272; // A4
assign notes[14] = 202429; // B4
assign notes[15] = 191204; // C5
assign notes[16] = 170357; // D5
assign notes[17] = 151745; // E5
assign notes[18] = 143266; // F5
assign notes[19] = 127713; // G5
assign notes[20] = 113636; // A5
assign notes[21] = 101317; // B5

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