.data
	constante: .word 0xABCD1234
	
	mascara: .word 0x00000F00
.text
	la $t0, constante
	
	lw $t0, 0($t0)
	
	la $t1, mascara
	
	lw $t1, 0($t1)
	
	and $t2, $t1, $t0
	
	srl $t2, $t2, 8   # 
	
	syscall