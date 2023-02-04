# This is Part B - b
# Gautam Kumar Mahar (2103114)

.data
array:  .word 10 , 12 , 15 , -10 , 13 , 82 , -9 , 4 , 3 , -7, 10 , 20 , 30 , 40 , 50 , 77
length:	.word 16    # length of the array							  	
sum:    .word 0	    #initialise sum to 0								 
.text

main:
la $t3,array	# load base address of the array										
lw $15,length	#Load the length of the array in $15								  
lw $17,sum	#Load the initial value of the sum in $17							

li $3,0	    # Initialize a counter to 0						
addLoop:    # Start loop
										 
beq $13,$15,endLoop	# Check if the counter has reached the length of the array								
lw $12,0($t3)	# Load the $t3 into $12									 
add $17,$17,$12	 # Add the current number to the sum						

addi $t3,$t3,4  # Increment address pointer to next number in the array 						
addi $13,$13,1	# Increment the counter								  
j addLoop 		# Jump back to the start 								
endLoop:	# End loop									
	sw $17,sum   # Store the Sum <-- Result									  