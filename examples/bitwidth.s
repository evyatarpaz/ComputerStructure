.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp
    
    # bitwidth = b (1 Byte)
    movb $0x0, %al
    movb %bl, %al
    movb %cl, (%rdi)

    # bitwidth = w (2 Byte)
    movw $0x0, %ax
    movw %bx, %ax
    movw %cx, (%rdi)

    # bitwidth = l (4 Byte)
    movl $0x0, %eax
    movl %ebx, %eax
    movl %ecx, (%rdi)

    # bitwidth = q (8 Byte)
    movq $0x0, %rax
    movq %rbx, %rax
    movq %rcx, (%rdi)

    # Sometimes, mnemonics have more than one letter suffix
    movzbl %bl, %eax
    movzwl %bx, %eax

    popq	%rbp
    ret