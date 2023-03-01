# Problem - Find the square root of a number entered by the user. Apply Newton’s method to perform the
#calculations (Accurate up to 5 places of decimal).
#Hint: Newton&#39;s method is a way to compute the square root of a number. Say that n is the
#number and that x is an approximation to the square root of n.
#Then:
#x&#39; =(1/2)(x + n/x)
#x&#39; is an even better approximation to the square root.
#If x reaches the exact value, it stays fixed at that value.

.data
	const: .float 0.5         # constant value 0.5
	factor: .float 0.001      # factor value 0.001
	prompt: .asciiz "Please, Enter The Number --> "  # prompt message
	prompt1: .asciiz " \n "    # new line character
.text
main:
	addi $v0, $0, 4           # system call code for printing string
	la $a0, prompt            # load address of prompt message into $a0 register
	syscall                   # print prompt message
	addi $v0, $0, 6           # system call code for reading float value
	syscall                   # read float value from user input and store in $f0 register
	mov.s $f1, $f0            # copy user input to $f1 register

loop1:
	j NEWTON_METH              # jump to Newton's method function

loop:
	mul.s $f6, $f2, $f2       # calculate square of $f2 and store result in $f6 register
	sub.s $f7, $f6, $f0       # calculate difference between square of $f2 and user input, and store result in $f7 register
	abs.s $f7, $f7            # calculate absolute value of $f7 and store result in $f7 register
	
	lw $t2, factor            # load factor value into $t2 register
	mtc1 $t2, $f8             # move factor value to $f8 register
	c.le.s $f7, $f8           # compare $f7 with factor value
	bc1f loop1                # if $f7 is less than or equal to factor value, jump to loop1 label
	
	mov.s $f12, $f1           # copy the final result to $f12 register
	addi $v0, $0, 2           # system call code for printing float value
	syscall                   # print the final result
	addi $v0, $0, 10          # system call code for exiting the program
	syscall                   # exit the program
	
NEWTON_METH:
	div.s $f2, $f0, $f1       # calculate quotient of user input divided by $f1, and store result in $f2 register
	add.s $f2, $f2, $f1       # add $f1 to quotient and store result in $f2 register
	
	lw $t1, const             # load constant value into $t1 register
	mtc1 $t1, $f4             # move constant value to $f4 register
	
	mul.s $f2, $f2, $f4       # multiply $f2 with constant value and store result in $f2 register
	mov.s $f1, $f2            # copy new approximation to $f1 register
	
	j loop                    # jump back to loop label
endNEWTON_METH:               # end of Newton's method function
