`timescale 1ns / 1ps

module main(
    input clk,
    input [2:0] button,   // 0: prev, 1: pause, 2: next
    input [2:0] mode,     // 010: auto, 011: manual, 110: study
    input [6:0] key,      // 6: do, 5: re, 4: mi, 3: fa, 2: sol, 1: la, 0: si
    input [1:0] pitch,    // 0: low, 1: high
    output reg [7:0] led,
    output [7:0] seg_en,
    output [7:0] seg_ctrl1,
    output [7:0] seg_ctrl2,
    output speaker
    );

    wire rst;
    assign rst = 1;
    seg_display(.clk(clk), .rst_n(rst), .seg_en(seg_en), .seg_out0(seg_ctrl1), .seg_out1(seg_ctrl2));
    // auto_player a(.clk(clk), .rst_n(rst), .song_num(song_num), .pwn(speaker));

endmodule