/* 211788625 Evyatar Paz */
.extern printf
.extern scanf
.extern pstrlen
.extern swapCase
.extern pstrijcpy
.section .rodata
choice_31_String: 
    .string "first pstring length: %hhd, second pstring length: %hhd\n"
choice_33_String: 
    .string "length: %hhu, string: %s\n"
choice_34_String: 
    .string "length: %hhu, string: %s\n"
Invalid_Option_String: 
    .string "invalid option!\n"
scanf_num_char:
    .string " %hhu"

.section .text
.global run_func
.type run_func, @function

# choice: %rdi, &pstr1: %rsi, &pstr2: %rdx
run_func:
    pushq %rbp
    movq %rsp, %rbp
    cmpq $31, %rdi
    je choice_31_pstrlen
    cmpq $33, %rdi
    je choice_33_swapCase
    cmpq $34, %rdi
    je choice_34
    jmp Invalid_Option

choice_31_pstrlen:
    movq %rsi, %rdi # save &pstr1 in rdi
    xorq %rax, %rax 
    call pstrlen 
    movq %rax, %rsi # save the len of pstr1 string in rsi
    movq %rdx, %rdi # save &pstr2 in rdi
    xorq %rax, %rax
    call pstrlen
    movq %rax, %rdx # save the len of pstr2 string in rdx
    movq $choice_31_String, %rdi
    call printf
    jmp end

choice_33_swapCase:
    movq %rsi, %rdi # save &pstr1 in rdi
    xorq %rax, %rax 
    call swapCase 
    movq %rax, %r13 # save the new &pstr1 in r13
    movq %rdx ,%rdi # save &pstr2 in rdi
    xorq %rax, %rax
    call swapCase
    movq %rax, %r14 # save the new &pstr2 in r14
    movq $choice_33_String, %rdi
    movzb (%r13), %rsi # put the length of pstr1 in rsi
    addq $1 ,%r13 # inc r13 to point to the string of pstr1
    movq %r13, %rdx # put the address of the string in pstr1 into rdx
    xorq %rax, %rax
    call printf
    movq $choice_33_String, %rdi
    movzb (%r14), %rsi # put the length of pstr2 in rsi
    addq $1 ,%r14 # inc r14 to point to the string of pstr2
    movq %r14, %rdx # put the address of the string in pstr2 into rdx
    call printf
    jmp end

choice_34:
    movq %rsi, %r12 # save &pstr1 in r12
    movq %rdx, %r13 # save &pstr2 in r13
    subq $16, %rsp # allocate 64 bytes for scanf
    movq %rsp, %rsi # save the address of scanf buffer in rsi
    movq $scanf_num_char, %rdi # scanf format
    xorq %rax, %rax 
    call scanf 
    movq %rsp, %rdi # save the address of scanf buffer in rdi
    movzb (%rdi),%r14 # save the first char/number in r14
    movq $scanf_num_char, %rdi 
    movq %rsp, %rsi # save the address of scanf buffer in rsi
    xorq %rax, %rax 
    call scanf 
    movq %rsp, %rdi # save the address of scanf buffer in rdi
    movzb (%rdi),%r15 # save the second char in r15
    addq $16, %rsp # free the scanf buffer
    movq %r14, %rdx # save the first char in rdx
    movq %r15, %rcx # save the second char in rcx
    movq %r12, %rdi # save &pstr1 in rdi
    movq %r13, %rsi # save &pstr2 in rsi
    xorq %rax, %rax
    call pstrijcpy 
    movq %rax, %r12 # save &pstr1 in r12
    movq %rsi, %r13 # save &pstr2 in r13
    movq $choice_34_String, %rdi
    movzb (%r12), %rsi # put the length of pstr1 in rsi
    addq $1 ,%r12 # inc r12 to point to the string of pstr1 
    movq %r12, %rdx # put the string of pstr1 in rdx
    xorq %rax, %rax
    call printf
    movq $choice_34_String, %rdi
    movzb (%r13), %rsi # put the length of pstr2 in rsi
    addq $1 ,%r13 # inc r13 to point to the string of pstr2
    movq %r13, %rdx # put the string of pstr2 in rdx
    xorq %rax, %rax
    call printf
    jmp end
Invalid_Option:
    movq $Invalid_Option_String, %rdi
    call printf
    jmp end
end:
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
