.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp
    
    # -------- addressing modes --------

    movl $1, 0x604892          # address is constant value

    movl $1, (%rax)            # address is in register %rax

    movl $1, -24(%rbx)         # address = -24 + %rbx

    movl $1, (%rax, %rcx)      # address = %rax + %rcx

    movl $1, 0x4(%rax, %rcx)   # address = 4 + %rax + %rcx

    movl $1, (%rax, %rcx, 8)   # address = %rax + %rcx * 8

    movl $1, 8(%rax, %rdi, 4)  # address = 8 + %rax + %rdi * 4

    movl $1, 0x8(, %rdx, 4)    # address = 8 + %rdx * 4

    # ----------------------------------

    popq	%rbp
    ret