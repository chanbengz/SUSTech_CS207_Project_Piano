`timescale 1ns / 1ps

module main(
    input        clk, rst_n,                   // clock, reset
    input  [2:0] button,                       // 0: prev, 1: pause, 2: next
    input  [2:0] mode,                         // 011: auto, 001: manual, 111: learning
    input  [6:0] key,                          // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
    input  [1:0] pitch,                        // 01: low, 00:middle, 10: high
    output [7:0] seg_en, seg_out0, seg_out1,   // seg_tube
    output [7:0] led,                          // led
    output       speaker, pwm_ctrl             // speaker
    );
    
    assign     pwm_ctrl = 0;                        // not used
    wire [1:0] song_num;                            // song number
    wire       pause;

    main_controller   main_con   (.clk(clk),
                                .rst_n(rst_n), 
                                .mode(mode),
                                .key(key),
                                .pitch(pitch),
                                .song_num(song_num),
                                .pause(pause),
                                .speaker(speaker),
                                .led(led),
                                .seg_en(seg_en),
                                .seg_out0(seg_out0),
                                .seg_out1(seg_out1));

    button_controller button_con (.clk(clk), .mode(mode), .pause(pause), .button(button), .song_num(song_num));

endmodule