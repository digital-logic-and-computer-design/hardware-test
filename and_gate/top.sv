module top(
    output logic tm_strobe,      // TM1638 Strobe
    output logic tm_clock,       // TM1638 Clock
    inout  logic tm_dio          // TM1638 Data
);

    // ***** Leave the part below (everything above the "TODO" area) alone
    // 6MHz clock
    logic clock;
    SB_HFOSC #(.CLKHF_DIV("0b11")) inthosc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clock));

    // Startup reset for one clock
    logic reset = 1;
    always_ff @(posedge clock) begin
        reset = 0;
    end


   logic [7:0] display0, display1, display2, display3, display4, display5, display6, display7, leds;
   logic [7:0] keys;

    logic [7:0] digits [0:3];
    logic [7:0] eq;

    logic out;

    //    +-a-+
    //    |   |
    //    f   b
    //    |   |
    //    +-g-+
    //    |   |
    //    e   c
    //    |   |
    //    +-d-+ h
    //

                //        hgfe dcba
    assign digits[0] = 8'b0011_1111; // 0
    assign digits[1] = 8'b0000_0110; // 1
    assign digits[2] = 8'b0101_1011; // 2
    assign digits[3] = 8'b0100_1111; // 3
    assign eq         = 8'b0100_1000; // =


    // // ************************************************
    ledandkey ledAndKey(.clock(clock), .reset(reset),
                        .tm_strobe(tm_strobe), .tm_clock(tm_clock), .tm_dio(tm_dio),
                        .display0(display0),
                        .display1(display1),
                        .display2(display2),
                        .display3(display3),
                        .display4(display4),
                        .display5(display5),
                        .display6(display6),
                        .display7(display7),
                        .leds(leds),
                        .keys(keys));

    always_comb begin
        case ( out )
            2'b0: display0 = digits[0];
            2'b1: display0 = digits[1];
        endcase
    end
    assign display1 = 0;
    assign display2 = eq;
    assign display3 = 0;

    assign display4 = 0;
    assign display5 = keys[5] ? digits[1] : digits[0];
    assign display6 = keys[6] ? digits[1] : digits[0];
    assign display7 = 0;
    assign leds = 0;
    
    and_gate  dut(
        .a(keys[6]),
        .b(keys[5]),
        .c(out)
    );

endmodule
