// Select the signals of the 7-segment display, LEDs and speaker by the mode
`include "const.v"

module main_controller(
    input            clk, rst_n,                   // clock, reset
    input      [2:0] mode,                         // 011: auto, 001: manual, 111: learning
    input      [1:0] song_num,                     // song number
    input            pause,
    input      [6:0] key,
    input      [1:0] pitch,
    output reg       speaker,                      // speaker
    output     [7:0] seg_en, seg_out0, seg_out1,   // seg_tube
    output reg [7:0] led
    );

    wire       speaker1, speaker2, speaker3; // speaker
    wire [7:0] led1, led2;                   // led
    reg  [3:0] p0, p1, p2, p3, p4, p5, p6, p7; // 7-segment display

    auto_player auto_player(.clk(clk), .mode(mode), .pause(pause), .song_num(song_num), .speaker(speaker1), .led(led1));
    keyboard keyboard(.key(key), .clk(clk), .pitch(pitch), .mode(mode), .speaker(speaker2));
    seg_display(.clk(clk),
                 .rst_n(rst_n),
                 .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),
                 .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
                 );

    // Selector
    always @(mode) begin
        case(mode)
            3'b011: begin // auto
                {p7, p6, p5, p4} = `AUTO; // Auto message
                p0 = {2'b00, song_num};
                {p3, p2, p1} = 'hDDD;
                led = led1;
                speaker = speaker1;
            end
            3'b001: begin // manual
                {p7, p6, p5, p4} = `FREE;
                {p3, p2, p1, p0} = 'hDDDD;
                led = 0;
                speaker = speaker2;
            end
            3'b111: begin // learning
                {p7, p6, p5, p4} = 'h7EA4;
                led = led2;
                speaker = speaker3;
            end
            default: begin
                {p7, p6, p5, p4, p3} = 'h6E770; // HELLO message
                {p2, p1, p0} = 'hDDD; // empty
                led = 8'b0000_0000;
                speaker = 0;
            end
        endcase
    end

endmodule