// Control the song number and pause/play
`include "const.v"

module button_controller(
    input            clk,        // clock
    input      [2:0] mode,       // 011: auto, 001: manual, 111: learning
    input      [2:0] button,     // 0: prev, 1: pause/play, 2: next
    output reg       pause,      // 0: play, 1: pause
    output reg [1:0] song_num    // 00: song 1, 01: song 2, 10: song 3, 11: song 4
    );
    
    reg [24:0] cnt1, cnt2, cnt3; // Counters for button 0, 1, 2
    parameter gap = `GAP;        // Gap between two button presses
    
    initial begin
        song_num = 0;
        pause = 1;
    end
    
    always @(posedge clk) begin
        if(mode != `MODEAUTO & mode != `MODELRN) begin
            song_num <= 0;
        end else begin
            if(button[0]) cnt1 <= cnt1 + 25'b1;
            else cnt1 <= 25'b0;
            if(button[2]) cnt2 <= cnt2 + 25'b1;
            else cnt2 <= 25'b0;
            if(cnt1 == gap)
                song_num <= song_num - 2'b1;
            else if(cnt2 == gap)
                song_num <= song_num + 2'b1;
            else
                song_num <= song_num;
        end
       
    end
    
    always @(posedge clk) begin
        if(mode != `MODEAUTO) begin
            pause <= 1;
        end else begin
            if(button[1]) cnt3 <= cnt3 + 25'b1;
            else cnt3 <= 25'b0;
            if(cnt3 == gap)
                pause <= ~pause;
            else
                pause <= pause;
        end
    end

endmodule