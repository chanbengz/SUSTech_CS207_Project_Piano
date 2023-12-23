// Convert score to level
`include "const.v"

module score2level(
    input      [40:0] score,          // score
    output reg [4:0]  p0, p1, p2, p3  // 7-segment display
    );
    
    always @(score) begin
        if(score > 40'd10_000_000_000) begin
            {p3, p2, p1, p0} = `BAD;  // Bad
        end else if(score > 40'd7_000_000_000) begin
            {p3, p2, p1, p0} = `SOSO; // SoSo
        end else if(score > 40'd100_000_000)begin
            {p3, p2, p1, p0} = `GOOD; // Good
        end else begin
            {p3, p2, p1, p0} = `EMPTY4; // Empty
        end
    end

endmodule