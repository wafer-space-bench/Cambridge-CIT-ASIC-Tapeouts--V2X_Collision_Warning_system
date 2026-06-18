module tt_um_v2x_warning(
    input  [7:0] vehicle1_pos,
    input  [7:0] vehicle2_pos,
    output collision_warning
);

wire [7:0] distance;

assign distance = (vehicle1_pos > vehicle2_pos) ?
                  (vehicle1_pos - vehicle2_pos) :
                  (vehicle2_pos - vehicle1_pos);

assign collision_warning = (distance < 8'd10) ? 1'b1 : 1'b0;

endmodule
