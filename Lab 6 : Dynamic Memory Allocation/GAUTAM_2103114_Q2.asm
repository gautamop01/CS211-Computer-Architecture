# Name - Gautam Kumar Mahar
# Roll N. 2103114

.data
	INPUT_FOR_SIZE: .asciiz "PLEASE ENTER THE SIZE --> "
	INPUT_IN_SIZE: .asciiz "NOW ENTER THE INTEGER ONE BY ONE --> "
	SORTED_OUTPUT: .asciiz "HERE IS THE SORTED LIST --> "
	
	SPACEINT: .asciiz " " 
	LENGTH_OF_LIST: .space 4

.text
main:
	la $a0, INPUT_FOR_SIZE        # Load address of input message for size
	li $v0, 4                     # Set syscall code for print string
	syscall                       # Print input message

	li $v0, 5                     # Set syscall code for read integer
	syscall                       # Read integer from user input

	la $t0, LENGTH_OF_LIST        # Load address of length of list
	sw $v0, 0($t0)                # Store length of list in memory


	move $t3, $v0                 # Copy length of list to $t3

	la $a0, INPUT_IN_SIZE         # Load address of input message for integers
	li $v0, 4                     # Set syscall code for print string
	syscall                       # Print input message

	li $t4, 0                     # Counter for the number of integers entered
	li $t5, 0                     # Pointer to next node in list
	j LOOP                        # Jump to loop for reading integers

LOOP:
	beq $t4, $t3, INPUT_DONE      # If all integers have been entered, jump to input done

	li $a0, 8                     # Allocate 8 bytes for a new node
	li $v0, 9                     # Set syscall code for memory allocation
	syscall                       # Allocate memory for a new node

	move $t6, $v0                 # Copy address of new node to $t6
	li $v0, 5                     # Set syscall code for read integer
	syscall                       # Read integer from user input
	sw $v0, 0($t6)                # Store integer in memory
	sw $t5, 4($t6)                # Store address of next node in memory

	move $t5, $t6                 # Update pointer to next node
	addi $t4, $t4, 1              # Increment the counter

	j LOOP                        # Jump to loop for reading integers
	
INPUT_DONE:
	li $a0, 8					 # Allocate 8 bytes for a new node
	li $v0, 9					 # Set syscall code for memory allocation
	syscall                      # Allocate memory for a new node

	
	move $a0, $v0                # Copy address of new node to $a0

	li $t8, 0					 # Initialize counter for sorting loop
	sw $t8, 0($a0)               # Set value of the first node to 0
	sw $t5, 4($a0)               # Store address of next node in memory

	move $a3, $a0               # Copy address of new node to $a3

	move $t4, $t3				 # Copy length of list to $t4
	addi $t4, -1                # Decrement $t4 for the first pass of the sorting loop
	j SORT_LIST_LOOP           

# SORT_LIST_LOOP is a loop that executes until t4 equals 0
SORT_LIST_LOOP:
	# Load the value 0 into register t8
	li $t8, 0
	# If t4 is equal to 0, jump to SORTING_DONE
	beq $t4, $t8, SORTING_DONE

	# Move the value of register a3 to register a0
	move $a0, $a3
	# Jump to SORT_LIST_LOOP2
	j SORT_LIST_LOOP2

# SORT_LIST_LOOP2 is another loop that executes until t8 equals t4
SORT_LIST_LOOP2:
	# If t8 is equal to t4, jump to COMPLETE_LOOP2
	beq $t8, $t4, COMPLETE_LOOP2
	# Load the word from 4 bytes past the address in a0 into a1
	lw $a1, 4($a0)
	# Load the word from 4 bytes past the address in a1 into a2
	lw $a2, 4($a1)
	# Load the word from 0 bytes past the address in a1 into t5
	lw $t5, 0($a1)
	# Load the word from 0 bytes past the address in a2 into t6
	lw $t6, 0($a2)
	
	# Call the COMPARING function
	jal COMPARING

	# Add 1 to t8
	addi $t8, $t8, 1
	# Load the word from 4 bytes past the address in a0 into a0
	lw $a0, 4($a0)

	# Jump to SORT_LIST_LOOP2
	j SORT_LIST_LOOP2

# When SORT_LIST_LOOP2 is complete, subtract 1 from t4 and jump to SORT_LIST_LOOP
COMPLETE_LOOP2:
	addi $t4, $t4, -1
	j SORT_LIST_LOOP
	
# COMPARING is a function that compares the values in t5 and t6 and swaps them if t5 is greater than t6
COMPARING:
	# If t5 is greater than t6, jump to SWAP
	bgt $t5, $t6, SWAP
	# Otherwise, return from the function
	jr $ra

# SWAP is a function that swaps the values in a1 and a2
SWAP:
	# Load the word from 4 bytes past the address in a2 into t7
	lw $t7, 4($a2)
	# Store the value in t7 in the word 4 bytes past the address in a1
	sw $t7, 4($a1)

	# Store the address in a1 in the word 4 bytes past the address in a2
	sw $a1, 4($a2)

	# Store the address in a2 in the word 4 bytes past the address in a0
	sw $a2, 4($a0)

	# Return from the function
	jr $ra

SORTING_DONE:
	# load the sorted list address from $a3 to $a1
	lw $a1, 4($a3)

	# load the address of the output message to $a0 and print it
	la $a0, SORTED_OUTPUT
	li $v0, 4
	syscall
	
	# initialize a counter variable to 0 and jump to OUTPUT_PRINT_LIST
	li $t6, 0
	j OUTPUT_PRINT_LIST

OUTPUT_PRINT_LIST:
	# load the current value from the sorted list into $a0 and print it
	lw $a0, 0($a1)
	li $v0 , 1
	syscall

	# load the address of the space character to $a0 and print it
	la $a0, SPACEINT
	li $v0, 4
	syscall

	# load the next value address from the sorted list into $a1
	lw $a1, 4($a1)
	
	# if the next value address is 0, jump to FINAL, otherwise jump back to OUTPUT_PRINT_LIST
	beq $a1, $t6, FINAL
	j OUTPUT_PRINT_LIST

FINAL:
	# load the exit code (10) into $v0 and terminate the program
	li $v0, 10
	syscall


