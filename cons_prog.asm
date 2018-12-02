.686P
.model flat, stdcall
;--------------------------------------------
includelib \masm32\lib\kernel32.lib

extern ExitProcess@4:near
extern GetStdHandle@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near
;--------------------------------------------


MAX_SIZE     equ 255


_DATA SEGMENT

    ExitCode     dd 0
    szIntro      db 13, 10, 'Press <q> to quit or <x> to exicute Small.', 13, 10, 0
    szBuffer     db MAX_SIZE dup(0)
    szError      db 'Input error! Please try again.', 13, 10, 0
    szSmall      db 07, 'Hello! Here I am, Smally :)', 13, 10, 0

_DATA ENDS


_TEXT SEGMENT
START:

    call main

    push dword ptr[ExitCode]
    call ExitProcess@4

;############################################

main proc
    _do:
        push offset szIntro
        call cout
    _while:
        ;----------------
        push offset szBuffer
        call cin
        ;----------------
        mov al, byte ptr[szBuffer]
        ;----------------
        .if al == 'q'
            jmp _do_end
        .elseif al == 'x'
            call small
        .else
            push offset szError
            call cout
        .endif
        jmp _while
    _do_end:
        ret
main endp

;############################################

dwIout   equ [ebp - 4]
dwCnt    equ [ebp - 8]

cout proc
    push ebp
    mov ebp, esp
    add esp, -8
    ;----------------
    push ebx
    push esi
    push edi
    ;----------------
    push -11
    call GetStdHandle@4
    mov dword ptr dwIout, eax
    ;----------------
    mov esi, dword ptr[ebp + 8]
    push esi
    call lens
    ;----------------
    push 0
    ;----------------
    lea ebx, dwCnt
    ;----------------
    push ebx
    push eax
    push esi
    push dword ptr[ebp - 4]
    call WriteConsoleA@20
    ;----------------
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret 4
cout endp

;############################################

dwNum   equ [ebp - 4]

cin proc
    push ebp
    mov ebp, esp
    add esp, -4
    ;----------------
    push ebx
    push esi
    push edi
    ;----------------
    mov edi, dword ptr[ebp + 8]
    ;----------------
    push -10
    call GetStdHandle@4
    ;----------------
    lea esi, dwNum
    ;----------------
    push 0
    push esi
    push MAX_SIZE
    push edi
    push eax
    call ReadConsoleA@20
    ;----------------
    sub dword ptr[esi], 2
    mov esi, dword ptr[esi]
    ;----------------
    mov byte ptr[edi + esi], 0
    ;----------------
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret 4
cin endp

;############################################

lens proc
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    ;----------------
    mov esi, dword ptr[ebp + 8]
    xor ecx, ecx
    ;----------------
    jmp _for
    _in:
        inc ecx
    _for:
        cmp byte ptr[esi + ecx], 0
        jnz _in
    mov eax, ecx
    ;----------------
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret 4
lens endp

;############################################

small proc
    enter 0, 0
    push ebx
    push esi
    push edi
    ;----------------
    push offset szSmall
    call cout
    ;----------------
    pop edi
    pop esi
    pop ebx
    leave
    ret
small endp

_TEXT ENDS
END START
