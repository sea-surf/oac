# Stack Add to top, Remove from top

# Salvar $ra, $s0, $s1 (3x4 = 12 bytes)
addiu $sp, $sp, -12 # reserva 3 words

# Store 3 registers on the stack
sw $ra, 8($sp)
sw $s0, 4($sp)
sw $s1, 0($sp) # topo da pilha

# Desempilhar

lw $s1, 0($sp)
lw $s0, 4($sp)
lw $ra, 8($sp)

addiu $sp, $sp, 12 # Libera os 3 slots
