.text
.globl main

main:
    # Digamos que temos o valor 0xAB em $t0
    # Queremos isolar apenas o dígito 'A' (que vale 10 em decimal)
    li $t0, 0xAB            # Em binário: 1010 1011

    # PASSO 1: Puxar o 'A' para a ponta direita usando SRL
    # Deslocamos 4 bits para a direita (cada dígito hexa tem 4 bits)
    srl $t1, $t0, 4         # $t1 agora vale 0x0A (binário: 0000 1010)

    # PASSO 2: Aplicar a MÁSCARA usando ANDI
    # A máscara 0x0F em binário é '0000 1111'
    # Os '1' deixam o 'A' passar, os '0' garantem que nada mais passe
    andi $t2, $t1, 0x0F     # $t2 = 0x0A (10 em decimal)

    # Fim do programa
    li $v0, 10
    syscall

###     0000 1010   ($t1)
###  &  0000 1111   (Máscara 0x0F)
###     -------------
###     0000 1010   ($t2)