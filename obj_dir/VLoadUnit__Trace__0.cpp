// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VLoadUnit__Syms.h"


void VLoadUnit___024root__trace_chg_0_sub_0(VLoadUnit___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void VLoadUnit___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root__trace_chg_0\n"); );
    // Init
    VLoadUnit___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VLoadUnit___024root*>(voidSelf);
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    VLoadUnit___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void VLoadUnit___024root__trace_chg_0_sub_0(VLoadUnit___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    bufp->chgBit(oldp+0,(vlSelf->clock));
    bufp->chgBit(oldp+1,(vlSelf->reset));
    bufp->chgIData(oldp+2,(vlSelf->io_addr),32);
    bufp->chgIData(oldp+3,(vlSelf->io_dataIn),32);
    bufp->chgCData(oldp+4,(vlSelf->io_funct3),3);
    bufp->chgIData(oldp+5,(vlSelf->io_dataOut),32);
    bufp->chgIData(oldp+6,(((0U == (IData)(vlSelf->LoadUnit__DOT___loadWidth_T_9))
                             ? (0xffU & vlSelf->io_dataIn)
                             : ((1U == (IData)(vlSelf->LoadUnit__DOT___loadWidth_T_9))
                                 ? (0xffffU & vlSelf->io_dataIn)
                                 : vlSelf->io_dataIn))),32);
    bufp->chgCData(oldp+7,(vlSelf->LoadUnit__DOT___loadWidth_T_9),2);
    bufp->chgBit(oldp+8,((((0U == (IData)(vlSelf->io_funct3)) 
                           | (1U == (IData)(vlSelf->io_funct3))) 
                          | (2U == (IData)(vlSelf->io_funct3)))));
}

void VLoadUnit___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLoadUnit___024root__trace_cleanup\n"); );
    // Init
    VLoadUnit___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VLoadUnit___024root*>(voidSelf);
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
    // Body
    vlSymsp->__Vm_activity = false;
    __Vm_traceActivity[0U] = 0U;
}
