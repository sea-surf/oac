.data
	constante: .word 0x12345678
.text
	lui $t0, 0x1234
	
	ori $t0, $t0, 0x5678
	
	syscall