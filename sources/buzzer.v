module buzzer(
    input clk,
    output speaker
);

parameter note1 = 381680;
reg [31:0] cnt;
reg pwm;
initial begin
    pwm = 0;
    cnt = 0;
end

always @(posedge clk) begin
    if(cnt < note1) begin
        cnt <= cnt + 1'b1;
    end else begin
        pwm =~ pwm;
        cnt <= 0;
    end
end
assign speaker = pwm;

endmodule