.586P
.model flat, stdcall
;-------------------------------------------
includelib \masm32\lib\kernel32.lib
extern ExitProcess@4:near
;-------------------------------------------

MulProc32 PROTO :DWORD, :DWORD


_DATA SEGMENT
    dbMulNum1      db 123
    dbMulNum2      db 57
    dwMulResult1   dw ?

    dbMulNum3      db 127
    ddMulResult2   dd ?

    ddMulNum4      dd 705435
    ddMulNum5      dd 396285

_DATA ENDS


_TEXT SEGMENT
START:

    movzx eax, dbMulNum2
    push eax
    movzx ebx, dbMulNum1
    push ebx
    call MulProc8
    mov word ptr[dwMulResult1], ax

    movzx eax, dbMulNum3
    push eax
    call MulProc16

    invoke MulProc32, ddMulNum4, ddMulNum5

    push 0
    call ExitProcess@4
    
;-------------------------------------------

    MulProc8 proc
        push ebp
        mov ebp, esp
;-------------------------------------------
        push ebx
        push esi
        push edi
;-------------------------------------------
 
        movzx eax, byte ptr[ebp+8]
        movzx ebx, byte ptr[ebp+12]
        mul bl

;-------------------------------------------      
        pop edi
        pop esi
        pop ebx
;-------------------------------------------        
        mov esp, ebp
        pop ebp
        ret 8
    MulProc8 endp

;------------------------------------------- 

    MulProc16 proc
        enter 0, 0
        push ebx
        push esi
        push edi
;-------------------------------------------

        mov edx, 0
        movzx eax, byte ptr[ebp+8]
        mul al
        movzx ebx, byte ptr[ebp+8]
        mul bx
        
;-------------------------------------------
        pop edi
        pop esi
        pop ebx
        leave
        ret 4
    MulProc16 endp

;------------------------------------------- 

    MulProc32 proc uses ebx esi edi numOne:DWORD, numTwo:DWORD
        mov eax, numOne
        mov ebx, numTwo
        mov edx, 0
        mul ebx
        ret
    MulProc32 endp

_TEXT ENDS
END START