module mac (
    input clk,clear,en,rst,
    input wire [7:0] a1,a2,a3,a4,a5,a6,a7,a8,a9,
    input wire signed [7:0] b1,b2,b3,b4,b5,b6,b7,b8,b9,
    output reg signed [31:0] acc
);
    wire signed [8:0] s1 = {1'b0,a1};
    wire signed [8:0] s2 = {1'b0,a2};
    wire signed [8:0] s3 = {1'b0,a3};
    wire signed [8:0] s4 = {1'b0,a4};
    wire signed [8:0] s5 = {1'b0,a5};
    wire signed [8:0] s6 = {1'b0,a6};
    wire signed [8:0] s7 = {1'b0,a7};
    wire signed [8:0] s8 = {1'b0,a8};
    wire signed [8:0] s9 = {1'b0,a9};

    wire signed [31:0] sum= s1*b1 + s2*b2 + s3*b3 + s4*b4 + s5*b5 + s6*b6 + s7*b7 + s8*b8 + s9*b9;

    always@(posedge clk) begin
        if (rst) begin
            acc<=0;
        end
        else if (clear) begin
            acc<=0;
        end
        else if(en) begin
            acc<=sum;
        end
    end

endmodule