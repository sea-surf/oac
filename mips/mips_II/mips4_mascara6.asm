.data
    registrador: .word 0xABCDE3F0 #3F0 -> 3CA
    novo_CA: .word 0x0000000A
    novo_CB: .word 0x0000003C
.text
    la $t0, registrador
    lw $t0, 0($t0)
    srl $t0, $t0, 12
    sll $t0, $t0, 12
    srl $t0, $t0, 4
    
    la $t1, novo_CB
    lw $t1, 0($t1)
    or $t0, $t0, $t1
    
    sll $t0, $t0, 4
    
    la $t2, novo_CA
    lw $t2, 0($t2)
    or $t0, $t0, $t2
    
    syscall