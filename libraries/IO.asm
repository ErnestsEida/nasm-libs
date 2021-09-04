;FD ( file descriptors )
%define STDOUT 0
%define STDIN 3
;OPCODES
%define SYS_WRITE 1
%define SYS_READ 0
%define SYS_EXIT 60

%macro stringLen 0
    PUSH RCX
    MOV RCX , 0
    %%loop:
        INC RCX
        INC RAX
        CMP byte[RAX] , 0
        JNE %%loop
    MOV RAX , RCX
    POP RCX
%endmacro

%macro SystemPrint 1
    ; %1 - Text to print
    PUSH RAX
    PUSH RDI
    PUSH RSI
    PUSH RDX
    
    MOV RAX , %1
    stringLen
    
    MOV RDX , RAX
    MOV RAX , SYS_WRITE
    MOV RDI , STDOUT
    MOV RSI , %1
    SYSCALL

    POP RDX
    POP RSI
    POP RDI
    POP RAX
%endmacro

%macro SystemRead 2
    ; %1 - reserved memory to write to , %2 - reserved memory length
    PUSH RAX
    PUSH RDI
    PUSH RSI
    PUSH RDX

    MOV RAX , SYS_READ
    MOV RDI , STDOUT
    MOV RSI , %1
    MOV RDX , %2
    SYSCALL

    POP RDX
    POP RSI
    POP RDI
    POP RAX
%endmacro