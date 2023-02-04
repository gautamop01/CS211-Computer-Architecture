# This is Part B - c
# Gautam Kumar Mahar (2103114)

.data
.text
main:

# Here is Load the values 1 and 21 into registers $20 and $21 respectively
li $20,1					
li $21,21							
li $22,0					

addLoop: # Start Loop							
beq $20,$21,endLoop  # Here is If $20 is equal to $21 then branch to over label					
# Here is Load the values in $20 and $21 into $a0 and $a1 respectively
add $a0,$20,$zero					
add $a1,$21,$zero					

# Here is Call the gcd function
jal gcd							

# If the value in $v0 is not equal to zero, branch to else label
bne $v0,$zero,else					 
j continue						


else:							  
addi $22,$22,1 # Here Increment the value in $22 by 1

continue:						
addi $20,$20,1 # Here Increment the value in $20 by 1

j addLoop  # Jump back to the start of the loop
					

endLoop:					
	j finish # Jump to the finish label				

gcd: # Start GCD Function	

# Here is Load the values in $a0 and $a1 into $13 and $14 respectively		
add $13,$a0,$zero					
add $14,$a1,$zero			

li $15,0x00000002    # Load the value 2 into register $15				
for: # Start For Loop
bgt $15,$13,end	     # If $15 is greater than $13, branch to end label					

div $13,$15  # Here Divide the value in $13 by $15 and store the result in $13						
mfhi $16						
div $14,$15  # Here Divide the value in $14 by $15 and store the result in $14	
mfhi $17		
add $18,$16,$17# Here Add the values in $16 and $18 and store the result in $18		

beq $18,$zero,return   # If $18 is equal to zero, branch to return label		
j condition # Otherwise, jump to condition label				

return:	# Start Return Block					
add $v0,$zero,$zero   # Here is Load the value 0 into $v0		
jr $ra	   # Return from the function							

condition:  # start condition Block						
addi $15,$15,1	# Increment the value in $15 by 1	
j for # Jump back to the start of the for loop				

end:
li $v0,1					
jr $ra						
finish:	# Start Finish Block					
	add $a2,$22,$zero  # Load the value in $22 into $a2 <-- Result		
	li $v0,1
	syscall
