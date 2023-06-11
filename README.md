Prerequisites: 

    1. x86_64 CPU ("uname -m")
    2. 64 bit Linux OS ("getconf LONG_BIT")
    3. "sudo apt-get update"
    4. "sudo apt-get install nasm"
    5. "sudo apt-get install build-essential"
    
***

Storage

    1 byte (8 bit)    : byte,  DB, RESB
    2 bytes (16 bit)  : word,  DW, RESW
    4 bytes (32 bit)  : dword, DD, RESD
    8 bytes (64 bit)  : qword, DQ, RESQ
    10 bytes (80 bit) : tword, DT, REST
    16 bytes (128 bit): oword, DO, RESO, DDQ, RESDQ
    32 bytes (256 bit): yword, DY, RESY
    64 bytes (512 bit): zword, DZ, RESZ
    

General Purpose Registers

    64bit   32bit   16bit   8bit
    ----------------------------
    rax	    eax	    ax	    al
    rbx	    ebx     bx      bl
    rcx	    ecx     cx      cl
    rdx	    edx     dx      dl
    rsi	    esi     si      sil
    rdi	    edi     di      dil
    rbp	    ebp     bp      bpl
    rsp	    esp     sp      spl
    r8	    r8d     r8w     r8b
    r9	    r9d     r9w     r9b
    r10	    r10d    r10w    r10b
    r11	    r11d    r11w    r11b
    r12	    r12d    r12w    r12b
    r13	    r13d    r13w    r13b
    r14	    r14d    r14w    r14b
    r15	    r15d    r15w    r15b

RSP Register (Stack Pointer Register):          Used to point to the current top of the stack.

RBP Register (Base Pointer Register):           Used as a base pointer during function calls.

RIP Register (Instruction Pointer Register):    Used by the CPU to point to the next instruction to be executed.

Memory Layout
    
    |--------------------------| .... High Memory   
    | Stack                    |
    |                          |
    |                          |
    |                          |
    |                          |
    | Heap                     |
    |--------------------------|
    | BSS - Uninitialized Data |
    |--------------------------|
    | Data                     |
    |--------------------------|
    | Text ( Code )            |
    |--------------------------|
    | Reserved                 |
    |--------------------------| .... Low Memory

***

.data section 

    This section is for "declaring initialized data".
    db	8bit
    dw	16bit
    dd	32bit
    dq	64bit
    ddq	128bit ( Integer )
    dt	128bit ( Float )

    Example:

    section .data
        length equ 1000         ; "equ" used to define constant
        var1 db 10              ; Byte Variable
        var2 db "A"             ; String Character
        var3 dw 1000            ; 16bit Variable
        var4 dd 10, 20, 30      ; 3 Element Array
	
.bss section

    This section is where you declare your variables.

    section .bss
        arr1 resb 10     ; 10 Element byte array
        arr2 resw 50     ; 50 Element word array
        arr3 resd 100    ; 100 element double array
        arr4 resq 200    ; 200 element quad array

.text section

    This is where the actual assembly code is written. The .text section must begin with the declaration global _start, which just tells the kernel where the program execution begins. 
    (It's like the main function in C or Java, only it's not a function, just a starting point.) Example:

    section .text
	    global _start

    _start:
	    pop    ebx        ; Here is the where the program actually begins
        .
        .
        .

***

Data Movement

    mov rax, 100            ; rax = 0x00000064
    mov rcx, -1             ; rcx = 0xffffffffffffffff
    
    mov rax, qword[VAR_B]   ; Value of the VAR_B in rax
    mov rax, VAR_B          ; Address of the VAR_B in rax

***

Integer Arithmetic Instructions

    add <destination> , <source>    ; x = x + y
    sub <destination> , <source>    ; x = x - y
    inc <operand>                   ; x++
    dec <operand>                   ; x--
    adc <dec> , <source>            ; ADC is the same as ADD but adds an extra 1 if processor's carry flag is set.
    mul <source>                    ; EAX * source   ->   [EDX EAX]
    div <divisor>                   ; [EDX EAX] / divisor   ->   EAX (Quotient), EDX (Reminder)  

Logical Instructions

    and <destination> , <source>
    or  <destination> , <source>
    xor <destination> , <source>
    not <operand>

Control Instructions

    jmp <label>                     ; Jump to specified label
    cmp <destination> , <source>    ;    

        Example:
        CMP DX,	00  ; Compare the DX value with zero
        JE  L7      ; If yes, then jump to label L7

    sete  <label>       ; ==
    setne <label>       ; !=
    setq  <label>       ; <
    setle <label>       ; >
    setg  <label>       ; <=
    setle <label>       ; >=

    je  <label>         ; ==
    jne <label>         ; !=
    jl  <label>         ; signed <
    jle <label>         ; signed <=
    jg  <label>         ; signed >
    jge <label>         ; signed >=
    jb  <label>         ; unsigned <
    jbe <label>         ; unsigned <=
    ja  <label>         ; unsigned >
    jae <label>         ; unsigned >=

***

Macros

    %define ... ...

Multi Line Macros

    %macro <name> <number_of_arguments>
    ...
    %endmacro

Function Declaration
    
    global <function_name>
    <function_name> :
        ...
        ret
