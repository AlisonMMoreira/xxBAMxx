.data
input_buffer: .space 4
msg_esc: .asciiz "|A - Adição| S - Subtração | D - Divisão | M - Multiplicação | P - Potenciação |"
msg: .asciiz "\nEscolha a operação: "
n1: .asciiz "\nDigite um número: "
n2: .asciiz "Digite outro número: "
result: .asciiz "O resultado é: "
msg_erro: .asciiz "Erro! "

.text
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, msg_esc
    syscall
       
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, msg
    syscall

    # Lê o valor digitado pelo usuário
    li $v0, 12
    syscall
    move $t0, $v0  # Move o valor lido para o registrador $t1

	## Executa a operação escolhida
	beq $t0, 65, case1
	beq $t0, 83, case2
	beq $t0, 68, case3
	beq $t0, 77, case4
	beq $t0, 80, case5
	j msg_erro

case1:			# Adição
#    addi $t0, $zero, 1 -- Da pra economizar mais linhas ainda
#    bne $s0, $t0, case2 -- Da pra economizar mais linhas ainda
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n1
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t2, $v0  # Move o valor lido para o registrador $t2
    #Repetindo
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n2
    syscall

    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t3, $v0  # Move o valor lido para o registrador $t3
    
    add $t1, $t2, $t3                        # função de soma
    j fim

case2:			# Subtração
    #addi $t0, $zero, 2 -- Da pra economizar mais linhas ainda
    #bne $s0, $t0, case3 -- Da pra economizar mais linhas ainda
    
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n1
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t2, $v0  # Move o valor lido para o registrador $t2
    #Repetindo
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n2
    syscall

    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t3, $v0  # Move o valor lido para o registrador $t3
    
    sub $t1, $t2, $t3                        # função de subtração
    j fim

case3:			# Multiplicação
    #addi $t0, $zero, 3 -- Da pra economizar mais linhas ainda
    bne $s0, $t0, case4 -- Da pra economizar mais linhas ainda
    
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n1
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t2, $v0  # Move o valor lido para o registrador $t2
    #Repetindo
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n2
    syscall

    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t3, $v0  # Move o valor lido para o registrador $t3
    
    mul $t1, $t2, $t3                        # função de multiplicação
    j fim
    
case4:			# Divisão
    #addi $t0, $zero, 4 -- Da pra economizar mais linhas ainda
    bne $s0, $t0, case5 -- Da pra economizar mais linhas ainda
    
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n1
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t2, $v0  # Move o valor lido para o registrador $t2
    j cont_div
    
cont_div:
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n2
    syscall

    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t3, $v0  # Move o valor lido para o registrador $t3
    beqz $t3, div_erro
    
    div $t1, $t2, $t3                        # função de divisão
    j fim
    
div_erro:
	# se o divisor for igual a zero
	li $v0, 4
	la $a0, msg_erro
	syscall	
	j cont_div
    
case5:			# Potência
    #addi $t0, $zero, 5 -- Da pra economizar mais linhas ainda
    bne $s0, $t0, erro 
	# Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n1
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t2, $v0  # Move o valor lido para o registrador $t2
    # Imprime o prompt para o usuário
    li $v0, 4
    la $a0, n2
    syscall
    # Lê o valor digitado pelo usuário
    li $v0, 5
    syscall
    move $t3, $v0  # Move o valor lido para o registrador $t3
        
    li $t1, 1

cont_pot:
	beqz $t3, fim  			# se o expoente é zero, sair do loop
	mul $t1, $t1, $t2  		# multiplica o resultado pela base
	subi $t3, $t3, 1  		# decrementa o expoente
        
	j cont_pot
    
erro:
	li $v0, 4
	la $a0, msg_erro
	syscall

# Encerra o programa
    li $v0, 10
    syscall

fim:
                                            # printar os resultados
    li $v0, 4
    la $a0, result
    syscall
    
    move $a0, $t1
    li $v0, 1
    syscall

# Encerra o programa
    li $v0, 10
    syscall
