; Arch: x86_64
; OS: 64bit Linux

; C call convention:
;     rax : return value
;     rdi : arg0
;     rsi : arg1
;     rdx : arg2
;     rcx : arg3
;     r8  : arg4
;     r9  : arg5
;     if more than 6 parameters is rquired, then remaining arguments needed to be pushed onto the stack in reverse order, example: "push [local_var]"
;     
;     preserved registers by callee: rsp (stack pointer), rbp (base/frame pointer), rbx, r12-r15

; compile assemly file: "nasm -f elf64 program.asm -o program_asm.o"
; compile c file:       "gcc -m64 -Wall -c program.c -o program_c.o"
; link:                 "gcc -o program program_asm.o program_c.o"
; run                   "./program"

bits 64
global main
extern sum, printf

section .data
      message db "ASM SYSCALL OUT: Hello", 10   ; message = "ASM SYSCALL OUT: Hello\n"
      message_len equ $ - message               ; message_len = length of 'message'
      str_format db "ASM C OUT: %d", 10, 0      ; format = "ASM C OUT: %d\n\0"

section .text
      main:
            ; call custom function
            mov rdi, 10                         ; inp1 = 10
            mov rsi, 20                         ; inp2 = 20
            mov rdx, 30                         ; inp3 = 30
            mov rcx, 40                         ; inp4 = 40
            call sum                            ; calling sum(10,20,30,40) from helloworld.c; value returned from sum is stored in rax

            ; call c function
            push rbp                            ; create a stack frame, re-aligning the stack to 16-byte alignment before calls
            mov rbp, rsp

            mov rdi, str_format                 ; arg0 = "ASM C OUT: %d\n\0"
            mov rsi, rax                        ; arg1 = rax (return value of sum())
            call printf WRT ..plt               ; calling printf("ASM OUT: %d\n\0", rax)
            leave

            ; syscall
            mov rax, 1                          ; SYS_WRITE (int fileDescriptor, const void *buf, size_t count)
            mov rdi, 1                          ; arg0 = 1 (stdout)
            mov rsi, message                    ; arg1 = message
            mov rdx, message_len                ; arg2 = message_len
            syscall                             ; Call Kernal => "SYS_WRITE(1, message, message_len)"
            
            call exit

      exit:
            mov rax, 60                         ; SYS_EXIT(int status)
            mov rdi, 0                          ; arg0 = 0
            syscall                             ; Call Kernal => "SYS_EXIT(0)"