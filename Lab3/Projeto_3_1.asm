# Eduardo Bischoff Grasel
.data
    a: .word 0
    b: .word 0
    result: .word 0

.text
main:
    # Leitura dos números a e b
    li $v0, 5
    syscall
    move $t0, $v0 # Salva a em $t0
    
    li $v0, 5
    syscall
    move $t1, $v0 # Salva b em $t1

    # Chama a função de multiplicaçãoo recursiva
    move $a0, $t0 # Passa a para $a0
    move $a1, $t1 # Passa b para $a1
    jal mult_recursive  
	
    # Salva o resultado em result
    move $s0, $v0

    # Imprime o resultado
    li $v0, 1
    move $a0, $s0
    syscall

    # Fim do programa
    li $v0, 10
    syscall


# Função de multiplicação recursiva
mult_recursive:

    # Preserva o endereço de retorno e os registradores $a0 e $a1 na pilha
    addi $sp, $sp, -12
    sw $ra, 0($sp) #  retorno
    sw $a0, 4($sp) #  a
    sw $a1, 8($sp) #  b


    # Caso base: se b for 1, retorne a
    beq $a1, 1, end_mult_recursive_a
    # Caso base: se b for 0, retorne 0
    beq $a1, $zero, end_mult_recursive_0
    # Caso base: se a for 0, retorne 0
    beq $a0, $zero, end_mult_recursive_0
    # Caso base: se a for 1, retorne b
    beq $a0, 1, end_mult_recursive_b

    # Decrementa b
    addi $a1, $a1, -1
    # Chama recursivamente a função, passando a e b-1
    jal mult_recursive
    # Salva o resultado temporário
    move $t1, $v0
    # Adiciona a a $t1 (resultado temporário)
    add $v0, $a0, $t1

    # Restaura o endereço de retorno e os registradores $a0 e $a1
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12
    # Retorna
    jr $ra
end_mult_recursive_a:
    # Restaura o endereço de retorno e o registrador $a0
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    move $v0, $a0
    addi $sp, $sp, 12
    # Retorna
    jr $ra
    
end_mult_recursive_b:
    # Restaura o endereço de retorno e o registrador $a1
    lw $ra, 0($sp)
    lw $a1, 8($sp)
    move $v0, $a1
    addi $sp, $sp, 12
    # Retorna
    jr $ra
    
end_mult_recursive_0:
    move $v0, $zero
    addi $sp, $sp, 12
    # Retorna
    jr $ra

