 .data

    constante: .word 0x12345678

.text
	la $t0, constante
	lw $t0, 0($t0)
	
	# Extrair terceiro byte (0x34)
	sll $t1, $t0, 8    # Descarta os MSB bits (0x1234) $t1 = 
	srl $t1, $t1, 24    # Descarta os LSB bits 15-0  (0x 78 00 00) 
	
	syscall