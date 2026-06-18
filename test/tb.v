`timescale 1ns/1ps

module testbench;

reg [7:0] vehicle1_pos;
reg [7:0] vehicle2_pos;

wire collision_warning;

collision_detector uut (
    .vehicle1_pos(vehicle1_pos),
    .vehicle2_pos(vehicle2_pos),
    .collision_warning(collision_warning)
);

initial begin

    $display("Starting V2X Collision Warning Test");

    vehicle1_pos = 8'd50;
    vehicle2_pos = 8'd70;

    #10;

    $display("Distance Safe -> Warning = %b", collision_warning);

    vehicle1_pos = 8'd50;
    vehicle2_pos = 8'd55;

    #10;

    $display("Collision Risk -> Warning = %b", collision_warning);

    #10;

    $finish;

end

endmodule
