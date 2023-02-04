# This is Part B - c
# Gautam Kumar Mahar (2103114)

.text
.globl main

main:
	ori $5,$0,2         # Load the value 2 into register $5 using "ori" instruction
	ori $8,$0,18        # Here is x==18 because our output in part a is 18 (In decimal) and x is in the expression (2x+3)^2 
	ori $9,$0,3       # Load the value 3 (constant value in the expression)into register 9 
        mult $5,$8          # Use the "mult" instruction to multiply register 5 and register 8 (means 2*x in the expression) 
        mflo $10           # Here is use "mflo" instruction to move the above value in register 10
        add $11,$10,$9      # Use the "add" instruction to add value of register 10 and register 9 and store the sum in register 11
        mult $11,$11     # then multiplies the value in $11 by itself
        mflo $13      # and store final value in register 13

##End

  