module seg_display(
    input clk, rst_n,
    output reg [7:0] seg_en,
    output [7:0] seg_out0,seg_out1
    );

    reg clkout;
    reg[31:0] cnt;
    reg[3:0] scan_cnt;
    parameter period = 200000;

    light_7seg light_seg0(.seg_in(scan_cnt), .seg_out(seg_out0));
    light_7seg light_seg1(.seg_in(scan_cnt), .seg_out(seg_out1));

    initial begin
        clkout <= 1'b0;
        cnt <= 32'd0;
        scan_cnt <= 3'd0;
    end

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            clkout <= 1'b0;
            cnt <= 32'd0;
            scan_cnt <= 3'd0;
        end else begin
            if (cnt == (period >> 1) - 1) begin
                clkout <= ~clkout;
                cnt <= 32'd0;
            end else begin
                cnt <= cnt + 1;
            end
        end
    end

    always @(posedge clkout, negedge rst_n) begin
        if (!rst_n) begin
            scan_cnt <= 3'd0;
        end else begin
            if (scan_cnt == 3'd7) begin
                scan_cnt <= 0;
            end else begin
                scan_cnt <= scan_cnt + 1;
            end
        end
    end

    always @(scan_cnt) begin
        case(scan_cnt)
            3'b000: seg_en = 8'b0000_0001;
            3'b001: seg_en = 8'b0000_0010;
            3'b010: seg_en = 8'b0000_0100;
            3'b011: seg_en = 8'b0000_1000;
            3'b100: seg_en = 8'b0001_0000;
            3'b101: seg_en = 8'b0010_0000;
            3'b110: seg_en = 8'b0100_0000;
            3'b111: seg_en = 8'b1000_0000;
            default: seg_en = 8'b0000_0000;
        endcase
    end

endmodule