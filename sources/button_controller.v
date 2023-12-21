// Control the song number and pause/play
`include "const.v"

module button_controller(
    input            clk,
    input [2:0]      mode,       // 011: auto, 001: manual, 111: learning
    input [2:0]      button,
    output reg       pause,
    output reg [1:0] song_num
    );
    
    reg [24:0] cnt1, cnt2, cnt3; // Counters for button 0, 1, 2
    parameter gap = `GAP;        // Gap between two button presses
    
    initial begin
        song_num = 0;
        pause = 0;
    end
    
    always @(posedge clk) begin
        if(mode != 3'b011 | mode != 3'b111) begin
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
        if(mode != 3'b011) begin
            pause <= 0;
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