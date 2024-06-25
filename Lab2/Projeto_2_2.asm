# Eduardo Bischoff Grasel
# João Vittor Braz de Oliveira
.text
	loop:  # inicio do loop
	# ler os valores da primeira linha
	li	$t1, 1 #  valor referente a linha 1
	sb	$t1, 0xFFFF0012 #  carregando o valor nos bytes do endereço
	lb	$t2, 0XFFFF0014 #  carregando os bytes de 0XFFFF0014
	
	li	$t3, 17
	beq	$t3, $t2, zero # se os valores forem iguais, mostra 0
	
	li	$t3, 33
	beq	$t3, $t2, one
	
	li	$t3, 65
	beq	$t3, $t2, two
	
	li	$t3, -127
	beq	$t3, $t2, three
	
	# ler os valores da segunda linha
	li	$t1, 2
	sb	$t1, 0xFFFF0012
	lb	$t2, 0XFFFF0014
	
	li	$t3, 18
	beq	$t3, $t2, four
	
	li	$t3, 34
	beq	$t3, $t2, five
	
	li	$t3, 66
	beq	$t3, $t2, six
	
	li	$t3, -126
	beq	$t3, $t2, seven
	
	# ler os valores da terceira linha
	li	$t1, 4
	sb	$t1, 0xFFFF0012
	lb	$t2, 0XFFFF0014
	
	li	$t3, 20
	beq	$t3, $t2, eight
	
	li	$t3, 36
	beq	$t3, $t2, nine
	
	li	$t3, 68
	beq	$t3, $t2, A
	
	li	$t3, -124
	beq	$t3, $t2, B
	
	# ler os valores da quarta linha
	li	$t1, 8
	sb	$t1, 0xFFFF0012
	lb	$t2, 0XFFFF0014
	
	li	$t3, 24
	beq	$t3, $t2, C
	
	li	$t3, 40
	beq	$t3, $t2, D
	
	li	$t3, 72
	beq	$t3, $t2, E
	
	li	$t3, -120
	beq	$t3, $t2, F
	
	# inicio da logica para acender os leds no display
	zero:
	li	$t0, 63 #  carregamento dos valores do display
	sb	$t0, 0xFFFF0010 #  store bytes do valor do display
	j	loop #  volta para o loop
	
	one:
	li	$t0, 6
	sb	$t0, 0xFFFF0010
	j	loop
	
	two:
	li	$t0, 91
	sb	$t0, 0xFFFF0010
	j	loop
	
	three:
	li	$t0, 79
	sb	$t0, 0xFFFF0010
	j	loop

	four:
	li	$t0, 102
	sb	$t0, 0xFFFF0010
	j	loop

	five:
	li	$t0, 109
	sb	$t0, 0xFFFF0010
	j	loop
	
	six:
	li	$t0, 125
	sb	$t0, 0xFFFF0010
	j	loop
	
	seven:
	li	$t0, 7
	sb	$t0, 0xFFFF0010
	j	loop
	
	eight:
	li	$t0, 127
	sb	$t0, 0xFFFF0010
	j	loop
	
	nine:
	li	$t0, 111
	sb	$t0, 0xFFFF0010
	j	loop
	
	A:
	li	$t0, 119
	sb	$t0, 0xFFFF0010
	j	loop
	
	B:
	li	$t0, 124
	sb	$t0, 0xFFFF0010
	j	loop
	
	C:
	li	$t0, 57
	sb	$t0, 0xFFFF0010
	j	loop
	
	D:
	li	$t0, 94
	sb	$t0, 0xFFFF0010
	j	loop
	
	E:
	li	$t0, 121
	sb	$t0, 0xFFFF0010
	j	loop
	
	F:
	li	$t0, 113
	sb	$t0, 0xFFFF0010
	j	loop
