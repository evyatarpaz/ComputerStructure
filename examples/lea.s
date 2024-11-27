.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp

    # Zeroing registers
    xorq %rax, %rax
    xorq %rbx, %rbx
    xorq %rcx, %rcx

    # Some examples for lea
    movq $0x1, %rax
    movq $0x2, %rbx
    leaq 5(%rax, %rbx, 4), %rcx # rcx = 5 + rax + rbx * 4

    movq $0x2, %rax
    movq $0x3, %rbx
    leaq 7(, %rbx, 1), %rcx # rcx = 7 + rbx

    popq	%rbp
    ret
