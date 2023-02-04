# This is Part B - a
# Gautam Kumar Mahar (2103114)

.text
.globl main

main:
	ori $5,$0,100  #Load the value 100 into register $5
	ori $8,$0,82   #Load the value 82 into register $8
	sub $9,$0,$8   # Substract register $8 from zero and store the result in register $9
                       # the above step (sub $9,$0,$8 ) finds the 2's complement of 82
        add $10,$5,$9  # add the register $5 and $9 and store the result in register $10

##End

  