.data
    promptN: .asciiz "Digite N: "
    promptA: .asciiz "Elementos de A : "
    promptB: .asciiz "Elementos de B: "
    avgAmsg: .asciiz "Media de A: "
    avgBmsg: .asciiz "Media de B: "
    newline: .asciiz "\n"

    # Valor maximo da alocação:
    maxN: .word 1000

.text
    # Printando a mensagem para receber N
    li $v0, 4
    la $a0, promptN
    syscall

    # Lendo N
    li $v0, 5
    syscall
    move $t0, $v0     # N = $t0

    # Carregar MaxN
    la $t1, maxN
    lw $t1, 0($t1)

    # Verificando se N está dentro do esperado
    ble $t0, $t1, allocate_arrays
    li $t0, 1000     # caso N seja maior, alocamos o valor maximo

allocate_arrays:
    # Calcula o espa?o dos arrays (4 bytes float)
    sll $t1, $t0, 2   # t1 = N * 4

    # Aloca o espaço arrayA
    move $a0, $t1
    li $v0, 9         # alocar no heap
    syscall
    move $s0, $v0     # salva o endere?o de arrayA em $s0

    # Aloca o espaço arrayB
    move $a0, $t1
    li $v0, 9         
    syscall
    move $s1, $v0     # salva o endereço de arrayB em $s1

    # Ler os elementos do arrayA
    li $v0, 4
    la $a0, promptA
    syscall

    li $t2, 0         # index arrayA
read_arrayA_loop:
    bge $t2, $t0, read_arrayB  # if index >= N, vai para arrayB

    # Ler float
    li $v0, 6
    syscall
    sll $t3, $t2, 2   # offset = index * 4
    add $t4, $s0, $t3	# address = base + offset
    swc1 $f0, 0($t4)  # guarda float no arrayA

    addi $t2, $t2, 1
    j read_arrayA_loop

read_arrayB:
    li $v0, 4
    la $a0, promptB
    syscall

    li $t2, 0         # index arrayB
read_arrayB_loop:
    bge $t2, $t0, calculate_avgA  # if index >= N, go calculate avgA

    # ler float
    li $v0, 6
    syscall
    sll $t3, $t2, 2   # offset = index * 4
    add $t4, $s1, $t3	# address = base + offset
    swc1 $f0, 0($t4)  # guarda float no arrayB

    addi $t2, $t2, 1
    j read_arrayB_loop

calculate_avgA:
    move $a0, $s0    # endereço base do arrayA
    move $a1, $t0    # Tamanho do arrayA (N)
    jal calculate_avg

    # printa a mensagem de média
    li $v0, 4
    la $a0, avgAmsg
    syscall

    mov.s $f12, $f0
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

calculate_avgB:
    move $a0, $s1    # endereço base de arrayB
    move $a1, $t0    # tamamho do arrayB (N)
    jal calculate_avg

    # Printa a média do arrayB
    li $v0, 4
    la $a0, avgBmsg
    syscall

    mov.s $f12, $f0
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    # finaliza o programa
    li $v0, 10
    syscall

# Procedimento para o cálculo da m?dia
# parametros:
#   $a0 - endereço do array
#   $a1 - tamanho dp array
# Return:
#   $f0 - média do array
calculate_avg:
    li $t2, 0         # index
    li $t5, 0         # registrador temporario com 0
    mtc1 $t5, $f2     # sum do array agora é 0.0
    cvt.s.w $f2, $f2  # Converte 0 para float e quarda em $f2

calculate_avg_loop:
    bge $t2, $a1, finalize_avg  # if index >= N, finaliza

    sll $t3, $t2, 2   # offset = index * 4
    add $t4, $a0, $t3	# address = base + offset
    lwc1 $f4, 0($t4)  # carrega float do array
    add.s $f2, $f2, $f4 # sum += array[index]

    addi $t2, $t2, 1
    j calculate_avg_loop

finalize_avg:
    mtc1 $a1, $f6     # move n para $f6
    cvt.s.w $f6, $f6  # converte N para float
    div.s $f0, $f2, $f6  # media = sum / N
    jr $ra            # return
