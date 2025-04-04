// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VALU32.h for the primary calling header

#include "VALU32__pch.h"
#include "VALU32__Syms.h"
#include "VALU32___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void VALU32___024root___dump_triggers__stl(VALU32___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void VALU32___024root___eval_triggers__stl(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VALU32___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
