.data
    A:          .space 1024        # espaço reservado para a matriz A (exemplo: 16x16x4 inteiros)
    B:          .space 1024        # espaço reservado para a matriz B (transposta)
    m:          .word 16           # número de linhas
    n:          .word 16           # número de colunas
    block_size: .word 16            # tamanho do bloco

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

    	# Calcular soma das matrizes A e B utilizando o padrão de bloco
    	li      $t5, 0                 # inicializar i = 0

outer_block_loop:
    	bge     $t5, $t2, end_outer_block_loop   # se i >= m (linhas), sair do loop externo

    	li      $t7, 0                 # inicializar j = 0

inner_block_loop:
    	bge     $t7, $t3, end_inner_block_loop   # se j >= n, sair do loop interno

    	li      $t8, 0                 # inicializar ii = i
    	add     $t8, $t8, $t5          # t8 = i

ii_loop:
    	bge     $t8, $t2, end_ii_loop            # se ii >= m, sair do loop

    	li      $t9, 0                 # inicializar jj = j
    	add     $t9, $t9, $t7          # t9 = j

jj_loop:
    	bge     $t9, $t3, end_jj_loop            # se jj >= n, sair do loop

    	mul     $s0, $t8, $t3         # s0 = ii * n
    	add     $s0, $s0, $t9        # s0 = ii * n + jj
    	sll     $s0, $s0, 2          # s0 = (ii * n + jj) * 4
    	add     $s1, $t0, $s0        # s1 = endereço de A[ii][jj]

    	mul     $s2, $t9, $t2         # s2 = jj * m
    	add     $s2, $s2, $t8        # s2 = jj * m + ii
    	sll     $s2, $s2, 2          # s2 = (jj * m + ii) * 4
    	add     $s3, $t1, $s2        # s3 = endereço de B[jj][ii]

    	lw      $s4, 0($s1)          # carregar A[ii][jj]
    	lw      $s5, 0($s3)          # carregar B[jj][ii]
    	add     $s4, $s4, $s5       # A[ii][jj] = A[ii][jj] + B[jj][ii]
    	sw      $s4, 0($s1)          # armazenar resultado em A[ii][jj]

    	addi    $t9, $t9, 1            # jj++
    	j       jj_loop

end_jj_loop:
    	add    $t8, $t8, 1            # ii++
    	j       ii_loop

end_ii_loop:
    	add    $t7, $t7, $t4          # j += block_size
    	j       inner_block_loop

end_inner_block_loop:
    	add    $t5, $t5, $t4          # i += block_size
    	j       outer_block_loop

end_outer_block_loop:

    	# Fim do programa
    	li      $v0, 10                # código para sair do programa
    	syscall
