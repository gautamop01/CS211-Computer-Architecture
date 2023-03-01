# Problem - Evaluate the expression 2.5x 2 +4.3x+5. 
# Take x as input from the user. Display the result.
.data
float_a:      .float  2.5         # coefficient of x^2
float_b:     .float  4.3         # coefficient of x
int_c:      .float  5.0         # constant term

prompt: .asciiz "Please Enter the Value Of x -->"  # prompt for user input
blank:  .asciiz " "         # blank space string
newl:   .asciiz "\n"        # newline string

.text
.globl main

# Register Use Chart
# $f0 -- x               # holds the user input value
# $f2 -- sum of terms    # holds the final result

main:   
        la      $a0,prompt          # load the prompt string into $a0
        li      $v0,4               # set syscall to print string
        syscall                     # print the prompt string
        
        li      $v0,6               # set syscall to read float
        syscall                     # read the user input value and store it in $f0
        
        # evaluate the quadratic expression
        l.s     $f2,float_a               # load the coefficient of x^2 into $f2
        mul.s   $f2,$f2,$f0         # multiply $f2 by x^2 and store the result in $f2
        l.s     $f4,float_b              # load the coefficient of x into $f4
        add.s   $f2,$f2,$f4         # add $f4 times x to $f2 and store the result in $f2
        mul.s   $f2,$f2,$f0         # multiply $f2 by x and store the result in $f2
        l.s     $f4,int_c               # load the constant term into $f4
        add.s   $f2,$f2,$f4         # add the constant term to $f2 and store the result in $f2

        # print the result
        mov.s   $f12,$f2            # move the final result into $f12 (the float argument for syscall 2)
        li      $v0,2               # set syscall to print float
        syscall                     # print the final result
        
        la      $a0,newl            # load the newline string into $a0
        li      $v0,4               # set syscall to print string
        syscall                     # print a newline
        
        li      $v0,10              # set syscall to exit
        syscall                     # exit the program
