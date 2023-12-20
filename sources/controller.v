module controller(
    input clk,
    input [2:0] button,
    output reg [1:0] song_num
    );    
    wire [2:0] mode_out;
    reg [15:0] cnt1, cnt2;
    initial begin
        song_num = 0;
    end
    
    always @(posedge clk) begin
        if(button[0]) cnt1 <= cnt1 + 16'b1;
        else cnt1 <= 16'b0;
        if(button[2]) cnt2 <= cnt2 + 16'b1;
        else cnt2 <= 16'b0;
        if(cnt1 == 16'hFFFF)
            song_num <= song_num - 2'b1;
        else if(cnt2 == 16'hFFFF)
            song_num <= song_num + 2'b1;
        else
            song_num <= song_num;
    end

endmodule