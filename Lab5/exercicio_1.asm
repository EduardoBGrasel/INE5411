.data
	msg: .asciiz "Digite um número: "
	# branch history table
	branch_history: .space 1

.text
	# mostrar a mensagem
	li $v0, 4
	la $a0, msg
	syscall
	
	# ler o número
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 1  # aux
	li $s0, 1  # resultado
	
	loop:  #fatorial
   		# verifica branch history table
    		lb $t2, branch_history($zero)  # carrega a predição
    		beq $t2, 1, branch_taken     # Se o desvio for pego, vai para branch taken
    		
   
    		# Branch not taken
    		mul $s0, $s0, $t1  
    		addi $t1, $t1, 1
    		li $t2, 0
    		j branch_continue
    
branch_taken:
    	mul $s0, $t1, $s0  
    	addi $t1, $t1, 1
    	li $t2, 1
   
 branch_continue:
    	# atualizar branch history table
    	sb $t2, branch_history($zero)  # guarda a saida atual (taken ou not taken)
    
	bgt $t1, $t0, fim
    
	j loop

fim: 
	li $v0, 1
	move $a0, $s0
	syscall
	
