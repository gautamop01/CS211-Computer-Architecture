# This is Part B - b
# Gautam Kumar Mahar (2103114)

.text
.globl main

main:
	ori $8,$0,0xFFFF # Here Load the hex value FFFF into register $8
	sll $9, $8, 2    # the "sll" instruction is used for left shift operation 
        sw $9,0x10000000 # and "sw" instruction is used to store the value of $9 register in the memory location 0x10000000

##End

  