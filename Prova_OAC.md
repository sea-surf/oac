# Prova de Organização e Arquitetura de Computadores

**Nome:** _______________________________________________________ **Data:** ___/___/___

---

## Parte 1: Teoria dos Elementos Definitórios da ISA

**1. Arquitetura vs. Organização**
Explique a diferença entre a Arquitetura de Conjunto de Instruções (ISA) e a Organização de um Processador (também chamada de Microarquitetura). É possível que duas CPUs com organizações internas totalmente diferentes compartilhem a mesma ISA? Dê um exemplo.

**2. Registradores e Memória**
Do ponto de vista da Arquitetura (ISA), qual a principal diferença conceitual e física entre os registradores acessíveis ao programador e a memória principal? Como a quantidade de registradores pode variar entre diferentes arquiteturas (cite os exemplos do MIPS e do x86)?

**3. Formatos de Instrução**
No MIPS, a instrução em assembly `addiu $29, $29, -32` é traduzida para uma palavra binária única de 32 bits (código-objeto). Quais são os componentes lógicos (campos) que compõem o formato desta instrução para que ela possa ser decodificada pelo hardware? Qual a finalidade do campo `opcode`?

**4. Modos de Endereçamento**
Defina o conceito de "Modos de Endereçamento". Em seguida, observe a instrução `lw $t0, 4($s0)`. Identifique os dois modos de endereçamento presentes nesta instrução e explique como o processador calcula o endereço final do dado a ser buscado na memória.

**5. Modelo de Acesso à Memória**
O processador (UCP) e a memória se comunicam primariamente através de três vias (sinais ou barramentos): Endereço, Dados e Operação (Controle/CE e RW). Explique brevemente o papel de cada um desses três tipos de sinais durante a execução de uma instrução de leitura de dados (Load).

---

## Parte 2: Interpretação de Código MIPS

**6. Interpretação de Funções Condicionais**
Considere o seguinte trecho de código MIPS:
```assembly
maximo:
    slt $t0, $a1, $a0
    beq $t0, $zero, else
    add $v0, $a0, $zero
    j fim
else:
    add $v0, $a1, $zero
fim:
    jr $ra
```
* a) Quais registradores são utilizados convencionalmente para receber os argumentos de entrada e qual registrador guarda o valor de retorno nesta função?
* b) Explique passo a passo a lógica implementada. O que esta função retorna?

**7. Estruturas de Repetição (Loop) e Lógica**
O trecho abaixo foi retirado de uma implementação da sequência de Fibonacci:
```assembly
loop:
    add $t3, $t1, $t2
    move $t1, $t2
    move $t2, $t3
    
    # ... (código de impressão omitido) ...
    
    addi $t7, $t7, -1
    bgtz $t7, loop
```
* a) Explique o papel das três primeiras instruções dentro do laço (linhas 2 a 4). 
* b) Qual é a função do registrador `$t7` neste trecho e qual condição encerra a repetição (avaliada pela instrução `bgtz`)?

**8. Cálculos em Laço**
O trecho a seguir projeta o cálculo de parte do Teorema de Pitágoras ($h^2 = a^2 + b^2$). O registrador `$a2` recebe inicialmente a soma $a^2 + b^2$, e `$t0` é iniciado com 0 antes do laço.
```assembly
loop:
    mul $t1, $t0, $t0
    bge $t1, $a2, fim
    addi $t0, $t0, 1
    j loop
fim:
    jr $ra
```
* a) O que a instrução `mul $t1, $t0, $t0` realiza em cada iteração?
* b) Qual é o objetivo matemático geral desse loop? O que o registrador `$t0` representará ao alcançar o rótulo `fim`?

---

## Parte 3: Microcontrolador MSP430

**9. Arquitetura do MSP430**
O microcontrolador MSP430G2553 possui uma CPU de 16 bits baseada na Arquitetura de Von Neumann. 
* a) O que significa dizer que o MSP430 possui um "espaço de memória unificado" (compartilhado entre Flash, RAM e Periféricos)?
* b) Qual a principal diferença desse modelo de memória (Von Neumann) em relação à arquitetura Harvard (comum em outros microcontroladores)?
