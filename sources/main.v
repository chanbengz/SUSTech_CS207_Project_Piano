`timescale 1ns / 1ps

module main(
    input clk, rst,
    input [2:0] button,   // 0: prev, 1: pause, 2: next
    input [2:0] mode,     // 011: auto, 001: manual, 111: study
    input [6:0] key,      // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input [1:0] pitch,    // 0: low, 1: high
    output [7:0] led, seg_en, seg_out0, seg_out1,
    output speaker, pwm_ctrl
    );
    
    parameter song_num = 0, rst1 = 1;;
    assign pwm_ctrl = 0;
    assign led[7] = rst;
    wire [3:0] p0, p1, p2, p3, p4, p5, p6, p7;

    // seg_display(.clk(clk),
    //             .rst_n(rst),
    //             .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),
    //             .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
    //             );
    keyboard keyboard(.key(key), .clk(clk), .rst_n(rst1), .speaker(speaker));

endmodule