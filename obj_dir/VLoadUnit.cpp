// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VLoadUnit__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VLoadUnit::VLoadUnit(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VLoadUnit__Syms(contextp(), _vcname__, this)}
    , clock{vlSymsp->TOP.clock}
    , reset{vlSymsp->TOP.reset}
    , io_funct3{vlSymsp->TOP.io_funct3}
    , io_addr{vlSymsp->TOP.io_addr}
    , io_dataIn{vlSymsp->TOP.io_dataIn}
    , io_dataOut{vlSymsp->TOP.io_dataOut}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VLoadUnit::VLoadUnit(const char* _vcname__)
    : VLoadUnit(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VLoadUnit::~VLoadUnit() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VLoadUnit___024root___eval_debug_assertions(VLoadUnit___024root* vlSelf);
#endif  // VL_DEBUG
void VLoadUnit___024root___eval_static(VLoadUnit___024root* vlSelf);
void VLoadUnit___024root___eval_initial(VLoadUnit___024root* vlSelf);
void VLoadUnit___024root___eval_settle(VLoadUnit___024root* vlSelf);
void VLoadUnit___024root___eval(VLoadUnit___024root* vlSelf);

void VLoadUnit::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VLoadUnit::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VLoadUnit___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VLoadUnit___024root___eval_static(&(vlSymsp->TOP));
        VLoadUnit___024root___eval_initial(&(vlSymsp->TOP));
        VLoadUnit___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VLoadUnit___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VLoadUnit::eventsPending() { return false; }

uint64_t VLoadUnit::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VLoadUnit::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VLoadUnit___024root___eval_final(VLoadUnit___024root* vlSelf);

VL_ATTR_COLD void VLoadUnit::final() {
    VLoadUnit___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VLoadUnit::hierName() const { return vlSymsp->name(); }
const char* VLoadUnit::modelName() const { return "VLoadUnit"; }
unsigned VLoadUnit::threads() const { return 1; }
void VLoadUnit::prepareClone() const { contextp()->prepareClone(); }
void VLoadUnit::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> VLoadUnit::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VLoadUnit___024root__trace_decl_types(VerilatedVcd* tracep);

void VLoadUnit___024root__trace_init_top(VLoadUnit___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VLoadUnit___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VLoadUnit___024root*>(voidSelf);
    VLoadUnit__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    VLoadUnit___024root__trace_decl_types(tracep);
    VLoadUnit___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void VLoadUnit___024root__trace_register(VLoadUnit___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VLoadUnit::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'VLoadUnit::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VLoadUnit___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
