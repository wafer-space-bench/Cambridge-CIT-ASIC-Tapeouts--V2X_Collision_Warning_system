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

wire [7:0] vehicle1_pos;
wire [7:0] vehicle2_pos;
wire [7:0] distance;
wire collision_warning;

assign vehicle1_pos = ui_in;
assign vehicle2_pos = uio_in;

assign distance =
    (vehicle1_pos > vehicle2_pos) ?
    (vehicle1_pos - vehicle2_pos) :
    (vehicle2_pos - vehicle1_pos);

assign collision_warning = (distance < 8'd10);

assign uo_out = {7'b0000000, collision_warning};

assign uio_out = 8'b00000000;
assign uio_oe  = 8'b00000000;

endmodule
