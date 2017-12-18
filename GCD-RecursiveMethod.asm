# ############################################################### #
# Recursion.ASM                                                   #
# Author: Ziye Xu                                                 #
# Date: 10/17/17                                                  #
# ############################################################### #   

.data

STR_FIRSTNUM:	.asciiz "Enter the first number (1-9999): "
STR_SECDNUM:	.asciiz "Enter the second number (1-9999): "
STR_ERR:		.asciiz "Invalid input \n"
STR_RECURE:		.asciiz "\n Recursive Round: "
STR_GCD: 		.asciiz "\n \n GCD: "

.text
.globl main


main: 
              li $t1, 1
              li $t2, 9999
              li $t3, 0				        #RECURSION ROUND COUNTER
              li $s5, 0				        #gcd

# VALIDATE the input speed
valid1:       li $v0, 4               # system call #4 (print message)
              la $a0, STR_FIRSTNUM    # load the memory sddress of the
                                      # first character in the message
              syscall                 # Do it!

              li $v0, 5               # system call #5 (user input)
              syscall                 # Do it!

              blt $v0,$t1,error1      #  branch to target if  input < 1
              bgt $v0,$t2,error1      #  branch to target if  input > 9999

              move $s1,$v0         

valid2: 
              li $v0, 4               # system call #4 (print message)
              la $a0, STR_SECDNUM     # load the memory sddress of the
                                      # first character in the message
              syscall                 # Do it!

              li $v0, 5               # system call #5 (user input)
              syscall                 # Do it!


              blt $v0,$t1,error2      #  branch to target if  input < 1
              bgt $v0,$t2,error2      #  branch to target if  input >9999

              move $s2,$v0         


              blt $s1,$s2,fix      	  #  branch to target if  input1 < input2

execute:      move $a1,$s1
              move $a2,$s2

    		      jal GCD

              add $s5,$zero,$a1

    		      li $v0, 4               # system call #4 (print message)
              la $a0, STR_GCD    
              syscall                 # Do it!

              li $v0, 1               # system call #1 (print int)
              move $a0, $s5        	
              syscall                 # Do it!


              li $v0, 10              # load code for terminating program
              syscall                 # terminate program
    

              jr $31



######################## THE END OF MAIN #############################################

######################## THE BEGINNING OF THE REDURSIVE GCD MODULE ######################
GCD:	 

                subu $sp, $sp, 4

                sw  $ra, 0($sp)         # save $ra register

                li $v0, 4               # system call #4 (print message)
                la $a0, STR_RECURE    
                syscall                 # Do it!

			          addi $t3, $t3, 1

                li $v0, 1               # system call #1 (print int)
                move $a0, $t3        	

                syscall                 # Do it!

                ########## TERMINTAING CONDITION HERE #####################
                beq $a2, $zero, SKIP_RECUSION    # check if y == 0

                div $a1, $a2            # x/y

                mfhi  $a3               # x%y

                move $a1,$a2            # x = y
                move $a2,$a3            # y = x%y

                jal GCD                 # Recursive call
	    

SKIP_RECUSION:
              	# restore $ra for the caller
            		lw	$ra, 0($sp)

              	# restore the caller's stack pointer
              	addu	$sp, $sp, 4

              	jr $ra

##################### THE END OF THE RECURSIVE MODULE GCD ################################

error1:    li $v0, 4                    # system call #4 (print message)
           la $a0, STR_ERR    
           syscall                      # Do it!

           j valid1

error2:    li $v0, 4                    # system call #4 (print message)
           la $a0, STR_ERR    
           syscall                      # Do it!

           j valid2          

# swap position 
fix:	     xor $t5, $t5, $t6
  		     xor $t6, $t5, $t6
  		     xor $t5, $t5, $t6  

  		     j execute   



######################################################## END.
