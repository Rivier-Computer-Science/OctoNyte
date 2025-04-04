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
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(io_opcode,5,0);
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __VactContinue;
    VL_IN(io_a,31,0);
    VL_IN(io_b,31,0);
    VL_OUT(io_result,31,0);
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
