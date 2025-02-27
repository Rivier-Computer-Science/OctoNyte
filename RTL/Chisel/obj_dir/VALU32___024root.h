// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VALU32.h for the primary calling header

#ifndef VERILATED_VALU32___024ROOT_H_
#define VERILATED_VALU32___024ROOT_H_  // guard

#include "verilated.h"


class VALU32__Syms;

class alignas(VL_CACHE_LINE_BYTES) VALU32___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(ALUOp,2,0);
    VL_OUT8(Zero,0,0);
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __VactContinue;
    VL_IN(A,31,0);
    VL_IN(B,31,0);
    VL_OUT(ALUResult,31,0);
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    VALU32__Syms* const vlSymsp;

    // CONSTRUCTORS
    VALU32___024root(VALU32__Syms* symsp, const char* v__name);
    ~VALU32___024root();
    VL_UNCOPYABLE(VALU32___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
