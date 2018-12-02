.586P
.model flat, stdcall
;-----------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;-----------------------------------

_DATA SEGMENT
    ddExit   dd 0
    dbOne    db 60
    dbTwo    db 9
    
_DATA ENDS

_TEXT SEGMENT
START:

    movzx eax, dbOne
    push eax
    call MulProc

    push [ddExit]
    call ExitProcess@4

;-----------------------------------

MulProc proc
    enter 0, 0
;-----------------------------------
    push ebx
    push esi
    push edi
;-----------------------------------
    mov edx, 0
    movzx eax, byte ptr[ebp+8]
    mul al
    movzx ebx, byte ptr[ebp+8]
    mul bx
;-----------------------------------
    mov word ptr[ebp - 4], ax
    mov word ptr[ebp - 2], dx
    mov eax, dword ptr[ebp - 4]
;-----------------------------------
    pop edi
    pop esi
    pop ebx
    leave
    ret 4

MulProc endp

_TEXT ENDS
END START