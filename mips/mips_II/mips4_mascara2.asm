.data
	constante1: .word 0xFFFFFFFF
.text

# Mascara 0xFFFF do valor 0xFFFFFFFF
main:	
	# Criar $t1 = 0xFFFFFFFF
	la $t0, constante1
	lw $t0, 0($t0) # load word (32 bits = 4 bytes) e load byte (F = 1111) 
	
	add $t1, $t0, $zero
	
	#srl $t1, $t1, 16 # shif right 2 bytes : registrador 32 bits
	#sll $t1, $t1, 16
	
	# AND
	# t0: 1111 1111 (0xFFFFFFFF)
	# t2: 1111 0000 (0xFFFF0000)
	# t1: 1111 0000 (0x00000000)
	lui $t2, 0xFFFF
	and $t1, $t0, $t2 
	
	
	
	
	