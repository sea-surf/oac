# Hipotenusa h^2 = a^2 + b^2
.data

.text

.globl hipotenusa

hipotenusa:
	li $t0, 0
	add $a2, $a0, $a1 # h^2 = a^2 + b^2
	
loop:
	mul $t1, $t0, $t0
	bge $t1, $a2, fim
	addi $t0, $t0, 1
	j loop
	
fim:
	jr $ra
	
