// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLoadUnit.h for the primary calling header

#include "VLoadUnit__pch.h"
#include "VLoadUnit__Syms.h"
#include "VLoadUnit___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void VLoadUnit___024root___dump_triggers__stl(VLoadUnit___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void VLoadUnit___024root___eval_triggers__stl(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VLoadUnit___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
