.data
    msg1: .asciiz "A >= B"
    msg2: .asciiz "A < B"

.text
main:

    li $t0, 100           # a = 10
    li $t1, 20           # b = 20
    slt $t2, $t0, $t1    # set(1) less than: t2 = 1 se t0(a) < t1(b)
    beq $t2, $zero, else # branch equal: se t2 = 0 (false), else

if:
    # --- A < B ---
    la $a0, msg2        # Carrega endereço de "A < B"
    li $v0, 4           # syscall 4 (Print String)
    syscall
    
    j fim               # jump     

else:
    # --- A >= B ---
    la $a0, msg1        # Carrega endereço de "A >= B"
    li $v0, 4           # Prepara syscall 4 (Print String)
    syscall

fim:
    li $v0, 10          # Syscall 10 (Exit)
    syscall