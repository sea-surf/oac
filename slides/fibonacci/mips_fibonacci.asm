# int fibonacci_iterativo(int n) {
#    if (n <= 1) return n;
#    int anterior = 0;
#    int atual = 1;
#    int proximo;
#    for (int i = 2; i <= n; i++) {
#        proximo = anterior + atual;
#        anterior = atual;
#        atual = proximo;
#    }   
#    return atual;
#}

.data
	msg_a: .asciiz "Digite numero: "
.text
	# Ler
	li $v0, 4
	la, $a0, msg_a
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0 # a0 = n, fib(n)
	
	# Fibonacci
	jal fibonacci
	
	# Salvar resultado
	# move $a0, $v0
	
	# Print a0
	#li $v0, 1
	#syscall
	
	# Finish
	li $v0, 10
	syscall
