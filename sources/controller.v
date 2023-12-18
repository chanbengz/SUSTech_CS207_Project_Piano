module controller(
    input [2:0] button,
    input [2:0] mode,
    output reg [1:0] song_num,
    output reg pause,
    output reg[3:0] rst_sig
);
    reg change_mod;
    assign press = button[0] | button[2] | change_mod;
    
    initial begin
        song_num = 0;
    end

    always @(posedge mode[0] or posedge mode[1] or posedge mode[2]) begin
        if(button[1]) begin
            change_mod <= 1;
        end
        else begin
            change_mod <= 0;
        end
    end

    always @(posedge button[0]) begin
        if(song_num == 0) begin
            song_num <= 2;
        end
        else begin
            song_num <= song_num - 1;
        end
    end

    always @(posedge button[1]) begin
        pause <= ~pause;
    end

    always @(posedge button[2]) begin
        if(song_num == 2) begin
            song_num <= 0;
        end
        else begin
            song_num <= song_num + 1;
        end
    end
    
endmodule