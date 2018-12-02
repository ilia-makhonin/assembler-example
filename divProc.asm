.586P
.model flat, stdcall

includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near


_DATA SEGMENT
    ExitCode   dd 0
    dbOne      db 120
    dbTwo      db 6
    dwResult   dw ?

    dwThree    dw 12067
    dwFour     dw 659
    ddResult   dd ?

_DATA ENDS


_TEXT SEGMENT
START:

    movzx eax, byte ptr[dbTwo]
    movzx ebx, byte ptr[dbOne]
    push eax
    push ebx
    call DivProc8
    mov word ptr[dwResult], ax

    movzx ebx, word ptr[dwThree]
    movzx eax, word ptr[dwfour]
    push eax
    push ebx
    call DivProc16

    push dword ptr[ExitCode]
    call ExitProcess@4


    DivProc8 proc
        push ebp
        mov ebp, esp
        push ebx
        push esi
        push edi
        movzx eax, byte ptr[ebp+8]
        movzx ebx, byte ptr[ebp+12]
        div bl
        pop edi
        pop esi
        pop ebx
        mov esp, ebp
        pop ebp
        ret 8
    DivProc8 endp

    DivProc16 proc
        enter 0, 0
        push ebx
        push esi
        push edi
        movzx eax, word ptr[ebp+8]
        movzx ebx, word ptr[ebp+12]
        mov edx, 0
        div bx
        pop edi
        pop esi
        pop ebx
        leave
        ret 8
    DivProc16 endp

_TEXT ENDS
END START