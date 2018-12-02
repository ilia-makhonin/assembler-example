.586P
.model flat, stdcall
;----------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;----------------------------------

SubProc PROTO :DWORD, :DWORD


_DATA SEGMENT
    ExitCode   dd 0
    dwNum_1    dd 0
    dwNum_2    dd 0
    dwResult   dd 0
    

_DATA ENDS


_TEXT SEGMENT
START:
    mov dwNum_1, 5
    mov dwNum_2, 10

    push dword ptr[dwNum_2]
    push dwNum_1

    call AddProc

    mov dword ptr[dwResult], eax

    invoke SubProc, dwNum_1, dwNum_2

    push [ExitCode]
    call ExitProcess@4

;----------------------------------
AddProc proc
    ENTER 0, 0
    ; push ebp
    ; mov ebp, esp
    ;------------------------------
    sub esp, 8
    mov dword ptr[ebp - 4], 0
    mov dword ptr[ebp - 8], 0
    ;------------------------------
    push ebx
    push esi
    push edi
    ;------------------------------

    mov eax, dword ptr[ebp + 8]
    mov ebx, dword ptr[ebp + 0Ch]
    add eax, ebx

    ;------------------------------
    pop edi
    pop esi
    pop ebx
    ;------------------------------
    ; mov esp, ebp
    ; pop ebp
    LEAVE
    ret 8
AddProc endp


SubProc proc uses ebx esi edi num1:DWORD, num2:DWORD
    LOCAL a:DWORD
    LOCAL b:DWORD

    mov a, 0
    mov b, 0

    mov eax, num1
    mov ebx, num2
    sub eax, ebx
    ret

SubProc endp

_TEXT ENDS
END START