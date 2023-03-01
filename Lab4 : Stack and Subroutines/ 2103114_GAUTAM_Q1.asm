# Problem - Evaluate the expression ‘ab-10a+20b+16’. Consider that only $t0 and $t1 are available to
# store temporary values. Store a=10 and b=20 in data section. Use stack for other memory
# requirements. Display the sum.

.data
	
	prompt1: .asciiz "Please Enter The Number --> "
	
.text
main:
    # prompt the user to input a number and store it on the stack                    
	addi $v0, $0, 4 # set syscall to print string                                     
	la $a0, prompt1 # load the prompt string into $a0
	syscall
	addi $v0, $0, 5 # set syscall to read integer
	syscall 
	sw $v0, 0($sp)	# store the input value on the stack
	addi $sp, $sp, -4  # decrement stack pointer because we push element 

	# prompt the user to input another number and store it on the stack
	addi $v0, $0, 4
	la $a0, prompt1
	syscall
	addi $v0, $0, 5
	syscall
	sw $v0, 0($sp)		
	addi $sp, $sp, -4 # same here decrement 4 because now we push

	# load the values of a and b from the data section into $t0 and $t1
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	
	# calculate the value of ab and store it on the stack
	mult $t1, $t0
	mflo $t1
	sw $t1, 0($sp)		
	addi $sp, $sp, -4
	
	# calculate the value of -10a and store it on the stack
	addi $t1, $0, -10
	lw $t0, 12($sp)
	mult $t0, $t1
	mflo $t1
	
	sw $t1, 0($sp)		
	addi $sp, $sp, -4
	
	# calculate the value of 20b and store it on the stack
	addi $t1, $0, 20
	lw $t0, 12($sp)
	mult $t0, $t1
	mflo $t1
	
	sw $t1, 0($sp)		
	addi $sp, $sp, -4
	
	# add up all the values on the stack and store the result in $t1
	addi $t1, $0, 16
	
	lw $t0, 4($sp)
	add $t1, $t1, $t0
	
	lw $t0, 8($sp)
	add $t1, $t0, $t1
	
	lw $t0, 12($sp)
	add $t1, $t0, $t1
	
	# display the result to the user
	add $a0, $t1, $0
	addi $v0, $0, 1
	syscall

# exit the program
addi $v0, $0, 10
syscall
	
	
	
	
	