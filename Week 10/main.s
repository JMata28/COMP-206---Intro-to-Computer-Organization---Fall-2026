#define __SFR_OFFSET 0
#include <avr/io.h>

; Slide 6 demo: if/else and a counting loop
; ATmega328P
;FOR MAC MPLAB IDE
;
; if/else:  if (x < 10) y = 1; else y = 2;
;           x = r16, y = r17
; loop:     for (i = 5; i != 0; i--) sum += 3;
;           sum = r20, constant 3 = r21, i = r22

.global main

main:
; ---------- if/else ----------
        ldi  r16, 7         ; x = 7
        cpi  r16, 10        ; compare x with 10 (sets Z, C, N, V, S)
        brsh else_part      ; x >= 10 is the OPPOSITE of x < 10, so skip to else
        ldi  r17, 1         ; y = 1
        rjmp end_if         ; jump over the else-body
else_part:
        ldi  r17, 2         ; y = 2
end_if:

; ---------- loop ----------
        ldi  r20, 0         ; sum = 0
        ldi  r21, 3         ; constant 3
        ldi  r22, 5         ; i = 5
loop:
        add  r20, r21       ; sum += 3
        dec  r22            ; i--, sets Z when i reaches 0
        brne loop           ; repeat while i != 0

done:
        rjmp done           ; stop here (infinite loop)