`timescale 1ns/1ps
module mac_tb;
    reg clk = 0;
    reg rst = 1, clear = 0, en = 0;
    reg [7:0] a1, a2, a3, a4, a5, a6, a7, a8, a9;
    reg signed [7:0] b1, b2, b3, b4, b5, b6, b7, b8, b9;
    wire signed [31:0] acc;

    mac dut (
        .clk(clk), .clear(clear), .en(en), .rst(rst),
        .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5),
        .a6(a6), .a7(a7), .a8(a8), .a9(a9),
        .b1(b1), .b2(b2), .b3(b3), .b4(b4), .b5(b5),
        .b6(b6), .b7(b7), .b8(b8), .b9(b9),
        .acc(acc)
    );

    always #5 clk = ~clk;   // clock flips every 5 ns

    initial begin
        // filter weights (same for every window)
        b1=1; b2=0; b3=-1; b4=1; b5=0; b6=-1; b7=1; b8=0; b9=-1;
        a1=0; a2=0; a3=0; a4=0; a5=0; a6=0; a7=0; a8=0; a9=0;

        repeat (2) @(posedge clk);
        rst = 0;

        // Test 1: top-left window, expect -510
        a1=0;   a2=0;   a3=0;
        a4=0;   a5=255; a6=255;
        a7=0;   a8=255; a9=255;
        en = 1;
        @(posedge clk); #1;
        if (acc === -510) $display("PASS test 1: acc = %0d", acc);
        else              $display("FAIL test 1: acc = %0d (expected -510)", acc);

        // Test 2: right-edge window, expect 765
        a1=255; a2=255; a3=0;
        a4=255; a5=255; a6=0;
        a7=255; a8=255; a9=0;
        @(posedge clk); #1;
        if (acc === 765) $display("PASS test 2: acc = %0d", acc);
        else             $display("FAIL test 2: acc = %0d (expected 765)", acc);

        $finish;
    end
endmodule