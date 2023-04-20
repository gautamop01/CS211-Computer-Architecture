.data
prompt: .asciiz "Enter a positive integer value for x: "
result: .asciiz "The result is: "
newline: .asciiz "\n"

.text
.globl main
main:
    # Prompt the user for input
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read the user input
    li $v0, 5
    syscall
    move $s0, $v0   # save user input in $s0
    
    # Calculate the expression 2x^2 + 5x + 7
    mul $t0, $s0, $s0   # $t0 = x^2
    li $t1, 2           # $t1 = 2
    mul $t0, $t0, $t1   # $t0 = 2x^2
    li $t2, 5           # $t2 = 5
    mul $t2, $t2, $s0   # $t2 = 5x
    add $t3, $t0, $t2   # $t3 = 2x^2 + 5x
    li $t4, 7           # $t4 = 7
    add $t5, $t3, $t4   # $t5 = 2x^2 + 5x + 7
    
    # Print the result
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit the program
    li $v0, 10
    syscall

