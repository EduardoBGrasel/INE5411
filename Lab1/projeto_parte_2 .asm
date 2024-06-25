.data #  declarando as variáveis
	a: .word 0
	b_msg: .asciiz "Digite o valor de b: "
	c: .word 0
	d: .word 10
	e: .word 15
	final_msg: .asciiz "O resultado final é c = "
.text #  iniciando a lógica do programa
	
	# input do usuario
	la $t4, b_msg #  guardar em $t4 o endereço de b_msg
	la $v0, 4 #  instrução para printar na tela
	move $a0, $t4 #  movendo a string para o registrador alvo da instrução
	syscall #  executando a syscall para a chamada do sistema
	la $v0, 5 #  instrução para ler inteiros
	syscall #  executando a syscall para chamada do sistema
	move $s1, $v0 #  move o conteudo de $v0 para $s1 
		
	#  carregando as variaveis nos registradores
	la $t1, a #  o reg $t1 recebe o endereço de a
	lw $s0, 0($t1) #  carrega o valor contido no endereço $t0 e guarda em $s0
	
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
	
	#  mostrando o resultado final
	la $t2, final_msg #  colocando no $t2 o endereço da final_msg
	la $v0, 4 #  instrução para imprimir string
	move $a0, $t2 #  movendo o $t2 para o registrador alvo
	syscall #  fazendo a chamada do sistema
	la $v0, 1 #  instrução para imprimir inteiro
	move $a0, $s2 #  move o resultado da operação para o registrador alvo da operação
	syscall