.data

.text
	
loop:
	
	
	# 2
	#	.data

	# .text
	#	li $t0, 5
	#	li $s0, $zero
	
        # loop:
	# 	add $t0, $t0, -1
	# 	bne $t0, $zero, loop

	# add $s0, $s0, $t0
	
	# Offset Formula
	# PC' = (PC+4) + (Offset*4)
	# PC' = (0x00400004 + 8) + (-2 * 4)
	# PC' = 0x00400008 -8 = 0x00400000 (loop)
	
	# Endereço 
	### Modos de Endereçamento MIPS
	
	# Calculo do offset
	# 0x00400000 loop: addi $t0, $t0, -1
	# 0x00400004 bne $t0, $zero, loop
	# 0x00400008 add $s0, $s0, $t0
	# Offset de bne: 0x00400000 - 0x00400008 = -8 bytes  -> 8 / 4 = -2
	# Voltar 2 instruções a partir da proxima
	
	#1. **Relativo ao PC:** Soma o PC+4 com um offset. (Ex: `bne`, `beq`)
	#2. **Por Registrador:** Usa apenas registradores. (Ex: `add`, `sub`)
	#3. **Imediato:** Usa uma constante na própria instrução. (Ex: `addi`, `ori`)
	#4. **Base / Deslocamento:** Soma um registrador base a uma constante para acessar a memória. (Ex: `lw`, `sw`)
	#5. **Pseudodireto:** Concatena parte do PC com o endereço da instrução. (Ex: `j`, `jal`)
	
	# Complemento de 2 (-2)
	# 2 = 0010
	#     1101 + 1 = 1110 (-2)
	
	# 1
	# slt $s0, $s1, $s2
	# Set less than, set to 1 if s1 < s2
	# op 6 rs 5 rt 5 rd 5 shamt 5 funct 6
	# s0=16 s1=17 s2=18 funct=101010
	# binary: 000000 10001 10010 10000 00000 101010
	# binary: 0000 0010 0011 0010 1000 0000 0010 1010
	# Hexadec 0      2    3    2    8   0     2   A
	
	# SHAMT = Shift Amount 
	# Usado para fazer operações de shift como 
	# sll $s0, $s0, 4  s0 = 0011 -> s0 = 11 0000
