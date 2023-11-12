default rel

section .data
    error_message: db "Адрес строки не вычислен", 0
    error_message_len: equ $ - error_message

section .text
global ASMout

extern GetStdHandle
extern WriteFile

ASMout:
    mov r10, rcx ; R10 Лежит адрес строки
    call ComputeLen
    ;call EndFunction ; заменил jmp на call
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
    lea rdx, [r10] ; Загружаем адрес строки в rdx
    mov r11, rdi   ; R11 Длинна строки
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

EndLoopError:
    sub rsp, 40
    mov rcx, -11
    call GetStdHandle
    mov rcx, rax
    lea rdx, [error_message] ; Загружаем адрес строки в rdx
    mov r8, error_message_len
    xor r9, r9
    mov qword [rsp + 32], 0
    call WriteFile
    add rsp, 40
    ret

EndFunction:
    ret
