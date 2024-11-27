.extern printf
.extern scanf

.section .data
user_string:
    .space 255, 0x0

.section .rodata
user_greet_fmt:
    .string "Please enter a string: "
scanf_fmt:
    .string "%255s"
result_fmt:
    .string "Here you go: %s\n"

.section .text
.globl main
.type	main, @function 
main:
    # Enter
    pushq %rbp
    movq %rsp, %rbp    

    # Print the prompt
    movq $user_greet_fmt, %rdi
    xorq %rax, %rax
    call printf

    # Read the string
    movq $scanf_fmt, %rdi
    movq $user_string, %rsi
    xorq %rax, %rax
    call scanf

    # Change every instance of 'a' to 'B'
    movq $user_string, %rdi
.loop:
    # Read byte from string
    movb (%rdi), %al

    # If we're at the end of the string, exit
    cmpb $0x0, %al
    je .done

    # If the byte is 'a', change it to 'B'
    cmpb $0x61, %al
    jne .next
    movb $0x42, (%rdi)

.next:
    # Increment the pointer, and continue to next iteration
    incq %rdi
    jmp .loop

.done:
    # Print the result
    movq $result_fmt, %rdi
    movq $user_string, %rsi
    xorq %rax, %rax
    call printf

    # Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
