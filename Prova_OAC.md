# Prova de Organização e Arquitetura de Computadores (Nível Avançado)

**Nome:** _______________________________________________________ **Data:** ___/___/___

---

## Parte 1: Teoria Profunda dos Elementos Definitórios da ISA

**1. Arquitetura vs. Organização e Modelos Físicos**
Explique a diferença fundamental entre a Arquitetura de Conjunto de Instruções (ISA) e a Organização de um Processador. Além disso, diferencie o modelo de arquitetura de Harvard do modelo de Von Neumann em relação à estruturação do espaço de memória e dos barramentos.

**2. Convenções e Papéis dos Registradores (MIPS)**
Sabendo que o MIPS possui 32 registradores de 32 bits, explique a rigorosa convenção de uso de software que dita o papel dos seguintes registradores:
* a) `$v0` a `$v1`
* b) `$a0` a `$a3`
* c) Diferença entre `$t0-$t9` (temporários) e `$s0-$s7` (salvos)
* d) A função crítica do registrador `$ra` (Return Address).

**3. Formatos de Instrução e Bits**
Considere a instrução MIPS: `addiu $29, $29, -32`. Ela pertence ao formato Tipo I (Imediato). 
* a) Qual é o tamanho total da instrução em bits?
* b) Descreva a quebra exata dos campos lógicos dessa instrução (opcode, rs, rt, imediato) indicando a quantidade de bits de cada campo.
* c) Como a constante negativa `-32` é representada em binário no campo correspondente?

**4. Modos de Endereçamento e Matemática do Hardware**
Defina os modos de endereçamento presentes nas duas instruções abaixo e explique matematicamente como o hardware calcula o endereço alvo/destino em cada caso:
* a) `lw $t0, 8($s0)`
* b) `beq $t0, $zero, ROTULO` (Indique a fórmula matemática exata usando o `PC` atual e o imediato codificado na instrução).

**5. Barramentos e Alinhamento de Memória**
* a) Em um processador com um barramento de endereço de $m$ bits e um barramento de dados de $n$ bits, qual é a quantidade máxima de posições endereçáveis na memória e qual o tamanho da palavra trafegada por vez?
* b) O que significa a regra de "Alinhamento de Memória" (Word Alignment) do MIPS ao acessar palavras de 32 bits na memória (com instruções como `lw` e `sw`)?

---

## Parte 2: Interpretação Avançada de Código MIPS

**6. Chamadas de Função e Controle de Fluxo**
Considere o seguinte trecho adaptado da função "maximo":
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
* a) O que ocorre exata e internamente no hardware (alteração de PC e outros registradores) quando a instrução chamadora `jal maximo` é executada na `main`?
* b) Por que a função termina obrigatoriamente com a instrução `jr $ra`?
* c) Qual é a lógica condicional exata realizada nas três primeiras linhas e qual é o valor de retorno final?

**7. Loop MIPS - Sequência de Fibonacci**
```assembly
loop:
    add $t3, $t1, $t2
    move $t1, $t2
    move $t2, $t3
    addi $t7, $t7, -1
    bgtz $t7, loop
```
* a) Descreva a manipulação matemática realizada nos registradores `$t1`, `$t2` e `$t3`. 
* b) A instrução `bgtz $t7, loop` faz o laço se repetir. Qual é a condição lógica para a saída desse laço?

**8. Cálculos em Laço Condicional (Hipotenusa)**
Sendo `$a2` iniciado com o valor $a^2 + b^2$ e `$t0` iniciado com 0:
```assembly
loop:
    mul $t1, $t0, $t0
    bge $t1, $a2, fim
    addi $t0, $t0, 1
    j loop
fim:
    jr $ra
```
O que o registrador `$t0` conterá ao final da execução (no rótulo `fim`) em relação à hipotenusa? Explique a condição avaliada pelo `bge`.

**9. Engenharia Reversa e Tradução (Binário $\leftrightarrow$ Assembly)**
A tradução entre a linguagem de montagem e a linguagem de máquina (código-objeto) obedece estritamente aos formatos de instrução estudados (Tipos R, I e J). Com base nisso, faça a engenharia reversa do código de máquina em hexadecimal **`0x012A4020`**:
* a) Converta o valor hexadecimal para binário (32 bits).
* b) Identifique seus campos assumindo que seja do **Tipo R** (`opcode = 0`, `funct = 32`, que indica a operação `add`), determine quais são os registradores (sabendo que `$t0=8`, `$t1=9`, `$t2=10`) e escreva a instrução final em linguagem Assembly.

---

## Parte 3: Microcontrolador MSP430

**10. Especificidades do MSP430**
O microcontrolador MSP430G2553 é amplamente focado em sistemas embarcados.
* a) Dentre seus 16 registradores, quais são as funções exclusivas e dedicadas dos registradores `R0`, `R1` e `R2`?
* b) O MIPS utiliza opcodes distintos como `lw` (load word) e `lb` (load byte) para tratar tamanhos de dados diferentes. Como a ISA do MSP430 resolve a escolha do tamanho do dado (16 bits vs 8 bits) na sua sintaxe de Assembly?
