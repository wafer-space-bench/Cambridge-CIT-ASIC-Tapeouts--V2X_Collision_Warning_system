`timescale 1ns/1ps

module tb;

    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    reg ena;
    reg clk;
    reg rst_n;

    // DUT Instantiation
    tt_um_v2x_warning dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | Vehicle1=%0d | Vehicle2=%0d | Alert=%b",
                 $time, ui_in, uio_in, uo_out[0]);
    end

    // Stimulus
    initial begin

        ena   = 1'b1;
        rst_n = 1'b0;
        ui_in = 8'd0;
        uio_in = 8'd0;

        #20;
        rst_n = 1'b1;

        // Test Case 1: Distance = 5 -> Alert ON
        #10;
        ui_in  = 8'd50;
        uio_in = 8'd55;

        // Test Case 2: Distance = 20 -> Alert OFF
        #20;
        ui_in  = 8'd20;
        uio_in = 8'd40;

        // Test Case 3: Distance = 8 -> Alert ON
        #20;
        ui_in  = 8'd100;
        uio_in = 8'd108;

        // Test Case 4: Distance = 15 -> Alert OFF
        #20;
        ui_in  = 8'd60;
        uio_in = 8'd75;

        // Test Case 5: Same Position -> Alert ON
        #20;
        ui_in  = 8'd80;
        uio_in = 8'd80;

        // Test Case 6: Distance = 9 -> Alert ON
        #20;
        ui_in  = 8'd10;
        uio_in = 8'd19;

        // Test Case 7: Distance = 10 -> Alert OFF
        #20;
        ui_in  = 8'd10;
        uio_in = 8'd20;

        #20;
        $finish;

    end

    // VCD Dump
    initial begin
        $dumpfile("v2x_warning.vcd");
        $dumpvars(0, tb_tt_um_v2x_warning);
    end

endmodule
