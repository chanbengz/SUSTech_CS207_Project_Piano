// Select the signals of the 7-segment display, LEDs and speaker by the mode

module sig_sel(
    input            clk, rst_n,                   // clock, reset
    input      [2:0] mode,                         // 011: auto, 001: manual, 111: learning
    input      [1:0] song_num,                     // song number
    input            speaker1, speaker2, speaker3, // speaker
    input      [7:0] led1, led2,                   // led
    output reg       speaker,                      // speaker
    output     [7:0] seg_en, seg_out0, seg_out1,   // seg_tube
    output reg [7:0] led
    );

     reg [3:0] p0, p1, p2, p3, p4, p5, p6, p7; // 7-segment display
     seg_display(.clk(clk),
                 .rst_n(rst_n),
                 .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),
                 .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
                 );

    // Selector
    always @(mode) begin
        case(mode)
            3'b011: begin // auto
                p7 = 'hA;
                p6 = {2'b00, song_num};
                {p5, p4, p3, p2, p1, p0} = 'hDDDDDD;
                led = led1;
                speaker = speaker1;
            end
            3'b001: begin // manual
                {p7, p6, p5, p4} = 'hF4EE;
                {p3, p2, p1, p0} = 'hDDDD;
                speaker = speaker2;
            end
            3'b111: begin // learning
                led = led2;
                speaker = speaker3;
            end
            default: begin
                {p7, p6, p5, p4, p3} = 'h6E770; // hello message
                {p2, p1, p0} = 'hDDD; // empty
                led = 8'b0000_0000;
                speaker = 0;
            end
        endcase
    end

endmodule