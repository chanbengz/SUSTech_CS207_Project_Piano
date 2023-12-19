module controller(
    input [2:0] button,
    output reg [1:0] song_num
    );
    wire [2:0] button_out, mode_out;
    debouncer d1(.clk(clk), .button(button[0]), .button_out(button_out[0]));
    debouncer d2(.clk(clk), .button(button[1]), .button_out(button_out[1]));
    debouncer d3(.clk(clk), .button(button[2]), .button_out(button_out[2]));
    
    initial begin
        song_num = 0;
    end

    always @(posedge button_out[0]) begin
        if(song_num == 0) begin
            song_num <= 1;
        end else begin
            song_num <= song_num - 1;
        end
    end

    always @(posedge button_out[2]) begin
        if(song_num == 1) begin
            song_num <= 0;
        end else begin
            song_num <= song_num + 1;
        end
    end
    
endmodule