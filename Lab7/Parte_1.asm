.data
	A:      .space 1024        # espaço reservado para a matriz A (exemplo: 16x16x4 inteiros)
	m:      .word 16          # número de linhas
	n:      .word 16          # número de colunas

.text
    	la      $t0, A        # carregar o endereço base da matriz A em $t0
    	lw      $t1, m        # carregar o número de linhas em $t1
    	lw      $t2, n        # carregar o número de colunas em $t2

    	li      $t3, 0        # inicializar i = 0
    	li      $t8, 0        # inicializar contador = 0

outer_loop:
    	bge     $t3, $t1, end_outer_loop   # se i >= m (linhas), sair do loop externo

    	li      $t4, 0        # inicializar j = 0

inner_loop:
    	bge     $t4, $t2, end_inner_loop   # se j >= n, sair do loop interno

    	mul     $t5, $t3, $t2             # t5 = i * n
    	add     $t5, $t5, $t4             # t5 = i * n + j
    	sll     $t5, $t5, 2               # t5 = (i * n + j) * 4 (multiplicar por 4, tamanho de palavra)
    	add     $t6, $t0, $t5             # t6 = endereço de A[i][j]

    	sw      $t8, 0($t6)               # armazenar contador em A[i][j]
	addi    $t8, $t8, 1               # contador++

    	addi    $t4, $t4, 1               # j++

    	j       inner_loop                # repetir o loop interno

end_inner_loop:
    	addi    $t3, $t3, 1               # i++
    	j       outer_loop                # repetir o loop externo

end_outer_loop:
    	# fim do programa
    	li      $v0, 10                   # código para sair do programa
    	syscall
