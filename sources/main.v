`timescale 1ns / 1ps

module main(
    input clk,rst,
    input [2:0] button,   // 0: prev, 1: pause, 2: next
    input [2:0] mode,     // 010: auto, 011: manual, 110: study
    input [6:0] key,      // 6: do, 5: re, 4: mi, 3: fa, 2: sol, 1: la, 0: si
    input [1:0] pitch,    // 0: low, 1: high
    output [7:0] led, seg_en, seg_out0, seg_out1,
    output speaker, pwm_ctrl
    );
    
    parameter song_num = 0;
    assign pwm_ctrl = 0;
    assign led[0] = rst;
    wire [3:0] p0, p1, p2, p3, p4, p5, p6, p7;
    assign p0 = 0;
    assign p1 = 1;
    assign p2 = 2;
    assign p3 = 'hA;
    assign p4 = 4;
    assign p5 = 5;
    assign p6 = 6;
    assign p7 = 'hE;
    
    seg_display(.clk(clk),
                .rst_n(rst),
                .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),
                .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
                );
    // auto_player a(.clk(clk), .rst_n(rst), .song_num(song_num), .pwm(speaker));

endmodule