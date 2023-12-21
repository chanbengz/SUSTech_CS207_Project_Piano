// Select the signals of the 7-segment display, LEDs and speaker by the mode
`include "const.v"

module main_controller(
    input            clk, rst_n,                   // clock, reset
    input      [2:0] mode,                         // 011: auto, 001: manual, 111: learning
    input      [1:0] song_num,                     // song number
    input            pause,                        // pause signal
    input      [6:0] key,                          // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input      [1:0] pitch,                        // 01: low, 00:middle, 10: high
    input      [1:0] user,                         // 00: user1, 01: user2, 10: user3, 11: user4
    output reg       speaker,                      // speaker
    output     [7:0] seg_en, seg_out0, seg_out1,   // seg_tube
    output reg [7:0] led
    );

    wire        speaker1, speaker2, speaker3;      // speaker
    wire [7:0]  led1, led2;                        // led
    reg  [4:0]  p0, p1, p2, p3, p4, p5, p6, p7;    // 7-segment display
    wire        finished;
    wire [32:0] score;
    wire [4:0]  score_dis0, score_dis1, score_dis2, score_dis3;
    reg  [32:0] record [3:0];

    initial begin
        record[0] = 0;
        record[1] = 0;
        record[2] = 0;
        record[3] = 0;
    end

    auto_player auto_player (.clk(clk), .mode(mode), .pause(pause), .song_num(song_num), .speaker(speaker1), .led(led1));
    keyboard    keyboard    (.key(key), .clk(clk), .pitch(pitch), .mode(mode), .speaker(speaker2));
    learning    learning    (.clk(clk),
                            .key(key),
                            .pitch(pitch),
                            .mode(mode),
                            .song_num(song_num),
                            .speaker(speaker3),
                            .led(led2),
                            .finished(finished),
                            .score(score),
                            .pitch_dis(pitch_dis),
                            );
    seg_display seg_display (.clk(clk),
                            .rst_n(rst_n),
                            .p0(p0), .p1(p1), .p2(p2), .p3(p3), .p4(p4), .p5(p5), .p6(p6), .p7(p7),
                            .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
                            );
    score2level score2level (.score(record[{user, song_num}]), .p0(score_dis0), .p1(score_dis1), .p2(score_dis2), .p3(score_dis3));

    // Selector
    always @(mode) begin
        case(mode)
            3'b011: begin // auto
                {p7, p6, p5, p4} = `AUTO; // Auto message
                p0 = {3'b000, song_num};
                {p3, p2, p1} = `EMPTY3; // empty
                led = led1;
                speaker = speaker1;
            end
            3'b001: begin // manual
                {p7, p6, p5, p4} = `FREE;
                {p3, p2, p1, p0} = `EMPTY4; // empty
                led = 0;
                speaker = speaker2;
            end
            3'b111: begin // learning
                if(!finished) begin
                    {p7, p6, p5} = `LRN;
                    {p3, p2, p1, p0} = {score_dis3, score_dis2, score_dis1, score_dis0};
                    led = led2;
                end else begin
                    p7 = 5'b11000;  // 'U'
                    p6 = {3'b000, user};
                    p5 = 5'b00101;  // 'S'
                    p4 = {3'b000, song_num};
                    record[{user, song_num}] = score;
                    {p3, p2, p1, p0} = {score_dis3, score_dis2, score_dis1, score_dis0};
                end
                speaker = speaker3;
            end
            default: begin
                {p7, p6, p5, p4, p3} = `HELLO;
                {p2, p1, p0} = `EMPTY3; // empty
                led = 8'b0000_0000;
                speaker = 0;
            end
        endcase
    end

endmodule