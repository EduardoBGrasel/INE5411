# Eduardo Bischoff Grasel
# João Vittor Braz de Oliveira
.text
	# 1
	li $t0, 0xFFFF0010 #  colocando em $t0 o endereço da memória para o display
	li $s0, 0x06 #  para ligar o número 1, precisamos de 0000110, transformando em hex = 0x06
	sb $s0, 0($t0) #  ativando os leds para mostrar o 1

	# 2
	li $s0, 0x5b #  para ligar o número 1, precisamos de 01011011, transformando em hex = 0x5b
	sb $s0, 0($t0) #  ativando os leds para mostrar o 2

	# 3
	li $s0, 0x4f #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 3

	# 4
	li $s0, 0x66 #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 4

	# 5
	li $s0, 0x6d #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 5

	# 6
	li $s0, 0x7c #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 6

	# 7
	li $s0, 0x07 #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 7

	# 8
	li $s0, 0x7f #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 8

	# 9
	li $s0, 0x6f #  ...
	sb $s0, 0($t0) #  ativando os leds para mostrar o 9
