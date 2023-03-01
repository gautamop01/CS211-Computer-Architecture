# Problem - Find the maximum of the three expressions: x*x ; x*y ; y*5. Take x and y as input from user.
# Write a global subroutine, in another file, to calculate values of these expressions. Write a
# subroutine to find maximum of two integers and use it to find the maximum of these three
# expressions. Display the result.


# Subroutine to check which of two integers is greater
# Input: $a0 - first integer, $a1 - second integer
# Output: $v0 - the larger integer

# -----------------------------------------------------------------------------------------------------------

.globl Checking_Greatest_value # global declaration

Checking_Greatest_value:
	lw $t3, ($sp)  # Load first integer into $t3 (x)
	addiu $sp, $sp, 4  # Increment stack pointer by 4 bytes to access second integer

	lw $t4, ($sp) #  # Load second integer into $t4
	addiu $sp, $sp, 4  # Increment stack pointer by 4 bytes to exit subroutine

	bge $t3, $t4, BRANCH1 # If first integer is greater or equal to second integer, branch to label BRANCH1
	lw $t3,	($sp) # Otherwise, load second integer into $t3
	
	j FIRSTEXIT # if x < y  # Jump to label FIRSTEXIT

	BRANCH1:	lw $t4, ($sp) # t4 = y # Label BRANCH1 and Load second integer into $t4
	
	FIRSTEXIT:	bge $t3, $t4, BRANCH2 # Label FIRSTEXIT and If $t3 is greater or equal to $t4, branch to label BRANCH2
			add $v0, $0, $t4	# v0 = y  # Otherwise, store $t4 in $v0 and jump to label SECONDEXIT
			j SECONDEXIT	# if x < y goto SECONDEXIT

			BRANCH2:	# Label BRANCH2
				add $v0, $0, $t3	# v0 = x
			SECONDEXIT:   # Label SECONDEXIT

	jr $ra	# Return to calling function


# Subroutine to calculate the values of x*x, x*y, and y*5
# Input: $a0 - first integer (x), $a1 - second integer (y)
# Output: The values of x*x, x*y, and y*5 are stored on the stack
.globl All_multiplication_terms # global declaration

All_multiplication_terms:
	add $t3, $0, $a0 # t3 = x # Copy value of x into $t3
	add $t4, $0, $a1 # t4 = y # Copy value of x into $t3

	mul $t3, $t3, $t3 # t3 = x*x # Multiply $t3 by itself to calculate x*x
	addiu $sp, $sp, -4 # sp = sp - 4   # Decrement stack pointer by 4 bytes to store value of x*x
	sw $t3, ($sp)	# store t3 in stack # Store value of x*x on stack
	
	li $t3, 5	# Load the constant value 5 into $t3
	mul $t4, $t3, $t4 #  Multiply $t3 by $t4 to calculate y*5

	addiu $sp, $sp, -4	# Decrement stack pointer by 4 bytes to store value of y*5
	sw $t4, ($sp)	#  # Store value of y*5 on stack

	add $t3, $0, $a0 # t3 = x  # Copy value of x into $t3
	add $t4, $0, $a1 # t4 = y   # Copy value of y into $t4
	
	mul $t3, $t3, $t4 # t3 = x*y  # Multiply $t3 by $t4 to calculate x*y
	addiu $sp, $sp, -4	# sp = sp - 4  # Decrement stack pointer by 4 bytes
	sw $t4, ($sp)	# sp = sp + 4   # Store the result of x*y on the stack
	jr $ra	# jump to return address  

.data   # Data_Segment: define the strings to prompt user input
	num1: .asciiz "Now, Please Enter the value of X --> "
	num2: .asciiz "Now, Please Enter the value of Y --> "


# Text segment: program code
.text
.globl main

main:	
    # Prompt user to input value for X
	li $v0, 4	
	la $a0, num1 
	syscall	

    # Get user input for X
	li $v0, 5	
	syscall 
    
	# Store user input for X in $a1
	add $a1, $0, $v0 
	
	# Prompt user to input value for Y
	li $v0, 4	
	la $a0, num2 
	syscall	
     
	#  Get user input for Y
	li $v0, 5	
	syscall	
    
	# Store user input for Y in $a0
	add $a0, $0, $v0 # a0 = y

	# Call All_multiplication_terms subroutine to calculate x*x, x*y, and y*5
	jal All_multiplication_terms 

    # Call Checking_Greatest_value subroutine to find the maximum of the three expressions
	jal Checking_Greatest_value 

    # Move the result from $v0 to $a0 for printing
	add $a0, $0, $v0 # a0 = Checking_Greatest_value
    
	# Print the maximum value to the console
	li $v0, 1	# load v0 with 1 
	syscall 	# print a0
    
	# Exit the program
	li $v0, 10	
	syscall	

	