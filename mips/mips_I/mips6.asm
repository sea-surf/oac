.text
.globl main

quadrado:
    mul $v0, $a0, $a0      # $v0 = n * n
    jr $ra                 # Retorna para quem chamou

soma:
    # --- PROLÓGO ---
    addi $sp, $sp, -12     # Abre espaço para 3 itens na stack (12 bytes)
    sw $ra, 8($sp)         # Salva o $ra (caminho para a main)
    sw $s0, 4($sp)         # Salva $s0 (vamos usá-lo para guardar o 'b')
    sw $s1, 0($sp)         # Salva $s1 (vamos usá-lo para guardar o 1º resultado)

    # --- CORPO ---
    move $s0, $a1          # Guarda o 'b' em $s0 para não perder
    
    # 1ª chamada: quadrado(a)
    # (O 'a' já está em $a0, então só chamamos a função)
    jal quadrado
    move $s1, $v0          # Guarda o resultado de quadrado(a) em $s1

    # 2ª chamada: quadrado(b)
    move $a0, $s0          # Coloca o 'b' (que estava em $s0) em $a0
    jal quadrado           # O resultado de quadrado(b) vai para $v0

    # Soma final
    add $v0, $s1, $v0      # $v0 = quadrado(a) + quadrado(b)

    lw $s1, 0($sp)         # Restaura o $s1 original
    lw $s0, 4($sp)         # Restaura o $s0 original
    lw $ra, 8($sp)         # Restaura o $ra original (caminho para a main)
    addi $sp, $sp, 12      # Fecha o espaço na stack

    jr $ra                 # Retorna para a main

main:
    li $a0, 2              # Argumento a = 2
    li $a1, 3              # Argumento b = 3
    jal soma               # Chama soma(2, 3)

    move $a0, $v0          # Move o resultado (13) para $a0 para imprimir
    li $v0, 1              # Syscall 1 = print_int
    syscall
    
    li $v0, 10             # Syscall 10 = exit
    syscall
