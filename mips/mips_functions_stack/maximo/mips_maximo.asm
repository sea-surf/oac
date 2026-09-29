# int maximo(int a, int b)

.data
	msg_a: .asciiz "Digite numero 1: "
	msg_b: .asciiz "Digite numero 2: "
	msg_res: .asciiz "Resposta: "
	
.text
.globl main

main:
	# Ler
	li $v0, 4
	la $a0, msg_a
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	# Ler
	li $v0, 4
	la $a0, msg_b
	syscall

	li $v0, 5
	syscall
	move $s1, $v0
	
	# Funcao maximo
	move $a0, $s0
	move $a1, $s1
	jal maximo
	move $s2, $v0        # Mover resultado antes de usar v0 novamente

	# Resposta: "
	li $v0, 4
	la $a0, msg_res
	syscall

	li $v0, 1
	move $a0, $s2
	syscall

	li $v0, 10
	syscall
