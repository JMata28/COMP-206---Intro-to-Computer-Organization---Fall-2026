#define __SFR_OFFSET 0
#include <avr/io.h>

; Week 11 slides
; Slide 6 demo: if/else and a counting loop
; FOR MAC MPLAB X
; ATmega328P (Arduino Uno)
;
; if/else:  if (x < 10) y = 1; else y = 2;
;           x = r16, y = r17
; loop:     for (i = 5; i != 0; i--) sum += 3;
;           sum = r20, constant 3 = r21, i = r22
;           (the test is at the bottom of the loop, like a do-while;
;            same result here because i starts at 5, not 0)

.global main

main:
; ---------- if/else ----------
        ldi  r16, 7         ; x = 7
        cpi  r16, 10        ; compute x - 10 to set the SREG flags (r16 is not changed)
        brsh else_part      ; IF x >= 10 (C = 0), jump to else_part; otherwise continue below
        ldi  r17, 1         ; if-body: y = 1 (runs only when x < 10)
        rjmp end_if         ; always jump past the else-body
else_part:
        ldi  r17, 2         ; else-body: y = 2 (runs only when x >= 10)
end_if:

; ---------- loop ----------
        ldi  r20, 0         ; sum = 0
        ldi  r21, 3         ; constant 3
        ldi  r22, 5         ; i = 5
loop:
        add  r20, r21       ; sum = sum + 3
        dec  r22            ; i = i - 1 (sets Z = 1 only when i becomes 0)
        brne loop           ; IF i != 0 (Z = 0), jump back to loop; otherwise continue below

done:
        rjmp done           ; stop here (infinite loop); sum = 15