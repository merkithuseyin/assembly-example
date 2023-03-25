; Arch: x86_64
; OS: 64bit Linux

; 64bit Linux call convention:
;     rax : system call number
;     rcx : return address
;     rdi : arg0
;     rsi : arg1
;     rdx : arg2
;     r10 : arg3
;     r8  : arg4
;     r9  : arg5

; compile, link and execute: "nasm -f elf64 helloworld.asm -o helloworld.o; ld helloworld.o -o helloworld; ./helloworld"

bits 64
global _start         

section .data
      message db "Hello World !", 10      ; message = "Hello World !\n"
      message_len equ $ - message         ; message_len = length of 'message'

section .text
      _start:
            mov rax, 1                    ; SYS_WRITE (int fileDescriptor, const void *buf, size_t count)   https://man7.org/linux/man-pages/man2/write.2.html
            mov rdi, 1                    ; arg0 = 1 (stdout)
            mov rsi, message              ; arg1 = message
            mov rdx, message_len          ; arg2 = message_len
            syscall                       ; Call Kernal => "SYS_WRITE(1, message, message_len)"
            
            call exit

      exit:
            mov rax, 60                   ; SYS_EXIT (int status)                                           https://man7.org/linux/man-pages/man2/exit.2.html
            mov rdi, 0                    ; arg0 = 0
            syscall                       ; Call Kernal => "SYS_EXIT(0)"