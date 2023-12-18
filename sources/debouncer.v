module debouncer(
    input clk, key,
    output reg keyout
);
    reg [15:0] cnt;
    always @(posedge clk) begin
        if(key) begin
            if(cnt == 16'hFFFF) begin
                keyout <= 1;
                cnt <= 0;
            end
            else begin
                keyout <= 0;
                cnt <= cnt + 1;
            end
        end
        else cnt <= 0;
    end

endmodule