.586P
.model flat, stdcall
;-----------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;-----------------------------------


_DATA SEGMENT
    ddOneNum   dd  945634
    ddTwoNum   dd  789105
    ddResult   dd  ?

_DATA ENDS


_TEXT SEGMENT
START:

    push dword ptr[ddOneNum]
    push dword ptr[ddTwoNum]
    call AddProc
    mov dword ptr[ddResult], eax

    push 0
    call ExitProcess@4

    ;------------------------------------
    AddProc proc
        push ebp
        mov ebp, esp
        push ebx
        push esi
        push edi

        mov eax, dword ptr[ebp+8]
        mov ebx, dword ptr[ebp+0Ch]
        add eax, ebx

        pop edi
        pop esi
        pop ebx
        mov esp, ebp
        pop ebp    
        ret 8
    AddProc endp
    ;------------------------------------
_TEXT ENDS
END START