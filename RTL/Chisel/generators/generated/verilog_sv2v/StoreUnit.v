module StoreUnit (
    input clock,             // Clock Signal
    input reset,             // Reset Signal
    input [31:0] address,    // Memory Address
    input [31:0] data_in,    // Data to be stored
    input wen,               // Write Enable Signal
    output reg [31:0] mem_out // Output Memory Data
);

    // Simple Memory (256 locations of 32-bit width)
    reg [31:0] memory [0:255];

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Initialize memory (optional)
            mem_out <= 32'b0;
        end else if (wen) begin
            // Store data at specified address
            memory[address[7:0]] <= data_in;  // Using 8-bit address indexing (256 locations)
            mem_out <= data_in;
        end
    end

endmodule
