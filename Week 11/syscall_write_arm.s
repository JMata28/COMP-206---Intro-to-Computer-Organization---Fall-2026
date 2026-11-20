@ 32-bit ARM assembly for Raspberry Pi Linux (not AVR)
@ COMP 206 - System Calls example: print a message, then exit
@ Build and run on a Raspberry Pi (32-bit OS):
@   as -o syscall_write_arm.o syscall_write_arm.s
@   ld -o syscall_write_arm syscall_write_arm.o
@   ./syscall_write_arm

.data
msg:    .ascii "Hello World!\n"     @ the message (13 bytes)

.text
.global _start
_start:
        mov  r0, #1         @ argument 1: where to write (1 = the screen)
        ldr  r1, =msg       @ argument 2: address of the message
        mov  r2, #13        @ argument 3: number of bytes to write
        mov  r7, #4         @ system call number 4 = write
        svc  0              @ trap into the operating system

        mov  r0, #0         @ argument 1: exit status 0 (no errors)
        mov  r7, #1         @ system call number 1 = exit
        svc  0              @ trap into the operating system
