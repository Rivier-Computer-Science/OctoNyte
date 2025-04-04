// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLoadUnit.h for the primary calling header

#include "VLoadUnit__pch.h"
#include "VLoadUnit__Syms.h"
#include "VLoadUnit___024root.h"

void VLoadUnit___024root___ctor_var_reset(VLoadUnit___024root* vlSelf);

VLoadUnit___024root::VLoadUnit___024root(VLoadUnit__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VLoadUnit___024root___ctor_var_reset(this);
}

void VLoadUnit___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VLoadUnit___024root::~VLoadUnit___024root() {
}
