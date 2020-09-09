.data
prompt:       .asciiz "MULTIPLOS DE 3 --> INGRESE 3\nMULTIPLOS DE 5 --> INGRESE 5\nMULTIPLOS DE AMBOS --> INGRESE 2\n\n" #prompt
newline:      .asciiz "\n\n"
space:        .asciiz " "
multiplos3:   .asciiz "MULTIPLOS DE 3 \n"
multiplos5:   .asciiz "MULTIPLOS DE 5 \n"

.text
.globl main
main:

# PROMPT: INGRESAR NUMERO

li    $v0, 4      # syscall print string code
la    $a0, prompt # load prompt
syscall           # print prompt
li    $v0, 5      # syscall read_int code
syscall           # read prompt
move  $t0, $v0    # move $v0 to $t0

li    $v0, 4       # syscall print string code
la    $a0, newline # load newline
syscall

# DECLARO CONSTANTES EN REGISTROS

li    $t1, 300    # $t1 = 300
li    $t2, 500    # $t2 = 500
li    $t3, 0      # counter = 0

# DECLARO CONDICIONALES SEGÚN NUMERO ELEGIDO

beq   $t0, 3, loop3    # if  prompt == 1 goto loop3
beq   $t0, 5, loop5    # if  prompt == 2 goto loop5
beq   $t0, 2, loopAmbos    # if  prompt == 3 goto multiplos de 3

# CICLO DE MULTIPLOS DE 3

loop3:
beq   $t3, 300, exit     # if counter == 300 goto exit
addi  $t3, $t3, 1        # $t3++
rem   $t4, $t3, 3        # t4 = t3 % 3
beq   $t4, $zero, print  # if (t4 == 0) goto print
j	  loop3				 # jump to loop3 

# CICLO DE MULTIPLOS DE 5

loop5:
beq   $t3, 500, exit     # if counter == 500 goto exit
addi  $t3, $t3, 1        # $t3++
rem   $t4, $t3, 5        # t4 = t3 % 5
beq   $t4, $zero, print  # if (t4 == 0) goto print
j	  loop5				 # jump to loop5 

# CICLO MULTIPLOS DE 3 Y 5

loopAmbos:
beq   $t3, 500, exit     # if counter == 500 goto exit
addi  $t3, $t3, 1        # $t3++
rem   $t4, $t3, 3        # t4 = counter % 3
beq   $t4, $zero, routes # if (t4 == 0) goto routes
j	  loopAmbos		     # jump to loopAmbos 

# RUTAS

routes:
rem   $t4, $t3, 5       # t4 = counter % 5
beq	  $t4, $zero, print	# if (t4 == 0) goto print
j	  loopAmbos			# jump to loopAmbos

# PRINT MULTIPLO

print:
li    $v0, 1           # syscall print int code
move  $a0, $t3         # move $t3 to $a0
syscall                # print int (resultado)
move  $t3, $a0         # move $a0 to $t3
li	  $v0, 4	   	   # syscall print string
la    $a0, space       # load space
syscall                # print space
beq   $t0, 3, loop3    # if  prompt == 1 goto multiplos de 3
beq   $t0, 5, loop5    # if  prompt == 2 goto multiplos de 5
j	  loopAmbos		   # jump to target

# FINALIZACION

exit:
li	  $v0, 4	   	   # syscall print string
la    $a0, newline     # load newline
syscall                # print newline
li    $v0, 10          # syscall halt code
syscall                # halt
