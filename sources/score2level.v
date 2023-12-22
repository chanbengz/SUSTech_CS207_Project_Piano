// Convert score to level
`include "const.v"

module score2level(
    input      [31:0] score,
    output reg [4:0]  p0, p1, p2, p3
    );
    
    always @(score) begin
        if(score > 'd1000_000_000) begin
            {p3, p2, p1, p0} = `BAD; // Bad
        end else if(score > 'd700_000_000) begin
            {p3, p2, p1, p0} = `SOSO; // SoSo
        end else if(score > 'd100_000_000)begin
            {p3, p2, p1, p0} = `GOOD; // Good
        end else begin
            {p3, p2, p1, p0} = `EMPTY4; // Empty
        end
    end

endmodule