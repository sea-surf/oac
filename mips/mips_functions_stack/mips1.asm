.data
    a: .word 3
    b: .word 4

.text
.globl main

main:
    # Carrega os valores de 'a' e 'b' nos registradores de argumento
    lw $a0, a       # $a0 = a
    lw $a1, b       # $a1 = b

    # Chama somar(a, b) -> calcula a^2 + b^2
    jal somar

    # O resultado retornado está em $v0
    move $a0, $v0   # move para $a0 para imprimir
    li $v0, 1       # syscall 1: print_int
    syscall

    # Finaliza o programa
    li $v0, 10      # syscall 10: exit
    syscall


# -------------------------------------------------------------
# Função: quadrado
# Entrada: $a0 = x
# Retorno: $v0 = x * x
# -------------------------------------------------------------
quadrado:
    mul $v0, $a0, $a0
    jr $ra          # Retorna para o chamador (label somar - logo após o jal) 


# -------------------------------------------------------------
# Função: somar (calcula a^2 + b^2)
# Entrada: $a0 = a, $a1 = b
# Retorno: $v0 = a^2 + b^2
# -------------------------------------------------------------
somar:
    # Aloca espaço na pilha para salvar $ra e registradores temporários
    addi $sp, $sp, -12
    sw $ra, 8($sp)  # Guarda o ra em baixo do stack antes que somar chame outra função
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    move $s1, $a1   # Salva 'b' em $s1 antes de chamar quadrado

    # Calcula quadrado(a) -> $a0 já contém 'a'
    jal quadrado
    move $s0, $v0   # $s0 = a^2 - move o resultado de v0 para s0

    # Calcula quadrado(b)
    move $a0, $s1   # $a0 = b
    jal quadrado    # $v0 = b^2

    # Soma os dois resultados
    add $v0, $s0, $v0

    # Restaura pilha e registradores
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp) # Restaurar ra
    addi $sp, $sp, 12

    jr $ra          # Retorna para a main