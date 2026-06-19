//====================================================
// Tiny Tapeout Top Module
//====================================================
module tt_um_v2x_warning (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

wire collision_warning;
wire alert_signal;

//----------------------------------------------------
// Collision Detection
//----------------------------------------------------
collision_detector u_collision_detector (
    .vehicle1_pos(ui_in),
    .vehicle2_pos(uio_in),
    .collision_warning(collision_warning)
);

//----------------------------------------------------
// Alert Generation
//----------------------------------------------------
v2v_controller u_v2v_controller (
    .collision_warning(collision_warning),
    .alert_signal(alert_signal)
);

//----------------------------------------------------
// Outputs
//----------------------------------------------------
assign uo_out = {7'b0000000, alert_signal};

// Bidirectional pins unused
assign uio_out = 8'b00000000;
assign uio_oe  = 8'b00000000;

// Suppress unused signal warnings
wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
