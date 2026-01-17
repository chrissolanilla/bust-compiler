.global _start
.intel_syntax noprefix

.section .data
//  char db 0 this only works on nasm syntax, not gas
    char:
        .byte 0

.section .text

_start:
    //first i need to print 1
    //move the value of 1 into some register
    mov rbx, 1
    jmp loop

loop:
    cmp rbx, 101
    //if it is equal to 11, then we exit
    je exit

    //first see if div by 2 or 3
    //make exc our divisor
    mov ecx, 2
    //move our number to get divided into rax
    mov eax, ebx
    div ecx
    //remainder is stored in edx, check if 0
    cmp edx, 0
    je print_fizz


    //if we dont exit, then we want to convert our number to ascii and then print
    //call ready_print
    call print_new_line
    call number_to_ascii
//    call print_char
    //increment by 1
    add rbx, 1
    jmp loop

print_fizz:
    mov rax, 1
    mov rdi, 1
    mov rdx, 4
    lea rsi, [fizz]
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
    lea rsi, [new_line]
    mov rdx, 1
    syscall
    pop rbx
    ret

number_to_ascii:
    //if it is over 9, then it would print something else.
    //we need to divide our number by 10 repeatdly and get the remainder
    //then print in reverse order
    cmp rbx, 9
    //jump greater
    jg divide_by_10
    //HELP ME THINK HERE!!!!
    //when we call ret on divide_by_10, does it return here?
    //im confused here cause we already printed result and remiander so do we print again?
    mov ebp, ebx
    //add by 48 to make it ascii
    add ebp, 48
    //now we store this into a memory address
    //mov [char], rbp    this dosent work cause its a 64 bit register into 1 byte
    mov byte ptr [char], bpl
    call print_char
    ret

print_char:
    //push rbx
    mov rax, 1
    mov rdi, 1
    //mov rsi, char
    lea rsi, [char]
    mov rdx, 1
    syscall
    //pop rbx
    ret

divide_by_10:
    //TODO. have a dividend, divisor, and store remainder
    mov eax, ebx
    //clear it or else we get garbage
    xor edx, edx
    mov ecx, 10
    div ecx
    //remainder is stored in edx.
    //result is stored in eax
    //so in the case of 10, we get eax = 1, and edx is 0
    //in 11, we get eax 1, edx is 1
    //in 100, we get eax 10, edx is 0
    //we pass in 10 and we get eax 1 and edx 0. Now we print these?
    //lets print the result first
    mov ebp, eax
    add ebp, 48
    mov byte ptr [char], bpl
    //move the value in rdx first before it gets modified
    mov ebp, edx
    call print_char

    //now print the remainder
    //mov ebp, edx
    add ebp, 48
    mov byte ptr [char], bpl
    call print_char

    ret
    //TODO, jump somewhere bac to number to ascii
    //now i can just jump back to loop?
    //jmp loop


fizz:
    .asciz "fizz"

new_line:
    .asciz "\n"

exit:
    //exit and return 59 cause 59 is cool
    mov rax, 60
    mov rdi, 69
    syscall

