.data
    msg_ok:   .asciiz "-> Condicao verificada.\n"
    msg_if:   .asciiz "-> Bloco IF executado.\n"
    msg_else: .asciiz "-> Bloco ELSE executado.\n"

.text
main:
    # 1. SLT (Set on Less Than)
    li $t0, 10
    li $t1, 20
    slt $t2, $t0, $t1    
    bne $t2, $zero, success_1
    j test_2
success_1:
    jal print_success

test_2:
    # 2. BEQ (Branch on Equal)
    li $t0, 5
    li $t1, 5
    beq $t0, $t1, success_2
    j test_3
success_2:
    jal print_success

test_3:
    # 3. BNE (Branch on Not Equal)
    li $t0, 5
    li $t1, 8
    bne $t0, $t1, success_3
    j test_4
success_3:
    jal print_success

test_4:
    # 4. BEQZ (Branch on Equal to Zero)
    li $t0, 0
    beqz $t0, success_4
    j test_5
success_4:
    jal print_success

test_5:
    # 5. Pseudo-Instrucao BGE (Branch on Greater or Equal)
    li $t0, 100
    li $t1, 50
    
    bge $t0, $t1, if_block  
    j else_block            

if_block:
    la $a0, msg_if
    li $v0, 4
    syscall
    j exit

else_block:
    la $a0, msg_else
    li $v0, 4
    syscall

exit:
    li $v0, 10         
    syscall

# --- Funcoes Auxiliares ---
print_success:
    la $a0, msg_ok
    li $v0, 4
    syscall
    jr $ra  # Retorna para a linha depois do jal