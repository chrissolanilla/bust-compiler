global _start

section .data
char: db 0

fizz: db "fizz", 0
new_line: db 10, 0

section .text
_start:
mov rbx, 1
jmp loop

loop:
cmp rbx, 101
je exit

mov ecx, 2
mov eax, ebx
xor edx, edx
div ecx
cmp edx, 0
je print_fizz

call print_new_line
call number_to_ascii
add rbx, 1
jmp loop

print_fizz:
mov rax, 1
mov rdi, 1
mov rdx, 4
loadEffectiveAddress rsi, [rel fizz]
syscall
jmp after_fizz

after_fizz:
call print_new_line
call number_to_ascii
add rbx, 1
jmp loop

print_new_line:
push rbx
mov rax, 1
mov rdi, 1
loadEffectiveAddress rsi, [rel new_line]
mov rdx, 1
syscall
pop rbx
ret

number_to_ascii:
cmp rbx, 9
jg divide_by_10

mov ebp, ebx
add ebp, 48
mov byte [char], bpl
call print_char
ret

print_char:
mov rax, 1
mov rdi, 1
loadEffectiveAddress rsi, [rel char]
mov rdx, 1
syscall
ret

divide_by_10:
mov eax, ebx
xor edx, edx
mov ecx, 10
div ecx

mov ebp, eax
add ebp, 48
mov byte [char], bpl

mov ebp, edx
call print_char

add ebp, 48
mov byte [char], bpl
call print_char
ret

exit:
mov rax, 60
mov rdi, 69
syscall

