# Eduardo Bischoff Grasel - 22200355
.data
	x: .word 1
	n: .word 0
	zero: .double 0
	um: .double 1
	
.text	

	li $s5, 3 # controle loop #### MUDE AQUI A QUANTIDADE DE LOOPS DESEJADOS #########

	la $t0, x
	lw $s3, 0($t0) # x

	la $t0, n
	lw $s0, 0($t0) # n

	li $s1, -1 # -1

	li $s2, 1 # 1
	mtc1.d $s2, $f4
	cvt.d.w $f4, $f4
	
	la $t0, zero
	ldc1 $f16, 0($t0) # zero para double
	la $t0, um
	ldc1 $f18, 0($t0) # um para double
	
	
	loop:
		bge $s0, $s5, fim_loop
		# caluclo potencia
		move $a0, $s1
		move $a1, $s0
		jal pow # calculando -1^n
		mtc1 $v0, $f8 # EM F8 TEM O VALOR DA POTENCIA
		cvt.d.w $f8, $f8
		# calculando fatorial
		li $t7, 2
		mul $t0, $s0, $t7
		addi $t1, $t0, 1
		move $a0, $t1
		jal fatorial
		mtc1.d $v0, $f10 # EM F10 TEM O RESULTADO DO FATORIAL
		cvt.d.w $f10, $f10
		# calculado a potencia restante
		li $t7, 2
		mul $t0, $s0, $t7
		addi $t1, $t0, 1
		move $a0, $s3
		move $a1, $s0
		jal pow
		mtc1 $v0, $f12 # EM F12 TEM O RESULTADO DA SEGUNDA POTENCIA
		cvt.d.w $f12, $f12
		
		# AGORA PEGAMOS A CONVERSÃO PARA DOUBLE DESSES VALORES E REALIZAMOS A CONTA FINAL
		div.d $f14, $f8, $f10
		mul.d $f16, $f14, $f12
		
		add.d $f20, $f16, $f20
		
		# controle do loop
		addi $s0, $s0, 1
		
		j loop
fim_loop:
	li $v0, 10
	syscall	
	
	
fatorial:
	# abre espaço no strack
	sub $sp, $sp, 8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	slti $t0, $a0, 1
	beq $t0, $zero, Li
	
	li $v0, 1
	add $sp, $sp, 8
	jr $ra
	
Li:
	subi $a0, $a0, 1
	jal fatorial
	# desempilha
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	add $sp, $sp, 8
	mul $v0, $a0, $v0
	jr $ra


pow:	
	# auxiliares
	li $t0, 1
	li $t1, 0
	loop1: #  calculo da potencia por meio de um loop
		bge $t1, $a1, fim_loop1
		addi $t1, $t1, 1
		subi $a1, $a1, 1
		mul $t0, $t0, $a0
		j loop1
	fim_loop1:
	move $v0, $t0
	jr $ra
	
	
