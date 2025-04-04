// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VALU32__SYMS_H_
#define VERILATED_VALU32__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VALU32.h"

// INCLUDE MODULE CLASSES
#include "VALU32___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)VALU32__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VALU32* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VALU32___024root               TOP;

    // CONSTRUCTORS
    VALU32__Syms(VerilatedContext* contextp, const char* namep, VALU32* modelp);
    ~VALU32__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
