.data

.text

.globl maximo

maximo:
	nop # funcao maximo
	
	slt $t0, $a1, $a0
	beq $t0, $zero, else
	add $v0, $a0, $zero # a > b: v0 = a
	j fim
else:
	add $v0, $a1, $zero # a < b: v0 = b
fim:
	jr $ra # retorna para depois do jal no main
