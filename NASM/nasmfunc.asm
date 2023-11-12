global Write
global NASMSize

extern GetStdHandle
extern WriteFile
extern ExitProcess

section .text
NASMSize:
    ; Size
    ; INPUT
    ; RCX - адрес строки
    ; OUTPUT
    ; R10 - длинна строки
    ; R11 - длинна строки

    mov r10, rcx
    call ComputeLen
    mov rax, r11
    ret



Write:
    ; Write
    ; INPUT
    ; RCX - адрес строки
    ; OUTPUT
    ; R10 - адрес строки
    ; R11 - длинна строки

    mov r10, rcx
    call ComputeLen

    ; Сам вывод
    sub rsp, 40
    mov rcx, -11
    call GetStdHandle
    mov rcx, rax
    mov rdx, r10
    mov r8, r11
    xor r9, r9
    mov qword [rsp + 32], 0
    call WriteFile
    add rsp, 40

    ret

ComputeLen:
    mov rdi, 0
    mov al, 0
    call LoopLen
    ret
LoopLen:
    cmp byte [r10 + rdi], al
    je EndLoop
    inc rdi
    cmp rdi, 2048
    je EndLoopError
    jmp LoopLen
EndLoop:
    mov r11, rdi ; R11 - Длинна строки
    ret
EndLoopError:
    mov rcx, 1
    call ExitProcess
