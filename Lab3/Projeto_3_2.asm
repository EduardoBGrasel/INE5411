# Eduardo Bischoff Grasel
.data
array:      .word   11, 2, 3, 14, 15 # array
N:          .word   4 #  tamanho do array (n-1)

.text
main:
    # Configurar registradores
    la $a0, array       # Carregar endereço base do array em $a0
    lw $a1, N           # Carregar N em $a1

    # Chamada da função soma_array
    jal soma_array

    # Imprimir o resultado
    move $a0, $v0       # Mover resultado para $a0 para impressão
    li $v0, 1           # Código do sistema para imprimir inteiro
    syscall

    # Sair do programa
    li $v0, 10          # Código do sistema para sair
    syscall

soma_array:
    # Configurar a pilha
    addi $sp, $sp, -4  # Alocar espaço para o retorno
    sw $ra, 0($sp)      # Salvar o endereço de retorno

    # Carregar n em $t1
    add $t1, $a1, $zero     # Carregar n em $t1

    # Condição de parada da recursão (n == 0)
    beqz $t1, base_case # Se n == 0, vá para base_case

    # Recursão
    addi $a1, $a1, -1   # Decrementar n
    jal soma_array      # Chamada recursiva
    lw $t2, 0($a0)    # Carregar array[0] em $t2
    addi $a0, $a0, 4   # Avançar para o próximo elemento do array
    add $v0, $t2, $v0   # Adicionar array[0] ao resultado da chamada recursiva

    # Limpar a pilha e retornar
    lw $ra, 0($sp)      # Restaurar endereço de retorno
    addi $sp, $sp, 4   # Desalocar espaço para o retorno
    jr $ra              # Retornar

base_case:
    # Caso base: retorna 0
    li $v0, 0           # Carrega 0 no resultado
    jr $ra              # Retorna
