module v2v_controller(
    input  collision_warning,
    output alert_signal
);

assign alert_signal = collision_warning;

endmodule
