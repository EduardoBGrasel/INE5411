.data #  declarando as vari�veis
	a: .word 0
	b: .word 5
	c: .word 0
	d: .word 10
	e: .word 15
.text #  iniciando a l�gica do programa
	
	#  carregando as variaveis nos registradores
	la $t1, a #  o reg $t1 recebe o endere�o de a
	lw $s0, 0($t1) #  carrega o valor contido no endere�o $t0 e guarda em $s0
	
	la $t0, b #  o reg $t0 recebe o endere�o de b
	lw $s1, 0($t0) #  carrega o valor contido no endere�o $t0 e guarda em $s1
	
	la $t2, c #  o reg $t2 recebe o endere�o de c
	lw $s2, 0($t2) #  carrega o valor contido no endere�o $t0 e guarda em $s2
	
	la $t0, d #  o reg $t0 recebe o endere�o de d
	lw $s3, 0($t0) #  carrega o valor contido no endere�o $t0 e guarda em $s3
	
	la $t0, e #  o reg $t0 recebe o endere�o de e
	lw $s4, 0($t0) #  carrega o valor contido no endere�o $t0 e guarda em $s4
	
	#  iniciando os c�lculos
	addi $s0, $s1, 35 #  $s0(a) recebe $s1(b) + 35 com a opera��o addi
	sw $s0, 0($t1) #  guarda o valor de 'a' presente no registrador $s0 no local da variavel 'a' da mem�ria
	sub $t3, $s3, $s0 #  temp 3 recebe d - a
	add $s2, $t3, $s4 #  $s2(c) recebe $t3 + $s4 (resultado da opera��o d-a) + (e)
	sw $s2, 0($t2) #  guarda o valor de 'c' presente no registrador $s2 no local da variavel 'c' da mem�ria