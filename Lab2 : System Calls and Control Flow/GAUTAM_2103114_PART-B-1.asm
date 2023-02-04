# This is Part B - a
# Gautam Kumar Mahar (2103114)

.data
array:	.word 10 , 12 , 15 , -10 , 13, 82 , -9 , 4 , 3 , -7  #array={10,12,15,-10,13,82,-9,4,3,-7}
length:	.word 10	 #load the length of the array as 10
sum: .word 0	 #initialise sum to 0

.text

.globl main  # Here is Start the main function
main:

la $t3,array		# load base address of the array		
li	$6,0x00000000	# Initialize $6 as 0				
lw	$7,length	# Load length of the array into $7						
lw $8,sum		# Load sum into $8								

addLoop:    # Start the loop						
beq	$7,$6,endLoop   # If length of the array is equal to counter $6, then jump to end					
	
lw      $9,($t3)       # Load word at address $t3 into $9															
add	$8,$8,$9	# Add the value of $9 to sum stored in $8

addi	$t3,$t3,0x00000004						
addi $6,$6,0x00000001	# Increment the value of $6 by 1 to keep track of the for loop				
j addLoop		# Jump back to the start of the for loop					

endLoop:			# End loop								
	li $v0,1		# Load system call 1 into $v0 (print integer)								
	add $a0,$8,0x00000000	# Load sum into $a0 <- Result Stored				
	syscall			# Make system call						
