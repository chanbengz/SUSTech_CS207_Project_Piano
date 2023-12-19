`timescale 1ns / 1ps

module main(
    input clk, rst,
    input [2:0] button,                             // 0: prev, 1: pause, 2: next
    input [2:0] mode,                               // 011: auto, 001: manual, 111: study
    input [6:0] key,                                // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input [1:0] pitch,                              // 0: low, 1: high
    output [7:0] seg_en, seg_out0, seg_out1,        // seg_tube
    output reg [7:0] led,
    output speaker, pwm_ctrl                        // speaker
    );
    
    wire song_num;
    assign pwm_ctrl = 0;
    
    // reg [3:0] p0, p1, p2, p3, p4, p5, p6, p7;
    // seg_display(.clk(clk),
    //             .rst_n(rst),
    //             .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),
    //             .seg_en(seg_en),.seg_out0(seg_out0), .seg_out1(seg_out1)
    //             );

    // auto_player auto_player(.clk(clk), .mode(mode), .song_num(song_num), .speaker(speaker1));
    // keyboard keyboard(.key(key), .clk(clk), .pitch(pitch), .rst_n(mode[0]), .speaker(speaker2));
    controller controller(.clk(clk), .button(button), .song_num(song_num));
    always @(song_num) begin
        case(song_num)
            2'b00: {led[4], led[3], led[2], led[1]} = 4'b0001;
            2'b01: {led[4], led[3], led[2], led[1]} = 4'b0010;
            2'b10: {led[4], led[3], led[2], led[1]} = 4'b0100;
            2'b11: {led[4], led[3], led[2], led[1]} = 4'b1000;
        endcase
    end

endmodule