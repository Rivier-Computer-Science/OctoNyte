// Immediate Generator
// Extracts and sign-extends immediates for I-, S-, and B-types.

module ImmGen(
    input  [31:0] instr,
    output reg [31:0] imm_out
);
    wire [6:0] op = instr[6:0];

    always @(*) begin
        case (op)
            7'b0000011,  // Load (I-type)
            7'b0010011:  // ALU immediate (I-type)
                imm_out = {{20{instr[31]}}, instr[31:20]};

            7'b0100011:  // Store (S-type)
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            7'b1100011:  // Branch (B-type)
                imm_out = {{19{instr[31]}},
                           instr[31], instr[7],
                           instr[30:25], instr[11:8],
                           1'b0};

            default:
                imm_out = 32'b0;
        endcase
    end
endmodule
