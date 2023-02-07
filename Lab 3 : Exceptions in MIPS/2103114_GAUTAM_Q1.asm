# Gautam Kumar Mahar 2103114
# Lab 3 - First
.data

Start_Message: .asciiz "Please Enter Input string: " 
Last_Message: .asciiz "Here is Reversed string: "

# Here is allocate 256 bytes for user input 
userString: .space 256 
newline: .asciiz "\n" 

.text 

main:
    # Print the Start message
    li $v0, 4
    la $a0, Start_Message
    syscall 

    # Get user input and store it in userString
    li $v0, 8 
    la $a0, userString 
    li $a1, 256 
    syscall  

    # Store the address of the start of the user input
    add $t0, $a0, $zero 
    lb $t5, newline 

    # Find the end of the string
    find_end:
        beq $t5, $t1, end 
        lb $t1, ($t0) 
        addi $t0, $t0, 1 
        bne $t1, $zero, find_end  
    end:
        # Move the pointer two spaces back to avoid reversing newline character
        addi $t0, $t0, -2 

    # Reverse the string
    swap:
        lb $t2, ($a0)   
        lb $t3, ($t0)  
        sb $t2, ($t0)  
        sb $t3, ($a0)
        addi $a0, $a0, 1
        addi $t0, $t0, -1
        ble $a0, $t0, swap  

    # Print the Last message
    li $v0, 4
    la $a0, Last_Message
    syscall

    # Print the reversed string
    li $v0, 4
    la $a0, userString
    syscall 

    # Exit the program
    li $v0, 10
    syscall 
