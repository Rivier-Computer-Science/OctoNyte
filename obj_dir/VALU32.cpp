// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VALU32__pch.h"

//============================================================
// Constructors

VALU32::VALU32(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VALU32__Syms(contextp(), _vcname__, this)}
    , clock{vlSymsp->TOP.clock}
    , reset{vlSymsp->TOP.reset}
    , io_opcode{vlSymsp->TOP.io_opcode}
    , io_a{vlSymsp->TOP.io_a}
    , io_b{vlSymsp->TOP.io_b}
    , io_result{vlSymsp->TOP.io_result}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VALU32::VALU32(const char* _vcname__)
    : VALU32(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VALU32::~VALU32() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VALU32___024root___eval_debug_assertions(VALU32___024root* vlSelf);
#endif  // VL_DEBUG
void VALU32___024root___eval_static(VALU32___024root* vlSelf);
void VALU32___024root___eval_initial(VALU32___024root* vlSelf);
void VALU32___024root___eval_settle(VALU32___024root* vlSelf);
void VALU32___024root___eval(VALU32___024root* vlSelf);

void VALU32::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VALU32::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VALU32___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VALU32___024root___eval_static(&(vlSymsp->TOP));
        VALU32___024root___eval_initial(&(vlSymsp->TOP));
        VALU32___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VALU32___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VALU32::eventsPending() { return false; }

uint64_t VALU32::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VALU32::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VALU32___024root___eval_final(VALU32___024root* vlSelf);

VL_ATTR_COLD void VALU32::final() {
    VALU32___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VALU32::hierName() const { return vlSymsp->name(); }
const char* VALU32::modelName() const { return "VALU32"; }
unsigned VALU32::threads() const { return 1; }
void VALU32::prepareClone() const { contextp()->prepareClone(); }
void VALU32::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void VALU32::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'VALU32::trace()' called on model that was Verilated without --trace option");
}
