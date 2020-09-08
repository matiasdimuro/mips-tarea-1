.data
prompt:       .asciiz "MULTIPLOS DE 3 --> INGRESE 1\nMULTIPLOS DE 5 --> INGRESE 2\nMULTIPLOS DE AMBOS --> INGRESE 3\n\n" #prompt
newline:      .asciiz "\n"
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
li    $t3, 1      # counter = 1

# DECLARO CONDICIONALES

beq   $t0, 1, mult3    # if  prompt == 1 goto multiplos de 3
beq   $t0, 2, mult5    # if  prompt == 2 goto multiplos de 5
beq   $t0, 3, mult3    # if  prompt == 3 goto multiplos de 3


# CICLO DE MULTIPLOS DE 3

mult3:
li    $t4, 3              # $t4 = 3 (constante)
beq   $t6, $t1, menu      # if  $t6(resultado) == $t1(300) goto menu
mul   $t6, $t4, $t3   # $t4(3) * $t3(counter) = $t6
li    $v0, 1          # syscall print int code
move  $a0, $t6        # move $t6 to $a0
syscall               # print int (resultado)
move  $t6, $a0        # move $a0 to $t6
addi  $t3, $t3, 1     # $t3++
li    $v0, 4       # syscall print string code
la    $a0, space   # load space
syscall
j    mult3         # jump to mult3

# CICLO DE MULTIPLOS DE 5

mult5:
li    $t4, 5          # $t4 = 5 (constante)
beq   $t6, $t2, menu  # if  $t6(resultado) == $t2(500) goto exit
mul   $t6, $t4, $t3   # $t4(5) * $t3(counter) = $t6
li    $v0, 1          # syscall print int code
move  $a0, $t6        # move $t6 to $a0
syscall               # print int (resultado)
move  $t6, $a0        # move $a0 to $t6
addi  $t3, $t3, 1     # $t3++
li    $v0, 4       # syscall print string code
la    $a0, space   # load space
syscall
addi  $t7, $t7, 1      #  $t7++
j     mult5         # jump to mult5

# MAIN

menu:
beq   $t0, 1, exit    # if  prompt == 1 goto multiplos de 3
beq   $t0, 2, exit    # if  prompt == 2 goto multiplos de 5
beq   $t0, 3, mult5    # if  prompt == 3 goto multiplos  5

# FINALIZACION

exit:
beq    $t7, 1, mult5
li    $v0, 10             # syscall halt code
syscall                   # halt
