.data
    msg1: .asciiz "A >= B"
    msg2: .asciiz "A < B"

.text
main:

    li $t0, 100         # a = 10
    li $t1, 20          # b = 20
    bge $t0, $t1, else  # Se $t0 >= $t1, pular para 'else'

if:
    # --- Executa se A < B ---
    la $a0, msg2        # Carrega endereço de "A < B"
    li $v0, 4           # syscall 4 (Print String)
    syscall
    
    j fim             

else:
    # --- Executa se A >= B ---
    la $a0, msg1        # Carrega endereço de "A >= B"
    li $v0, 4           # Prepara syscall 4 (Print String)
    syscall

fim:
    li $v0, 10          # Syscall 10 (Exit)
    syscall