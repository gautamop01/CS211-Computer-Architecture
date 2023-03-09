# Name - Gautam Kumar Mahar
# Roll N. 2103114

.data
	program_text: .asciiz "Exercise 1 Is Here - \nPLEASE GIVE INPUT --> "
	
    	INPUT_OF_DATE:  .asciiz "\nPlease Enter the date --> "     
    	INPUT_OF_MONTH: .asciiz "Please Enter the month --> "       
    	INPUT_OF_YEAR:  .asciiz "Please Enter the year --> "        

    	OUTPUT_OF_DATE: .asciiz "\nOUTPUT -\nHere is Next date --> "      
    	OUTPUT_OF_MONTH: .asciiz "\nHere is Next date month --> "
    	OUTPUT_OF_YEAR: .asciiz "\nHere is Next date year --> "  


.text

# Main function
main:
    	la $a0, program_text # Print program text
    	li $v0, 4
    	syscall

    	li $a0, 16  # Allocate memory for user input
    	li $v0, 9
    	syscall

    	move $t0, $v0        

    	la $a0, INPUT_OF_DATE # Prompt user for date input
    	li $v0, 4
    	syscall

    	li $v0, 5  # Read date input from user         
    	syscall

    	sw $v0, 0($t0) # Store date input in memory      

    	la $a0, INPUT_OF_MONTH # Prompt user for month input
    	li $v0, 4
    	syscall

    	li $v0, 5  # Read month input from user       
    	syscall

    	sw $v0, 4($t0) 	# Store month input in memory      
    	
    	la $a0, INPUT_OF_YEAR  # Prompt user for year input
    	li $v0, 4
    	syscall

    	li $v0, 5  # Read year input from user        
    	syscall

    	sw $v0, 8($t0) # Store year input in memory     

    	li $a0, 16  # Allocate memory for output       
    	li $v0, 9
    	syscall

    	sw $v0, 12($t0)  # Store output memory location in $t5   
    	move $t5, $v0       

    	lw $a1, 0($t0)  # Load input values into registers for processing    
    	lw $a2, 4($t0)      
    	lw $a3, 8($t0)       
    	move $a0, $t5        

    	li $t6, 0   # Set the day to the first of the month         
    	sw $t6, 12($t5)      
    	j NEXTDATE          

NEXTDATE:
     li $t6, 31        # Check if day is the last day of the month					
	beq $a1, $t6, CHANGE_MONTH

	li $t6, 31  # Check if day is the last day of the month, accounting for February and leap years
	jal CHECK_CHANGE_MONTH					
	beq $t9, $t6, CHANGE_MONTH				
	j DAYCHANGE						


DAYCHANGE:
	addi $t6, $a1, 1 	# Increment day by 1 and store in memory
	sw $t6, 0($a0)
	sw $a2, 4($a0)   # Store month and year in memory 
	sw $a3, 8($a0)

	j DONE  # Jump to DONE label



CHECK_CHANGE_MONTH:
    # Check if month is April, June, September, or November
	li $t7, 4
	beq $a2, $t7, MATCH_FOUND

	li $t7, 6
	beq $a2, $t7, MATCH_FOUND

	li $t7, 9
	beq $a2, $t7, MATCH_FOUND

	li $t7, 11
	beq $a2, $t7, MATCH_FOUND

	li $t7, 2   
	beq $a2, $t7, IF_FEB_FOUND   # Check if month is February

	li $t9, 0 # If not April, June, September, November, or February, return 0
	jr $ra



MATCH_FOUND:
	addi $t9 , $a1, 1  # Increment month by 1 and store in memory
	jr $ra



IF_FEB_FOUND:
	li $t8, 4  # Check if year is a leap year
	li $t9, 0
	
	div $a3, $t8
	mfhi $t8
	beq $t8, $t9, LEAPYEAR
	
	addi $t9, $a1, 3 # If not a leap year, increment month by 3 and store in memory
	jr $ra



LEAPYEAR:
	addi $t9, $a1, 2 # If a leap year, increment month by 2 and store in memory
	jr $ra



CHANGE_MONTH:
	li $t6, 1  # Set day to 1 and store in memory
	sw $t6, 0($a0)
    # Check if date is December 31
	li $t7, 43
	add $t8, $a2, $a1
	beq $t7, $t8, CHANGE_YEAR
    # If not December 31, increment month by 1 and store in memory
	addi $t6, $a2, 1
	sw $t6, 4($a0)
    # Store year in memory
	sw $a3, 8($a0)

	j DONE



CHANGE_YEAR:
	li $t6, 1  # Load the immediate value 1 into register $t6
	sw $t6, 4($a0)  # Store the value of $t6 into memory at the address $a0 + 4
	addi $t7, $a3, 1  # Add the value of $a3 and 1, and store the result in register $t7
	sw $t7, 8($a0)  # Store the value of $t7 into memory at the address $a0 + 8

	j DONE # Jump to the "DONE" label
	

DONE:
	la $a0, OUTPUT_OF_DATE   # Load the address of the "OUTPUT_OF_DATE" string into $a0
	li $v0, 4             # Load the value 4 into $v0
	syscall               # Execute the syscall to print the string

	lw $a0, 0($t5)   # Load the value at memory address $t5 + 0 into $a0
	li $v0, 1        # Load the value 1 into $v0
	syscall          # Execute the syscall to print the value of $a0

	la $a0, OUTPUT_OF_MONTH   # Load the address of the "OUTPUT_OF_MONTH" string into $a0
	li $v0, 4              # Load the value 4 into $v0
	syscall                # Execute the syscall to print the string

	lw $a0, 4($t5)   # Load the value at memory address $t5 + 4 into $a0
	li $v0, 1        # Load the value 1 into $v0, which corresponds to the "print integer" syscall
	syscall          # Execute the syscall to print the value of $a0

	la $a0, OUTPUT_OF_YEAR   # Load the address of the "OUTPUT_OF_YEAR" string into $a0
	li $v0, 4             # Load the value 4 into $v0, which corresponds to the "print string" syscall
	syscall               # Execute the syscall to print the string

	lw $a0, 8($t5)   # Load the value at memory address $t5 + 8 into $a0
	li $v0, 1        # Load the value 1 into $v0, which corresponds to the "print integer" syscall
	syscall          # Execute the syscall to print the value of $a0

	li $v0, 10       # Load the value 10 into $v0, which corresponds to the "exit" syscall
	syscall          # Execute the syscall to exit the program

    