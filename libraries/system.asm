%define SYS_EXIT 60

%macro pushStackBase 0
    push rbp
    mov rbp , rsp
%endmacro

%macro returnStackBase 0
    mov rsp , rbp
    pop rbp
%endmacro

%macro SystemExit 0
    MOV RAX , SYS_EXIT
    MOV RDI , 0
    SYSCALL
%endmacro