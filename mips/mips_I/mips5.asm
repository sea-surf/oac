.text
.globl main

soma:
    add $v0, $a0, $a1
    jr $ra             # volta para main (PC + 8)

main:
    li $a0, 2
    li $a1, 3
    
    jal soma           # solta para label e salva o retorno em $ra
    
    move $t0, $v0
    
    li $v0, 10
    syscall
