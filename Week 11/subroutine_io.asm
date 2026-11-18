; Week 11.2: Subroutines
; Code Example: Subroutines and I/O Registers
; FOR WINDOWS MICROCHIP STUDIO
; ATmega328P (Arduino Uno)
;
; Two subroutines turn the Uno onboard LED (pin 13 = PB5) on and off
; by writing to the I/O register PORTB with the OUT instruction.
;
; Bit 5 of a register = PB5.  0x20 = 0b00100000 (only bit 5 is 1).
;
; In the simulator, watch:
;   - the PC jump into led_on / led_off at each RCALL
;   - the PC come back to the line right after that RCALL at each RET
;   - the I/O register PORTB change between 0x20 and 0x00
; On a real board this runs too fast to see the blinks; the LED just ends up on.

.include "m328pdef.inc"

.org 0x0000
        rjmp main

main:
        ldi  r16, 0x20           ; r16 = 0b00100000 (bit 5 = 1)
        out  DDRB, r16           ; I/O register DDRB: bit 5 = 1 makes PB5 an output pin

        rcall led_on             ; call 1: jump to led_on (LED turns on)
        rcall led_off            ; call 2: after led_on returns, jump to led_off (LED turns off)
        rcall led_on             ; call 3: same subroutine as call 1, different return point

done:
        rjmp done                ; stop here (infinite loop); LED stays on

; ---------- subroutine: turn the LED on ----------
led_on:
        ldi  r18, 0x20           ; r18 = 0b00100000 (bit 5 = 1)
        out  PORTB, r18          ; I/O register PORTB: bit 5 = 1 drives PB5 high, LED on
        ret                      ; go back to the instruction right after the RCALL that called led_on

; ---------- subroutine: turn the LED off ----------
led_off:
        ldi  r18, 0x00           ; r18 = 0b00000000
        out  PORTB, r18          ; I/O register PORTB: bit 5 = 0 drives PB5 low, LED off
        ret                      ; go back to the instruction right after the RCALL that called led_off
