%include "libraries/system.asm"
%include "libraries/filehandling.asm"
%include "libraries/IO.asm"
%include "libraries/binary_tree.asm"

SECTION .data
    text DB "Hello World",0xa,0
SECTION .text
    global _start
_start:
    SystemPrint text
    SystemExit