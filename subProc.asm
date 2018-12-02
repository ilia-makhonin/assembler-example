.586P
.model flat, stdcall
;--------------------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;--------------------------------------------

SubProcMacro PROTO :DWORD, :DWORD


_DATA SEGMENT

    ExitCode        dd 0
    ddSubNum_1      dd 129
    ddSubNum_2      dd 371

    ddSubNum_3      dd 8125
    ddSubNum_4      dd 7031

    ddSubNum_5      dd 9068
    ddSubNum_6      dd 3582

    ddResultSub_1   dd ?
    ddResultSub_2   dd ?
    ddResultSub_3   dd ?

_DATA ENDS


_TEXT SEGMENT
START:

    push dword ptr[ddSubNum_2]
    push dword ptr[ddSubNum_1]
    call SubProc
    mov dword ptr[ddResultSub_1], eax

    invoke SubProcMacro, ddSubNum_3, ddSubNum_4
    mov dword ptr[ddResultSub_2], eax

    push dword ptr[ddSubNum_6]
    push dword ptr[ddSubNum_5]
    call SubProcEasy

    push [ExitCode]
    call ExitProcess@4

;--------------------------------------------
;------------- Procedure segment ------------
;--------- Clear assembler lenguage ---------

SubProc proc
    push ebp
    mov ebp, esp
;--------------------------------------------
    push ebx
    push esi
    push edi
;--------------------------------------------

    mov eax, dword ptr[ebp+8]
    mov ebx, dword ptr[ebp+12]

    sub eax, ebx

;--------------------------------------------
    pop edi
    pop esi
    pop ebx
;--------------------------------------------
    mov esp, ebp
    pop ebp
    ret 8
SubProc endp

;--------- Macro assembler lenguage ---------

SubProcMacro proc uses ebx esi edi numSub1:DWORD, numSub2:DWORD

    mov eax, numSub1
    mov ebx, numSub2
    sub eax, ebx
    ret

SubProcMacro endp

;------ Easy code assembler lenguage --------

SubProcEasy proc
    enter 0, 0
;--------------------------------------------
    push ebx
    push esi
    push edi
;--------------------------------------------
    
    mov eax, dword ptr[ebp+8]
    mov ebx, dword ptr[ebp+12]
    sub eax, ebx
    
;--------------------------------------------
    pop edi
    pop esi
    pop ebx
;--------------------------------------------
    leave
    ret 8
SubProcEasy endp

;----------- End process segment ------------
_TEXT ENDS
END START