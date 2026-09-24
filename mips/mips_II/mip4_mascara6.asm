.data
    cte: .word 0x00000005     # Exemplo: termina em binário com ...0101 (bit 0 = 1, bit 1 = 0)

.text
    # 1. Carrega o valor da memória
    la  $s0, cte              # $s0 recebe o endereço de cte
    lw  $t0, 0($s0)           # $t0 recebe o valor armazenado em cte

    # 2. Modifica os bits
    andi $t0, $t0, 0xFFFE     # Força bit 0 a ser 0 (máscara: ...1110)
    ori  $t0, $t0, 0x0002     # Força bit 1 a ser 1 (máscara: ...0010)

    # 3. (Opcional) Salva de volta na memória
    sw  $t0, 0($s0)

    # 4. Encerra o programa corretamente
    li  $v0, 10               # Código de saída no MARS/SPIM
    syscall