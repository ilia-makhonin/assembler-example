.586P
.model flat, stdcall

includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near


_DATA SEGMENT

    dwOperand   dw 67

_DATA ENDS


_TEXT SEGMENT
START:

    mov eax, -127
    mov ebx, 29
    imul bl

    mov eax, 73
    mov ebx, -98
    imul ax, bx
    movsx eax, ax

    mov eax, 0
    mov al, -7
    imul ax, 106
    movsx eax, ax

    mov eax, 0
    mov ebx, -9
    imul ax, bx, 19
    movsx eax, ax

    mov eax, -60
    imul ax, word ptr[dwOperand]
    

    push 0
    call ExitProcess@4

_TEXT ENDS
END START