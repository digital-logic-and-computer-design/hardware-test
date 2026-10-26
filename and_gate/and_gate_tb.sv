
module and_gate_tb();
    logic a,b,c;
    logic error, expected_out;
    integer i;
    integer error_count;
    and_gate dut(
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        error = 0;
        error_count = 0;
        $dumpfile("and_gate_tb.vcd");
        $dumpvars(0, and_gate_tb);
        // for loop that counts up to 4
        for(i=0;i<4;i=i+1) begin
            // assign a,b to i[1:0]
            a = i[1];
            b = i[0];
            expected_out = a & b;
            // wait for 1ns
            #1;
            error = c===expected_out ? 0 : 1;
            if(error) begin
                error_count = error_count + 1;
                $error("Error: a=%b, b=%b, c=%b, expected_c=%b", a, b, c, expected_out);
            end
            // print out the values of a,b,c
            $display("a=%b, b=%b, c=%b", a, b, c);
        end
              // Check all expected values
      if(error_count !== 0) begin
          $error("*** %d of %d tests failed! -- 'PROBLEMS' tab shows the first error.  Others can be seen where 'error' is true in the signal trace.  ***", error_count, 4);
      end
      else begin
          $error("and_gate_tb.sv:01:All tests passed!");
      end
      #10 $finish;
    end
endmodule
