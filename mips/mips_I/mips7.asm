# Salvar $s0 na pilha sp

addiu $sp, $sp, -4 # Decrementa sp ( reserva 4 bytes para o valor no registrador)

sw $s0, 0($s0)

# Desalocar

lw $s0, 0($0)

addiu $sp, $sp, 4 # Incrementa $sp (libera 4 bytes)