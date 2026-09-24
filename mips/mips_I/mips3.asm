.data
    N: .word 5
    N_fat: .word 0
.text
    la $t0, N
    lw $t0, 0($t0)     # t0 = N
    addi $a0, $t0, -1  # a0 = t0 - 1
loop: 
    beq $a0, $zero, end  # a0 = 0 jump end
    mul $t0, $t0, $a0    # t0 = t0 * a0 (N * N-1)
    subi $a0, $a0, 1     # a0 = a0 - 1 
    j loop
     
end:
    la $t1, N_fat
    sw $t0, 0($t1)
    
    li $v0, 10
    syscall

# Escreva um programa em MIPS que calcule o fatorial de N e armazene o resultado na memória. Considere N = 5
	
