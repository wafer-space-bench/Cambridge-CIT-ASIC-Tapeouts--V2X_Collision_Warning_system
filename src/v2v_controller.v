module v2v_controller(
    input collision_warning,
    output reg alert_signal
);

always @(*) begin
    if (collision_warning)
        alert_signal = 1'b1;
    else
        alert_signal = 1'b0;
end

endmodule
