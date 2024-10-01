module RegisterFile_tb;

  // Inputs
  reg [5:0] addr;
  reg we;
  reg rst;
  reg clk;
  reg enable_reg;
  reg [31:0] data;

  // Bidirectional
  wire [31:0] data_io;

  // Instantiate the Unit Under Test (UUT)
  RegisterFile uut (
    .addr(addr),
    .we(we),
    .rst(rst),
    .clk(clk),
    .data(data_io),
    .enable_reg(enable_reg)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clock every 5 time units
  end

  // Stimulus
  initial begin
    // Initialize Inputs
    we = 0;
    rst = 0;
    addr = 0;
    data = 32'h0;
    enable_reg = 0;

    // Apply reset
    rst = 1;
    #10 rst = 0;

    // Write data to register 1
    addr = 6'd1;
    data = 32'hA5A5A5A5;
    we = 1;
    #10;
    we = 0;

    // Enable reading and read data from register 1
    enable_reg = 1;
    #10;

    // Check if read data matches
    if (data_io == 32'hA5A5A5A5)
      $display("Test passed: Register 1 holds correct value.");
    else
      $display("Test failed: Register 1 does not hold correct value.");

    // Write data to register 2
    addr = 6'd2;
    data = 32'h5A5A5A5A;
    we = 1;
    #10;
    we = 0;

    // Read from register 2
    addr = 6'd2;
    enable_reg = 1;
    #10;

    // Check if read data matches
    if (data_io == 32'h5A5A5A5A)
      $display("Test passed: Register 2 holds correct value.");
    else
      $display("Test failed: Register 2 does not hold correct value.");

    // End simulation
    $stop;
  end

endmodule
