# Eduardo Bischoff Grasel - 22200355
.data
	msg1: .asciiz "Digite o valor de x: "
	msg2: .asciiz "Digite o valor de n: "
	zero: .double 0
	um_double: .double 1
	dois_double: .double 2
	estimativa_double: .double 1

.text
	# double 0
	la $t0, zero
	ldc1  $f6, 0($t0)
	
	#  contador
	li $t1, 1
	
	# estimativa double, um double, dois_double
	la $t0, estimativa_double
	ldc1 $f8, 0($t0)
	la $t0, um_double
	ldc1 $f4, 0($t0)
	la $t0, dois_double
	ldc1, $f14, 0($t0)
	
	# imprimir a mensagem 1 e pedir o valor de x
	la $a0 msg1
	li $v0, 4
	syscall
	li $v0, 7
	syscall
	add.d $f2, $f0, $f6
	
	# imprimir a mensagem 2 e pedir o valor de n
	la $a0 msg2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	add $t0, $t0, 1
	loop:
		bge $t1, $t0, fim_loop
		div.d $f10, $f2, $f8   # divide x pela estimativa_double e coloca em $f10
		add.d $f12, $f10, $f8  # soma x com o resultado anterior
		div.d $f16, $f12, $f14  # divide o resultado anterior por 2 e guarda em $f16
		addi $t1, $t1, 1  # incrementa o contador
		add.d $f8, $f6, $f16 # incrementa a estimativa
		j loop
fim_loop:
	li $v0, 3
	add.d $f12, $f6, $f16 # move para $f12 para ser mostrado na tela
	syscall
	
	
