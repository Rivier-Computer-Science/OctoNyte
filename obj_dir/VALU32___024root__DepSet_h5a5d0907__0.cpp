// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VALU32.h for the primary calling header

#include "VALU32__pch.h"
#include "VALU32___024root.h"

VL_INLINE_OPT void VALU32___024root___ico_sequent__TOP__0(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___ico_sequent__TOP__0\n"); );
    // Init
    QData/*32:0*/ ALU32__DOT____VdfgTmp_h0cc7a8ea__0;
    ALU32__DOT____VdfgTmp_h0cc7a8ea__0 = 0;
    QData/*32:0*/ ALU32__DOT____VdfgTmp_hd7da7da0__0;
    ALU32__DOT____VdfgTmp_hd7da7da0__0 = 0;
    VlWide<3>/*95:0*/ __Vtemp_7;
    VlWide<3>/*95:0*/ __Vtemp_8;
    VlWide<3>/*95:0*/ __Vtemp_17;
    // Body
    ALU32__DOT____VdfgTmp_h0cc7a8ea__0 = (((QData)((IData)(
                                                           (vlSelf->io_a 
                                                            >> 0x1fU))) 
                                           << 0x20U) 
                                          | (QData)((IData)(vlSelf->io_a)));
    ALU32__DOT____VdfgTmp_hd7da7da0__0 = (((QData)((IData)(
                                                           (vlSelf->io_b 
                                                            >> 0x1fU))) 
                                           << 0x20U) 
                                          | (QData)((IData)(vlSelf->io_b)));
    __Vtemp_7[0U] = vlSelf->io_a;
    __Vtemp_7[1U] = 0U;
    __Vtemp_7[2U] = 0U;
    VL_SHIFTL_WWI(95,95,6, __Vtemp_8, __Vtemp_7, (0x3fU 
                                                  & vlSelf->io_b));
    __Vtemp_17[0U] = ((8U == (0xfU & (IData)(vlSelf->io_opcode)))
                       ? (vlSelf->io_a ^ vlSelf->io_b)
                       : ((0xcU == (0xfU & (IData)(vlSelf->io_opcode)))
                           ? (vlSelf->io_a | vlSelf->io_b)
                           : ((0xeU == (0xfU & (IData)(vlSelf->io_opcode)))
                               ? (vlSelf->io_a & vlSelf->io_b)
                               : ((2U == (0xfU & (IData)(vlSelf->io_opcode)))
                                   ? __Vtemp_8[0U] : 
                                  ((0xaU == (0xfU & (IData)(vlSelf->io_opcode)))
                                    ? VL_SHIFTR_III(32,32,6, vlSelf->io_a, 
                                                    (0x3fU 
                                                     & vlSelf->io_b))
                                    : ((0xbU == (0xfU 
                                                 & (IData)(vlSelf->io_opcode)))
                                        ? VL_SHIFTRS_III(32,32,6, vlSelf->io_a, 
                                                         (0x3fU 
                                                          & vlSelf->io_b))
                                        : ((4U == (0xfU 
                                                   & (IData)(vlSelf->io_opcode)))
                                            ? VL_LTS_III(32, vlSelf->io_a, vlSelf->io_b)
                                            : ((6U 
                                                == 
                                                (0xfU 
                                                 & (IData)(vlSelf->io_opcode)))
                                                ? (vlSelf->io_a 
                                                   < vlSelf->io_b)
                                                : 0U))))))));
    vlSelf->io_result = ((0U == (0xfU & (IData)(vlSelf->io_opcode)))
                          ? (IData)((0x1ffffffffULL 
                                     & (ALU32__DOT____VdfgTmp_h0cc7a8ea__0 
                                        + ALU32__DOT____VdfgTmp_hd7da7da0__0)))
                          : ((1U == (0xfU & (IData)(vlSelf->io_opcode)))
                              ? (IData)((0x1ffffffffULL 
                                         & (ALU32__DOT____VdfgTmp_h0cc7a8ea__0 
                                            - ALU32__DOT____VdfgTmp_hd7da7da0__0)))
                              : __Vtemp_17[0U]));
}

void VALU32___024root___eval_ico(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        VALU32___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void VALU32___024root___eval_triggers__ico(VALU32___024root* vlSelf);

bool VALU32___024root___eval_phase__ico(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    VALU32___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        VALU32___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void VALU32___024root___eval_act(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_act\n"); );
}

void VALU32___024root___eval_nba(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_nba\n"); );
}

void VALU32___024root___eval_triggers__act(VALU32___024root* vlSelf);

bool VALU32___024root___eval_phase__act(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<0> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    VALU32___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        VALU32___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool VALU32___024root___eval_phase__nba(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        VALU32___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VALU32___024root___dump_triggers__ico(VALU32___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VALU32___024root___dump_triggers__nba(VALU32___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VALU32___024root___dump_triggers__act(VALU32___024root* vlSelf);
#endif  // VL_DEBUG

void VALU32___024root___eval(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval\n"); );
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
            VALU32___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/ALU32.v", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (VALU32___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            VALU32___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/ALU32.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                VALU32___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("/workspaces/Preetham-OctoNyte/RTL/Chisel/generators/generated/verilog_sv2v/ALU32.v", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (VALU32___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (VALU32___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void VALU32___024root___eval_debug_assertions(VALU32___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU32__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU32___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->io_opcode & 0xc0U))) {
        Verilated::overWidthError("io_opcode");}
}
#endif  // VL_DEBUG
