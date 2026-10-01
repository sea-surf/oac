# int hipotenusa(int a, int b)
# int quadrado(int x)

.data
	msg_a: .asciiz "Digite numero 1: "
	msg_b: .asciiz "Digite numero 2: "
	msg_res: .asciiz "Resposta: "
.text
	# Ler
	li $v0, 4
	la $a0, msg_a
	syscall

	li $v0, 5
	syscall
	move $s0, $v0 # Ler e movimentar v0 para s0, s0 = a
	
	# Ler
	li $v0, 4
	la $a0, msg_b
	syscall

	li $v0, 5
	syscall
	move $s1, $v0
	
	# Salvar a^2 + b^2
	move $a0, $s0
	mul $a0, $a0, $a0
	move $a1, $s1
	mul $a1, $a1, $a1
	
	
	# Funcao hipotenusa
	# $s0 = a, $s1 = b, h^2 = a^2 + b^2
	jal hipotenusa
	
	# Print
	li $v0, 4
	la $a0, msg_res
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	# End
	li $v0, 10
	syscall
