module MultifunctionAdderSubtractor32 (
    input logic [31:0] A, B,
    input logic Subtract,
    output logic [31:0] Result,
    output logic CarryOut,
    output logic Overflow
);
    logic [31:0] B_mod;
    logic CarryIn;

    assign B_mod = B ^ {32{Subtract}};
    assign CarryIn = Subtract;

    assign {CarryOut, Result} = A + B_mod + CarryIn;

    assign Overflow = (A[31] == B_mod[31]) && (Result[31] != A[31]);
endmodule
