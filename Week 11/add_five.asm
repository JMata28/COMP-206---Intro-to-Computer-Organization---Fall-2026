; Week 11.2: Subroutines
; Code Example: Arguments and Return Values
; FOR WINDOWS MICROCHIP STUDIO
; ATmega328P (Arduino Uno)
;
; This is the AVR version of this C++ code:
;
;     uint8_t add_five(uint8_t x) {
;         return x + 5;
;     }
;     uint8_t a = add_five(10);   // a = 15
;     uint8_t b = add_five(20);   // b = 25
;
; Calling convention (avr-gcc):
;   - the first 8-bit argument goes in r24
;   - an 8-bit return value comes back in r24
;   - r16 is call-saved: a subroutine that uses it must PUSH/POP it
;
; In the simulator, step INTO the second call and watch r16:
; it becomes 5 inside add_five, then goes back to 15 after the POP.

.org 0x0000
        rjmp main

main:
; ---------- a = add_five(10) ----------
        ldi  r24, 10             ; argument x = 10 goes in r24
        rcall add_five           ; call the function
        mov  r16, r24            ; a = return value from r24 (15), kept in r16

; ---------- b = add_five(20) ----------
        ldi  r24, 20             ; argument x = 20 goes in r24
        rcall add_five           ; add_five changes r16 inside, but restores it before returning
        mov  r17, r24            ; b = return value from r24 (25); r16 is still 15

done:
        rjmp done                ; stop here (infinite loop)

; ---------- uint8_t add_five(uint8_t x) ----------
; input:  r24 = x
; output: r24 = x + 5
add_five:
        push r16                 ; prologue: r16 is call-saved, so save the caller value
        ldi  r16, 5              ; body: r16 = 5 (r16 used on purpose to show saving a register)
        add  r24, r16            ; body: r24 = x + 5, which is the return value
        pop  r16                 ; epilogue: restore the caller value of r16
        ret                      ; return to the caller with the result in r24
