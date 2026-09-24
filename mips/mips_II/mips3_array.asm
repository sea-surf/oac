.data
    # Declarando um vetor de 4 posições (words) na memória
    array: .word 10, 20, 30, 40   # Índices: 0, 1, 2 e 3

.text
.globl main

main:
    # ----------------------------------------------------
    # Acesso Dinâmico SEM SLL: usando 'mul'
    # ----------------------------------------------------
    li $t0, 2           # Definimos o índice 'i' que queremos acessar (i = 2)
    li $t9, 4           # Cada elemento ocupa 4 bytes na memória
    
    # Shift 2 posições para a esquerda 0001 (x1 2^0) -> 0100 (x4 2^2)
    sll $t0, $t0, 2   # $t0 = 2 * 4 = 8 
    
    la $s2, array       # Carrega o endereço base inicial do vetor em $s2
    add $s2, $s2, $t0   # Soma Base + Offset -> $s2 agora aponta para array[2]
    
    lw $t1, 0($s2)      # $t1 recebe o conteúdo de array[2] (lê o valor 30)
    
    addi $t1, $t1, 5    # Soma 5 ao valor que acabamos de ler: $t1 = 35
    sw $t1, 0($s2)      # Escreve o novo valor (35) de volta na memória, em array[2]

    # ----------------------------------------------------
    # Acesso Estático: Lendo array[3] diretamente
    # ----------------------------------------------------
    la $s3, array       # Endereço base inicial do vetor
    lw $t2, 12($s3)     # Offset estático (3 * 4 = 12). Lê array[3] (valor 40)

    # Encerrando o programa
    li $v0, 10
    syscall
