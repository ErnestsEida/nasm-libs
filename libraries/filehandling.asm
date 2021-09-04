%define SYS_DELETE 87
%define SYS_CREATE 85
%define SYS_OPEN 2
%define SYS_CLOSE 3


%macro stringLength 0
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

%macro ReadFile 3
    ; %1 - path , %2 - memory to save to , %3 - length to read
    PUSH RAX
    PUSH RDI
    PUSH RSI
    PUSH RDX

    MOV RAX , SYS_OPEN
    MOV RDI , %1
    MOV RSI , 0o444
    SYSCALL

    PUSH RAX
    
    MOV RAX , 0
    POP RDI
    MOV RSI , %2
    MOV RDX , %3
    SYSCALL

    MOV RAX , SYS_CLOSE
    SYSCALL

    POP RDX
    POP RSI
    POP RDI
    POP RAX
%endmacro

%macro CreateFile 2
    ; %1 - PATH , %2 - File Allowance
    PUSH RAX
    PUSH RDI
    PUSH RSI

    MOV RAX , SYS_CREATE
    MOV RDI , %1
    MOV RSI , %2
    SYSCALL

    MOV RDI , RAX
    MOV RAX , SYS_CLOSE
    SYSCALL

    POP RSI
    POP RDI
    POP RAX
%endmacro

%macro DeleteFile 1
    ; %1 - path
    PUSH RAX
    PUSH RDI

    MOV RAX , SYS_DELETE
    MOV RDI , %1
    SYSCALL

    POP RDI
    POP RAX
%endmacro

%macro AppendToFile 2
    ; %1 - Path , %2 - Text to write
    PUSH RAX
    PUSH RDI
    PUSH RSI
    PUSH R8
    PUSH RDX

    MOV RAX , SYS_OPEN
    MOV RDI , %1
    MOV RSI , 0x441
    SYSCALL

    MOV R8 , RAX
    MOV RAX , %2
    stringLength

    MOV RDX , RAX
    MOV RAX , 1
    MOV RDI , R8
    MOV RSI , %2
    SYSCALL

    MOV RAX , SYS_CLOSE
    MOV RDI , R8
    SYSCALL

    POP RDX
    POP R8
    POP RSI
    POP RDI
    POP RAX
%endmacro

%macro WriteToFile 2
    ; %1 - Path , %2 - Text to write
    PUSH RAX
    PUSH RDI
    PUSH RSI
    PUSH R8
    PUSH RDX

    MOV RAX , SYS_OPEN
    MOV RDI , %1
    MOV RSI , 1
    SYSCALL

    MOV R8 , RAX ; FILE DESCRIPTOR
    MOV RAX , %2
    stringLength

    MOV RDX , RAX
    MOV RAX , 1
    MOV RDI , R8
    MOV RSI , %2
    SYSCALL

    MOV RAX , SYS_CLOSE
    MOV RDI , R8
    SYSCALL

    POP RDX
    POP R8
    POP RSI
    POP RDI
    POP RAX
%endmacro