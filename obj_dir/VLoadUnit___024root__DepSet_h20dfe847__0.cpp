// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLoadUnit.h for the primary calling header

#include "VLoadUnit__pch.h"
#include "VLoadUnit___024root.h"

VL_INLINE_OPT void VLoadUnit___024root___ico_sequent__TOP__0(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___ico_sequent__TOP__0\n"); );
    // Body
    vlSelf->LoadUnit__DOT___loadWidth_T_9 = (((0U == (IData)(vlSelf->io_funct3)) 
                                              | (4U 
                                                 == (IData)(vlSelf->io_funct3)))
                                              ? 0U : 
                                             (((1U 
                                                == (IData)(vlSelf->io_funct3)) 
                                               | (5U 
                                                  == (IData)(vlSelf->io_funct3)))
                                               ? 1U
                                               : 2U));
    vlSelf->io_dataOut = ((0U == (IData)(vlSelf->LoadUnit__DOT___loadWidth_T_9))
                           ? (0xffU & vlSelf->io_dataIn)
                           : ((1U == (IData)(vlSelf->LoadUnit__DOT___loadWidth_T_9))
                               ? (0xffffU & vlSelf->io_dataIn)
                               : vlSelf->io_dataIn));
}

void VLoadUnit___024root___eval_ico(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        VLoadUnit___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void VLoadUnit___024root___eval_triggers__ico(VLoadUnit___024root* vlSelf);

bool VLoadUnit___024root___eval_phase__ico(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    VLoadUnit___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        VLoadUnit___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void VLoadUnit___024root___eval_act(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_act\n"); );
}

void VLoadUnit___024root___eval_nba(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_nba\n"); );
}

void VLoadUnit___024root___eval_triggers__act(VLoadUnit___024root* vlSelf);

bool VLoadUnit___024root___eval_phase__act(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<0> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    VLoadUnit___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        VLoadUnit___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool VLoadUnit___024root___eval_phase__nba(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        VLoadUnit___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VLoadUnit___024root___dump_triggers__ico(VLoadUnit___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VLoadUnit___024root___dump_triggers__nba(VLoadUnit___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VLoadUnit___024root___dump_triggers__act(VLoadUnit___024root* vlSelf);
#endif  // VL_DEBUG

void VLoadUnit___024root___eval(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelf->__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            VLoadUnit___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/LoadUnit.v", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (VLoadUnit___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            VLoadUnit___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/LoadUnit.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                VLoadUnit___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/LoadUnit.v", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (VLoadUnit___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (VLoadUnit___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void VLoadUnit___024root___eval_debug_assertions(VLoadUnit___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->io_funct3 & 0xf8U))) {
        Verilated::overWidthError("io_funct3");}
}
#endif  // VL_DEBUG
