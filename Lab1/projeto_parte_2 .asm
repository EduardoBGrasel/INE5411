.data #  declarando as vari�veis
	a: .word 0
	b_msg: .asciiz "Digite o valor de b: "
	c: .word 0
	d: .word 10
	e: .word 15
	final_msg: .asciiz "O resultado final � c = "
.text #  iniciando a l�gica do programa
	
	# input do usuario
	la $t4, b_msg #  guardar em $t4 o endere�o de b_msg
	la $v0, 4 #  instru��o para printar na tela
	move $a0, $t4 #  movendo a string para o registrador alvo da instru��o
	syscall #  executando a syscall para a chamada do sistema
	la $v0, 5 #  instru��o para ler inteiros
	syscall #  executando a syscall para chamada do sistema
	move $s1, $v0 #  move o conteudo de $v0 para $s1 
		
	#  carregando as variaveis nos registradores
	la $t1, a #  o reg $t1 recebe o endere�o de a
	lw $s0, 0($t1) #  carrega o valor contido no endere�o $t0 e guarda em $s0
	
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
	
	#  mostrando o resultado final
	la $t2, final_msg #  colocando no $t2 o endere�o da final_msg
	la $v0, 4 #  instru��o para imprimir string
	move $a0, $t2 #  movendo o $t2 para o registrador alvo
	syscall #  fazendo a chamada do sistema
	la $v0, 1 #  instru��o para imprimir inteiro
	move $a0, $s2 #  move o resultado da opera��o para o registrador alvo da opera��o
	syscall