# Somar de 1 até N
.data
    output:      .word 0
    msg:         .asciiz "Soma: "
    
.text
    li $t1, 10 # N = 10
    li $t2, 1 # 1+2+...+N
    li $t3, 0 # soma

loop:
    bgt $t2, $t1, store # if (t2 > t1(N) ) branch -> store 
    add $t3, $t3, $t2
    addi $t2, $t2, 1
    j loop

store:
    la $a1, output
    sw $t3, 0($a1) # guarda valor de s3 no endereco de output
    
    # Mensagem
    li $v0, 4
    la $a0, msg
    syscall
    li $v0, 1
    move $a0, $t3
    
    syscall

end:
    li $v0, 10
    syscall
