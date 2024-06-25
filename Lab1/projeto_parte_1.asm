.data #  declarando as variáveis
	a: .word 0
	b: .word 5
	c: .word 0
	d: .word 10
	e: .word 15
.text #  iniciando a lógica do programa
	
	#  carregando as variaveis nos registradores
	la $t1, a #  o reg $t1 recebe o endereço de a
	lw $s0, 0($t1) #  carrega o valor contido no endereço $t0 e guarda em $s0
	
	la $t0, b #  o reg $t0 recebe o endereço de b
	lw $s1, 0($t0) #  carrega o valor contido no endereço $t0 e guarda em $s1
	
	la $t2, c #  o reg $t2 recebe o endereço de c
	lw $s2, 0($t2) #  carrega o valor contido no endereço $t0 e guarda em $s2
	
	la $t0, d #  o reg $t0 recebe o endereço de d
	lw $s3, 0($t0) #  carrega o valor contido no endereço $t0 e guarda em $s3
	
	la $t0, e #  o reg $t0 recebe o endereço de e
	lw $s4, 0($t0) #  carrega o valor contido no endereço $t0 e guarda em $s4
	
	#  iniciando os cálculos
	addi $s0, $s1, 35 #  $s0(a) recebe $s1(b) + 35 com a operação addi
	sw $s0, 0($t1) #  guarda o valor de 'a' presente no registrador $s0 no local da variavel 'a' da memória
	sub $t3, $s3, $s0 #  temp 3 recebe d - a
	add $s2, $t3, $s4 #  $s2(c) recebe $t3 + $s4 (resultado da operação d-a) + (e)
	sw $s2, 0($t2) #  guarda o valor de 'c' presente no registrador $s2 no local da variavel 'c' da memória