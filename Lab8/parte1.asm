.data
    A:      .space 1024        # espaço reservado para a matriz A (exemplo: 16x16x4 inteiros)
    B:      .space 1024        # espaço reservado para a matriz B (transposta)
    m:      .word 16           # número de linhas
    n:      .word 16           # número de colunas

.text
	# Inicializar a matriz A
    	la      $t0, A             # carregar o endereço base da matriz A em $t0
    	lw      $t1, m             # carregar o número de linhas em $t1
    	lw      $t2, n             # carregar o número de colunas em $t2

    	li      $t3, 0             # inicializar i = 0
    	li      $t4, 0             # inicializar contador = 0

outer_loop:
    	bge     $t3, $t1, end_outer_loop   # se i >= m (linhas), sair do loop externo

    	li      $t5, 0            # inicializar j = 0

inner_loop:
    	bge     $t5, $t2, end_inner_loop   # se j >= n, sair do loop interno

    	mul     $t6, $t3, $t2             # t6 = i * n
    	add     $t6, $t6, $t5             # t6 = i * n + j
    	sll     $t6, $t6, 2               # t6 = (i * n + j) * 4 (multiplicar por 4, tamanho de palavra)
    	add     $t7, $t0, $t6             # t7 = endereço de A[i][j]

    	sw      $t4, 0($t7)               # armazenar contador em A[i][j]
    	addi    $t4, $t4, 1               # contador++

    	addi    $t5, $t5, 1               # j++
    	j       inner_loop                # repetir o loop interno

end_inner_loop:
    	addi    $t3, $t3, 1               # i++
    	j       outer_loop                # repetir o loop externo

end_outer_loop:

    	# Calcular a transposta da matriz A e armazenar em B
	la      $t0, A             # carregar o endereço base da matriz A em $t0
    	la      $t1, B             # carregar o endereço base da matriz B em $t1
    	lw      $t2, m             # carregar o número de linhas em $t2 (reutilizar $t2 para linhas)
    	lw      $t3, n             # carregar o número de colunas em $t3 (reutilizar $t3 para colunas)

    	li      $t4, 0             # inicializar i = 0

transpose_outer_loop:
    	bge     $t4, $t2, end_transpose_outer_loop   # se i >= m, sair do loop externo

    	li      $t5, 0            # inicializar j = 0

transpose_inner_loop:
    	bge     $t5, $t3, end_transpose_inner_loop   # se j >= n, sair do loop interno

    	# Calcular endereço de A[i][j]
    	mul     $t6, $t4, $t3        # t6 = i * n
    	add     $t6, $t6, $t5        # t6 = i * n + j
    	sll     $t6, $t6, 2          # t6 = (i * n + j) * 4
    	add     $t7, $t0, $t6        # t7 = endereço de A[i][j]

    	# Calcular endereço de B[j][i]
    	mul     $t8, $t5, $t2        # t8 = j * m
    	add     $t8, $t8, $t4        # t8 = j * m + i
    	sll     $t8, $t8, 2          # t8 = (j * m + i) * 4
    	add     $t9, $t1, $t8        # t9 = endereço de B[j][i]

    	lw      $t6, 0($t7)          # carregar A[i][j]
    	sw      $t6, 0($t9)          # armazenar A[i][j] em B[j][i]

    	addi    $t5, $t5, 1          # j++
    	j       transpose_inner_loop

end_transpose_inner_loop:
    	addi    $t4, $t4, 1          # i++
    	j       transpose_outer_loop

end_transpose_outer_loop:

    	# Somar as matrizes A e B e armazenar o resultado em A
    	la      $t0, A             # carregar o endereço base da matriz A em $t0
    	la      $t1, B             # carregar o endereço base da matriz B em $t1
    	lw      $t2, m             # carregar o número de linhas em $t2
    	lw      $t3, n             # carregar o número de colunas em $t3

    	li      $t4, 0             # inicializar i = 0

sum_outer_loop:
    	bge     $t4, $t2, end_sum_outer_loop   # se i >= m, sair do loop externo

    	li      $t5, 0            # inicializar j = 0

sum_inner_loop:
    	bge     $t5, $t3, end_sum_inner_loop   # se j >= n, sair do loop interno

    	# Calcular endereço de A[i][j]
    	mul     $t6, $t4, $t3        # t6 = i * n
    	add     $t6, $t6, $t5        # t6 = i * n + j
    	sll     $t6, $t6, 2          # t6 = (i * n + j) * 4
    	add     $t7, $t0, $t6        # t7 = endereço de A[i][j]

    	# Calcular endereço de B[i][j]
    	add     $t8, $t1, $t6        # t8 = endereço de B[i][j] (mesmo offset de A[i][j])

    	lw      $t9, 0($t7)          # carregar A[i][j]
    	lw      $t6, 0($t8)          # carregar B[i][j]
    	add     $t9, $t9, $t6        # A[i][j] = A[i][j] + B[i][j]
    	sw      $t9, 0($t7)          # armazenar resultado em A[i][j]

    	addi    $t5, $t5, 1          # j++
    	j       sum_inner_loop

end_sum_inner_loop:
    	addi    $t4, $t4, 1          # i++
    	j       sum_outer_loop

end_sum_outer_loop:

    	# Fim do programa
    	li      $v0, 10              # código para sair do programa
    	syscall
