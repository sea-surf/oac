.data
	msg_esp: .asciiz " "
.text
.globl fibonacci

# Entrada: $a0 (valor de n)
# Saida: $v0 (resultado do fibonacci)

fibonacci:
	ble $a0, 1, caso_base   # Se n <= 1, vai pro caso base
	
	li $t1, 0               # anterior = 0
	li $t2, 1               # atual = 1
	
	addi $t7, $a0, -1       # contador do loop (executa n-1 vezes)
	
	# Print
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, msg_esp
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, msg_esp
	syscall
	

loop:
	add $t3, $t1, $t2       # proximo = anterior + atual
	move $t1, $t2           # anterior = atual
	move $t2, $t3           # atual = proximo
	
	# Print
	move $a0, $t2
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, msg_esp
	syscall
	
	addi $t7, $t7, -1       # decrementa o contador (i--)
	bgtz $t7, loop          # se contador > 0, repete o loop
	
	j fim
	
caso_base:
	move $v0, $a0           # retorna n (0 ou 1)
	jr $ra

fim: 
	move $v0, $t2           # retorna o valor final da sequencia
	jr $ra