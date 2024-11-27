/* 211788625 Evyatar Paz */
.extern printf
.section .rodata
InvalidInputString:
    .string "invalid input!\n"

.section .text
.global pstrlen
.type pstrlen, @function
    # pstring in rdi
pstrlen:
    pushq %rbp
    movq %rsp, %rbp
    movzb (%rdi), %rax # move the first byte that represents the length of the string to rax
    popq %rbp
    ret

.global swapCase
.type swapCase, @function
    # pstring in rdi
swapCase:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12 # save r12
    movq %rdi, %r12 # save pstring in r12
    movzb (%rdi), %rax # move the first byte that represents the length of the string to rax
    addq $1, %rdi # increment rdi to point to the first character of the string

    # loop over the string
LoopCase:
    cmpb $0, %al # check if the length of the string is 0
    je End_swapCase
    subb $1, %al # decrement the length of the string

    # check if the character is a uper or lower or not a letter by the acsii table
    movzb (%rdi), %rsi # move the character to rsi
    cmpq $0x40, %rsi # check if the character is not a letter
    jle NextChar
    cmpq $0x5A, %rsi # check if the character is a uppercase letter
    jle ToLowercase
    cmpq $0x60, %rsi # check if the character is not a letter
    jle NextChar
    cmpq $0x7A, %rsi # check if the character is a lowercase letter
    jle ToUppercase
    cmpq $0x7B, %rsi # check if the character is not a letter
    jge NextChar

    # change the case of the character to lowercase
ToLowercase:
    addq $0x20, %rsi
    movb %sil, (%rdi)
    addq $1, %rdi
    jmp LoopCase

    # change the case of the character to uppercase
ToUppercase:
    subq $0x20, %rsi
    movb %sil, (%rdi)
    addq $1, %rdi
    jmp LoopCase

    # move to the next character
NextChar:
    addq $1, %rdi
    jmp LoopCase

    # return the pointer to the pstring
End_swapCase:
    movq %r12, %rax # move the pointer to the pstring to rax
    movq %rax, %rdi
    popq %r12
    popq %rbp
    ret

.global pstrijcpy
.type pstrijcpy, @function
# ptstring1 in rdi, ptstring2 in rsi, i in rdx, j in rcx
pstrijcpy:
    pushq %rbp
    movq %rsp, %rbp
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rdi, %r13 # save ptstring1 in r13
    movq %rsi, %r14 # save ptstring2 in r14
    cmpq $0, %rdx # check if i is negative
    jb InvalidInput
    cmpq $0, %rcx # check if j is negative
    jb InvalidInput
    cmpq %rdx, %rcx # check if i is bigger than j
    jb InvalidInput
    movzb (%rdi), %rdi # move the first byte that represents the length of the string to rdi
    movzb (%rsi), %rsi # move the first byte that represents the length of the string to rsi
    cmpq %rdi, %rcx # check if j is bigger or equal than the length of the first string
    jae InvalidInput
    cmpq %rsi, %rcx # check if j is bigger or equal than the length of the second string
    jae InvalidInput
    movq %r13, %rdi # move ptstring1 to rdi
    movq %r14, %rsi # move ptstring2 to rsi
    leaq 1(%rdi, %rdx, 1), %rdi # move the pointer to the i-th character of the first string to rdi
    leaq 1(%rsi, %rdx, 1), %rsi # move the pointer to the i-th character of the second string to rsi
    subq %rdx, %rcx # calculate the length of the string that will be copied
    movq %rcx, %rax # move the length of the string that will be copied to rax
# copy the string in index i to j
strCpyLoop:
    cmpb $0x0, %al # check if j - i = 0
    jl End_pstrijcpy 
    movq %rax, %r12 # save the length of the string that will be copied in r12
    movb (%rsi), %al # move the character to be copied to al
    movb %al, (%rdi) # copy the character to the first string
    movq %r12, %rax # move j - i rax
    addq $1, %rdi # move to the next character of the first string
    addq $1, %rsi # move to the next character of the second string
    subb $0x1, %al # decrement j - i by 1
    jmp strCpyLoop
InvalidInput:
    movq $InvalidInputString, %rdi
    xorq %rax, %rax
    subq $8, %rsp # align the stack i did 3 push so i need to align it to be divisible by 16
    call printf
    addq $8, %rsp # return the stack to the original position
    jmp End_pstrijcpy
End_pstrijcpy:
    movq %r13, %rdi # move ptstring1 to rdi
    movq %r14, %rsi # move ptstring2 to rsi
    movq %rdi, %rax # move ptstring1 to rax
    popq %r14
    popq %r13
    popq %r12
    popq %rbp
    ret
