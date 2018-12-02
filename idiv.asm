.586P
.model flat, stdcall
;----------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;----------------------------------

_DATA SEGMENT


_DATA ENDS


_TEXT SEGMENT
START:

    mov eax, 25
    mov ebx, -5
    idiv bl
    movsx eax, al

    mov edx, 0
    mov eax, -1000
    mov ebx, 250
    cwd
    idiv bx

    mov edx, 0
    mov eax, -7200000
    mov ebx, -100000
    cdq
    idiv ebx

    mov eax, -25
    mov ebx, -10
    idiv bl
    movsx edx, ah
    movsx ebx, al

    push 0
    call ExitProcess@4

_TEXT ENDS
END START