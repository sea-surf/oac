# Achar o maior elemento em um vetor 

.data
    vector: .word 4, 2, 3, 1, 5, -10
    vector_size: .word 6
    vector_max: .word 0
.text
    la $t0, vector                              
    lw $t2, vector_size
    
    lw $t3, 0($t0)
loop: 
    beqz $t2, end
    lw $t1, 0($t0)
    addi $t0, $t0, 4
    subi $t2, $t2, 1
    bge $t1, $t3, store # if t1>=t3
    j loop

store:
    move $t3, $t1 # t3 <- t1
    j loop
    
end:
    la $t4, vector_max
    sw $t3, 0($t4)
    
    li $v0, 10
    syscall

# Iterate through a vector and find the greatest element
# t0 = initial address of the vector 0($t0) = v[0], 4($t0) = v[1], etc...
# t0 keeps is updated inside the loop
# t2 = counter to iterate through the vector
# store: t3 = stores the greatest value
# end: stores the value from t3 inside the address of t4 (buffer vector_max)
	
