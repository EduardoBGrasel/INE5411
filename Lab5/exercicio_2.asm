.data
	msg: .asciiz "Digite um valor: "
	msg_final: .asciiz "O resultado do fatorial é: "

	# Branch History Table com 2 bits para prever o salto em fatorial
	bht: .space 1

.text
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal fatorial
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg_final
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall

fatorial:
	sub $sp, $sp, 8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	# Lógica de previsão de saltos
	lb $t1, bht # Carrega o valor do histórico de saltos
	lb $t2, bht # Carrega novamente para verificar o segundo bit do histórico
	andi $t1, $t1, 0x02 # Isola o segundo bit do histórico
	
	# Decodificação dos estados da BHT
	li $t3, 1 # Estado 1: 01 - Prever sem salto
	li $t4, 2 # Estado 2: 10 - Prever salto
	li $t5, 3 # Estado 3: 11 - Prever salto
	beq $t1, $zero, skip_predict # Estado 0: 00 - Prever sem salto

	beq $t2, $zero, no_jump_predict # Se o segundo bit for 0, prever sem salto
	jump_predict:
	b Li
	
	no_jump_predict:
		li $v0, 1
		add $sp, $sp, 8
		jr $ra
	
	skip_predict:
	
	slti $t0, $a0, 1
	beq $t0, $zero, Li
	
	li $v0, 1
	add $sp, $sp, 8
	jr $ra
	
Li:
	subi $a0, $a0, 1
	jal fatorial
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	add $sp, $sp, 8
	mul $v0, $a0, $v0
	
	# Atualização do histórico de saltos
	slt $t0, $zero, $v0 # Verifica se o resultado é zero ou não
	beq $t0, $zero, update_bht_jump # Se não for zero, atualiza para prever salto
	li $t6, 1 # Se for zero, atualiza para prever sem salto
	sb $t6, bht # Atualiza o bit de previsão com o resultado atual da condição
	jr $ra
	
	update_bht_jump:
		andi $t1, $t1, 0x01 # Isola o primeiro bit do histórico
		sll $t1, $t1, 1 # Desloca o primeiro bit para a esquerda para fazer espaço para o segundo bit
		ori $t1, $t1, 0x01 # Define o primeiro bit como 1
		sb $t1, bht # Atualiza o histórico de saltos para prever salto
		jr $ra
