global _start

section .data

message:
db "this is fucking divine intellect", 10

messageLen: equ $ - message


section .text

_start:
mov rax, 1
mov rdi, 1
mov rdx, 4
lea rsi, [rel message]
mov rdx, messageLen
syscall

mov rax, 60
mov rdi, 0
syscall

