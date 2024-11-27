.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp
    
    # Example 1
    movq   $0xFFFFFFFF00000000, %rax
    addl   $0x00000000AAAAAAAA, %eax

    # Example 2
    movq   $0xFFFFFFFFAAAAAAAA, %rbx
    movl   %ebx, %ebx

    popq	%rbp
    ret
