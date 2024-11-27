.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp

    # Zero rgisters
    xorq %rax, %rax
    xorq %rbx, %rbx
    xorq %rdx, %rdx

    # Sign extend vs. Zero extend
    movb  $0xFF, %bl
    movzbq %bl, %rdx
    movsbq %bl, %rax

    popq	%rbp
    ret
