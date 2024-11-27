/* 211788625 Evyatar Paz */
.extern printf
.extern scanf
.extern rand
.extern srand

.section .data
configuration_seed:
    .space 4, 0x0
user_guess_space:
    .space 4, 0x5

.section .rodata
user_greet_prompt:
    .string "Enter configuration seed: "
user_guess_prompt:
    .string "What is your guess? "
scanf_num:
    .string "%d"
Incorrect_prompt:
    .string "Incorrect.\n"
Game_over_prompt:
    .string "Game over, you lost :(. The correct answer was %d\n"
You_won_prompt:
    .string "Congratz! You won!\n"
print_number:
    .string "%d\n"

.section .text
.globl main
.type	main, @function 
main:
    # Enter
    pushq %rbp
    movq %rsp, %rbp    

    # Print the prompt
    movq $user_greet_prompt, %rdi 
    xorq %rax, %rax
    call printf

    # get the seed
    movq $scanf_num, %rdi
    movq $configuration_seed, %rsi
    xorq %rax, %rax
    call scanf 

    # seed the random number generator
    movq $configuration_seed, %rdi
    movl (%rdi), %edi # get the seed 
    xorq %rax, %rax
    call srand

    # get a random number
    xorq %rax, %rax
    call rand # get a random number put it in rax

    # rand number % 10
    movq $10, %rsi # rsi = 10
    xorq %rdx, %rdx
    divq %rsi # rdx = rax % rsi , divad by 10
    movq %rdx, %r12 # r12 = rdx
    xorq %r15, %r15

loop:
    # check if the user has guessed 5 times
    cmpq $5, %r15 # compare r15 to 5
    je Game_over # if they are equal, jump to Game_over, if you guessed 5 times, you lose
    incq %r15

    # Print the prompt
    movq $user_guess_prompt, %rdi
    xorq %rax, %rax
    call printf

    # get the guess from the user
    movq $scanf_num, %rdi 
    movq $user_guess_space, %rsi 
    xorq %rax, %rax 
    call scanf 

    # compare the guess to the random number
    movq $user_guess_space, %rdi 
    movq (%rdi), %rdi # get the guess
    cmpq %r12, %rdi # compare the guess to the random number
    je You_won # if they are equal, jump to You_won
    jne Incorrect # if they are not equal, jump to Incorrect

Incorrect:
    # Print the prompt
    movq $Incorrect_prompt, %rdi
    xorq %rax, %rax
    call printf
    jmp loop # jump back to the top of the loop

You_won:
    # Print the prompt
    movq $You_won_prompt, %rdi
    xorq %rax, %rax
    call printf
    jmp exit # jump to exit

Game_over:
    # Print the prompt
    movq $Game_over_prompt, %rdi 
    movq %r12, %rsi # put the random number in rsi
    xorq %rax, %rax
    call printf
    jmp exit # jump to exit

exit:
    movq %rbp, %rsp
    popq %rbp
    xorq %rax, %rax
    ret
    