.data
new_line:   .asciiz " "             # spacing between numbers

.text
.globl main
main:
li          $t5, 18              # counter => 18 (20-2)

li          $v0, 1               # print_int syscall code
li          $t0, 0               # load 0                                          
move        $a0, $t0             # move $t0 to $a0                             
syscall                                     

li          $v0, 4               # print_string syscall code                 
la          $a0, new_line        # load word new_line                        
syscall                          # print " "        

li          $v0, 1              # print_int syscall code
li          $t1, 1              # load 1
move        $a0, $t1            # move $t1 to $a0
syscall                         # print_int       

li          $v0, 4              # print_string syscall code
la          $a0, new_line       # load word new_line
syscall                         # print " "

loop:

beq		    $t5, $zero, exit	# if $t5 == 0 ==> exit

li          $v0, 1              # print_int syscall code
add	        $t0, $t0, $t1       # add => $t0 = $t0 + $t1
move        $a0, $t0            # move $t0 to $a0
syscall

addi	    $t5, $t5, -1	    # $t5--

li          $v0, 4              # print_string syscall code
la          $a0, new_line       # load word new_line
syscall                         # print " "

li          $v0, 1              # print_int syscall code
add	        $t1, $t0, $t1       # add => $t0 = $t0 + $t1
move        $a0, $t1            # move $t0 to $a0
syscall

li          $v0, 4              # print_string syscall code
la          $a0, new_line       # load word new_line
syscall                         # print " "

addi	    $t5, $t5, -1	    # $t5--
j		    loop	            # jump to loop:

exit:
li          $v0, 10
syscall