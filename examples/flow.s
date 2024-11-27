.section .text
.globl	main
.type	main, @function 
main:
    pushq	%rbp
    movq	%rsp, %rbp

    # Zero out registers
    xorq %rax, %rax # rax = 0
    xorq %rbx, %rbx # rbx = 0

    # Intialize with values
    movb $0xff, %al # al = -1 (signed), al = 0xff (unsigned)
    movb $0x0f, %bl # bl = 15 (signed), bl = 0x0f (unsigned)

    # Control flow
    cmpb %al, %bl    # bl - al
    jg  greater_than # Jump if bl - al > 0
    jl  less_than    # Jump if bl - al < 0 

    # ...What if we used ja and jb instead?

greater_than:
    movq $0x1, %rax
    jmp end

less_than:
    movq $0x2, %rax
    jmp end

end:
    popq	%rbp
    ret
