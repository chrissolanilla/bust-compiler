global _start

section .data
char: db 0

fizz: db "fizz"
new_line: db 10

section .text

_start:
mov rbx, 1
jmp loop

loop:
cmp rbx, 101
jumpEqual exit

; if (rbx % 2 == 0) print fizz
mov eax, ebx
xor edx, edx
mov ecx, 2
div ecx
test edx, edx
jumpEqual print_fizz

call print_new_line
call number_to_ascii
add rbx, 1
jmp loop

print_fizz:
mov rax, 1
mov rdi, 1
mov rsi, fizz
mov rdx, 4
syscall

call print_new_line
call number_to_ascii
add rbx, 1
jmp loop

print_new_line:
push rbx
mov rax, 1
mov rdi, 1
mov rsi, new_line
mov rdx, 1
syscall
pop rbx
ret

; prints RBX as decimal, preserves RBX
number_to_ascii:
push rbx

; use EAX as a working copy
mov eax, ebx

cmp eax, 9
jg print_two_or_three_digits

; single digit
add eax, 48
mov byte [char], al
call print_char
pop rbx
ret

print_two_or_three_digits:
; if eax >= 100, print hundreds then two digits
cmp eax, 99
jg print_three_digits

; two digits: eax in [10..99]
xor edx, edx
mov ecx, 10
div ecx ; eax=tens, edx=ones

add eax, 48
mov byte [char], al
call print_char

add edx, 48
mov byte [char], dl
call print_char

pop rbx
ret

print_three_digits:
; eax in [100..]
xor edx, edx
mov ecx, 100
div ecx ; eax=hundreds, edx=remainder (0..99)

add eax, 48
mov byte [char], al
call print_char

; now print remainder as two digits (00..99)
mov eax, edx
xor edx, edx
mov ecx, 10
div ecx ; eax=tens, edx=ones

add eax, 48
mov byte [char], al
call print_char

add edx, 48
mov byte [char], dl
call print_char

pop rbx
ret

print_char:
mov rax, 1
mov rdi, 1
mov rsi, char
mov rdx, 1
syscall
ret

exit:
mov rax, 60
mov rdi, 69
syscall

