`timescale 1ns / 1ps

module main(
    input clk, rst_n,
    input [2:0] button,                             // 0: prev, 1: pause, 2: next
    input [2:0] mode,                               // 011: auto, 001: manual, 111: study
    input [6:0] key,                                // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input [1:0] pitch,                              // 0: low, 1: high
    output [7:0] seg_en, seg_out0, seg_out1,        // seg_tube
    output [7:0] led,                               // led
    output speaker, pwm_ctrl                        // speaker
    );
    
    assign pwm_ctrl = 0;
    wire[1:0] song_num;
    wire speaker1, speaker2, speaker3, led1, led3, pause;

    sig_sel sig_sel(.clk(clk), .rst_n(rst_n), .mode(mode), .song_num(song_num), .speaker1(speaker1), .speaker2(speaker2), .speaker3(speaker3), .led1(led1), .led2(led3), .speaker(speaker) , .led(led), .seg_en(seg_en), .seg_out0(seg_out0), .seg_out1(seg_out1));
    auto_player auto_player(.clk(clk), .mode(mode), .pause(pause), .song_num(song_num), .speaker(speaker1), .led(led1));
    keyboard keyboard(.key(key), .clk(clk), .pitch(pitch), .rst_n(mode[0]), .speaker(speaker2));
    controller controller(.clk(clk), .mode(mode), .pause(pause), .button(button), .song_num(song_num));

endmodule