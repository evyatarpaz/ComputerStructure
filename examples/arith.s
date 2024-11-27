.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp

    # Zeroing rax
    xorq %rax, %rax

    # Logical shift vs. Arithmetic shift
    movb $0b11100101, %al # al = -27 (two's complement)
    shrb $3, %al          # al = 0b11100101 >> 3 = 0b00011100 = 28

    movb $0b11100101, %al # al = -27 (two's complement)
    sarb $3, %al          # al = 0b11100101 >> 3 = 0b11111100 = -4

    popq	%rbp
    ret
