.data
    registrador: .word 0xABCDE3F0   # Alvo: 0xABCDE3CA
    novo_CA:     .word 0x0000000A
    novo_CB:     .word 0x0000003C

.text
    # 1. Carrega o valor principal e limpa os 12 bits finais (3F0)
    la   $s0, registrador
    lw   $t0, 0($s0)            # $t0 = 0xABCDE3F0
    srl  $t0, $t0, 12           # $t0 = 0x000ABCDE
    sll  $t0, $t0, 12           # $t0 = 0xABCDE000  (fica pronto esperando o 3CA)

    # 2. Carrega o 0x3C e desloca 4 bits para a esquerda
    la   $t1, novo_CB
    lw   $t3, 0($t1)            # $t3 = 0x0000003C
    sll  $t3, $t3, 4            # $t3 = 0x000003C0  (abriu espaço para o A)

    # 3. Carrega o 0x0A e combina no registrador auxiliar
    la   $t2, novo_CA
    lw   $t4, 0($t2)            # $t4 = 0x0000000A
    or   $t3, $t3, $t4          # $t3 = 0x000003CA  (pedaço montado com sucesso!)

    # 4. Junta o pedaço pronto com o valor principal
    or   $t0, $t0, $t3          # $t0 = 0xABCDE3CA

    # 5. Salva na memória e finaliza
    sw   $t0, 0($s0)
    li   $v0, 10
    syscall