# Gautam Kumar Mahar 2103114
# Lab 3 - Second
# QUESTION - 3
# Compute the dot product of two vectors each of length 5. Ask the user to enter the value of each element of the two vectors. Display the dot product. 
# (Hint: The dot product of two vectors is sum of the product of the corresponding elements. For example, (1,2,3) dot (4,5,6) is 1*4+2*5+3*6 = 32)

# My Test Case is (3,4,3,4,2) dot (1,2,3,4,5) = 46
# Second test case is (1,3,9,4,5) dot (2,2,2,2,2) = 44
.data
    VECTOR_FIRST: .word 0 , 0, 0, 0, 0 
    VECTOR_SECOND: .word 0 , 0, 0, 0, 0
    STRING_FIRST: .asciiz "ENTER THE FIRST VALUE IN FIRST VECTOR AT INDEX  "
    STRING_SECOND: .asciiz "ENTER THE FIRST VALUE IN SECOND VECTOR AT INDEX "
    STRING_THIRD: .asciiz " --> "
    STRING_FORTH: .asciiz "SO, HERE IS DOT PRODUCT :"

.text 

main:                           # Initialize two registers, $t3 and $t4, to 0   t3
        li $t3, 0 
        li $t4,0 

       
    INPUT_VECTOR_FIRST:          # Loop to input values for the first vector
        li $v0, 4 
        la $a0,STRING_FIRST
        syscall 

        li $v0,1                  # Print the current index for input
        move $a0,$t4
        syscall 

        li $v0, 4                 # Print a separator
        la $a0,STRING_THIRD
        syscall

        li $v0, 5                 # Read the input value
        syscall 

        addi $t4,$t4,1            # Store the value in memory and increment the index
        sw $v0,VECTOR_FIRST($t3) 
        addi $t3, $t3, 4 
        bne $t3, 20, INPUT_VECTOR_FIRST   # Repeat the loop until all values are inputted

        li $t3, 0      # Reset the two registers to 0 for the second loop
        li $t4,0  

    INPUT_VECTOR_SECOND:     # Loop to input values for the second vector
        li $v0, 4            # Print the prompt for input
        la $a0,STRING_SECOND 
        syscall 

        li $v0,1               # Print the current index for input
        move $a0,$t4 
        syscall

        li $v0, 4              # Print a separator
        la $a0,STRING_THIRD
        syscall 

        li $v0, 5                # Read the input value
        syscall 

        addi $t4,$t4,1           # Store the value in memory and increment the index
        sw $v0,VECTOR_SECOND($t3) 
        addi $t3, $t3, 4
        bne $t3, 20, INPUT_VECTOR_SECOND    # Repeat the loop until all values are inputted

        li $t3, 0       # Reset the two registers to 0 for the final calculation
        li $t4, 0 

    DOT_PRODUCT:                        # Loop to calculate the dot product of the two vectors
        lw $t5, VECTOR_FIRST($t3)       # Load two values from memory into $t5 and $t6
        lw $t6,VECTOR_SECOND($t3)
        mul $t7, $t5, $t6               # Multiply the two values stored in $t5 and $t6
        add $t4, $t4, $t7               # Add the result of multiplication to $t4
        addi $t3, $t3, 4                # Increment the memory address for next iteration
        bne $t3, 20, DOT_PRODUCT        # Repeat the above steps until $t3 reaches 20

    li $v0, 4                          # Display message "SO, HERE IS DOT PRODUCT :"
    la $a0,STRING_FORTH
    syscall 

    li $v0,1                 # Print the dot product result stored in $t4  
    move $a0,$t4 
    syscall 

    li $v0, 10             # Terminate the program 
    syscall 

