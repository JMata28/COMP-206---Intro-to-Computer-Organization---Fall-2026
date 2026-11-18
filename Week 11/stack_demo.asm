; Week 11.2: Subroutines
; Code Example: The Stack
; FOR WINDOWS MICROCHIP STUDIO
; ATmega328P (Arduino Uno)
;
; Part 1: PUSH two registers, then POP them back in the same order.
;         Because the stack is LIFO, the values come back swapped.
; Part 2: A subroutine uses r16 for its own work, but PUSH/POP
;         gives the caller its value of r16 back unchanged.
;
; SP starts at RAMEND (0x08FF), set automatically by the hardware at reset.
;
; In the simulator, watch SP (the I/O registers SPH:SPL):
;   PUSH: SP - 1    POP: SP + 1    RCALL: SP - 2    RET: SP + 2
; Also open a Memory window on data memory near 0x08FF to see the
; bytes being placed on the stack.

.org 0x0000
        rjmp main

main:
; ---------- Part 1: LIFO ----------
        ldi  r16, 0x11           ; r16 = 0x11
        ldi  r17, 0x22           ; r17 = 0x22

        push r16                 ; stack top: 0x11              (SP - 1)
        push r17                 ; stack top: 0x22, then 0x11   (SP - 1)
        pop  r16                 ; r16 = 0x22, the LAST byte pushed comes out FIRST (SP + 1)
        pop  r17                 ; r17 = 0x11                   (SP + 1)
                                 ; result: r16 = 0x22, r17 = 0x11 (swapped)
                                 ; SP is back where it started

; ---------- Part 2: saving a register in a subroutine ----------
        rcall uses_r16           ; return address is pushed (SP - 2)
                                 ; after RET: r16 is still 0x22, and SP is back where it started

done:
        rjmp done                ; stop here (infinite loop)

; ---------- subroutine that needs r16 for its own work ----------
uses_r16:
        push r16                 ; save the caller r16 (0x22) on the stack    (SP - 1)
        ldi  r16, 0xFF           ; the subroutine overwrites r16 for its own work
        pop  r16                 ; restore r16 from the stack: r16 = 0x22 again (SP + 1)
        ret                      ; pop the return address into the PC           (SP + 2)
