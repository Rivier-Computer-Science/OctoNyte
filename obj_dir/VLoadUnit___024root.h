// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VLoadUnit.h for the primary calling header

#ifndef VERILATED_VLOADUNIT___024ROOT_H_
#define VERILATED_VLOADUNIT___024ROOT_H_  // guard

#include "verilated.h"


class VLoadUnit__Syms;

class alignas(VL_CACHE_LINE_BYTES) VLoadUnit___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(io_funct3,2,0);
    CData/*1:0*/ LoadUnit__DOT___loadWidth_T_9;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __VactContinue;
    VL_IN(io_addr,31,0);
    VL_IN(io_dataIn,31,0);
    VL_OUT(io_dataOut,31,0);
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    VLoadUnit__Syms* const vlSymsp;

    // CONSTRUCTORS
    VLoadUnit___024root(VLoadUnit__Syms* symsp, const char* v__name);
    ~VLoadUnit___024root();
    VL_UNCOPYABLE(VLoadUnit___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
