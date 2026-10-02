# Gabarito - Prova de Organização e Arquitetura de Computadores (Nível Avançado)

## Parte 1: Teoria Profunda dos Elementos Definitórios da ISA

**1. Arquitetura vs. Organização e Modelos Físicos**
* **Resposta:** A Arquitetura (ISA) é a interface visível ao programador, englobando o conjunto de instruções, modos de endereçamento e registradores (ex: MIPS, x86). A Organização trata da engenharia física de implementação dessa ISA (transistores, ALUs, pipelining). 
* **Harvard vs Von Neumann:** No modelo Von Neumann (como no MSP430), dados e instruções dividem fisicamente a mesma memória e barramentos, resultando em um mapa de endereçamento unificado. No modelo de Harvard, a arquitetura possui memórias e barramentos completamente isolados e independentes para os Dados e para as Instruções, permitindo leitura simultânea de ambos.

**2. Convenções e Papéis dos Registradores (MIPS)**
* **Resposta a):** `$v0 - $v1` (registradores 2 e 3): Reservados para armazenar o valor de **retorno** de uma função.
* **Resposta b):** `$a0 - $a3` (registradores 4 a 7): Reservados para passar os primeiros quatro **argumentos** (parâmetros) para uma função.
* **Resposta c):** `$t0 - $t9` são temporários; uma função chamada pode sobrescrevê-los livremente (caller-saved). `$s0 - $s7` são salvos; uma função que desejar alterá-los deve obrigatoriamente fazer o backup na pilha (stack) e restaurá-los antes de retornar (callee-saved).
* **Resposta d):** O `$ra` (Return Address, registrador 31) armazena o endereço da instrução original que chamou a subrotina (PC + 4). É vital para o hardware saber para onde voltar após terminar a função.

**3. Formatos de Instrução e Bits**
* **Resposta a):** O tamanho total da instrução no MIPS é sempre de **32 bits** (4 bytes).
* **Resposta b):** O formato Imediato (Tipo I) divide os 32 bits da seguinte forma: 
  `| opcode (6 bits) | rs (5 bits) | rt (5 bits) | imediato (16 bits) |`. 
  Na instrução `addiu $29, $29, -32`: rs=$29, rt=$29 e o imediato = -32.
* **Resposta c):** A constante `-32` deve ser representada em **Complemento de 2** usando os 16 bits limitados pelo campo. O valor em binário é `11111111 11100000`.

**4. Modos de Endereçamento e Matemática do Hardware**
* **Resposta a) `lw $t0, 8($s0)`:** Modo **Base-Deslocamento**. O hardware busca o conteúdo armazenado no registrador base `$s0`, e internamente usa a ALU para somar a constante exata `8` ao seu valor, gerando o endereço final absoluto da memória.
* **Resposta b) `beq $t0, $zero, ROTULO`:** Modo **Relativo ao PC**. Se a condição for verdadeira, o endereço de destino (salto) é calculado pela fórmula matemática: 
  `Endereço Alvo = (PC atual + 4) + (imediato * 4)`. O fator `* 4` (shift left 2) existe porque as instruções MIPS sempre pulam de 4 em 4 bytes (alinhadas).

**5. Barramentos e Alinhamento de Memória**
* **Resposta a):** Com $m$ bits de endereço, a memória possui uma capacidade máxima de **$2^m$ posições** endereçáveis. O tamanho da palavra transferida por vez equivale estritamente aos $n$ bits de largura do barramento de dados.
* **Resposta b):** O "Word Alignment" (Alinhamento de Palavra) exige que qualquer acesso de 32 bits (1 palavra = 4 bytes) à memória aconteça obrigatoriamente em um endereço que seja múltiplo de 4 (ex: 0, 4, 8, 12, 0x10...). 

---

## Parte 2: Interpretação Avançada de Código MIPS

**6. Chamadas de Função e Controle de Fluxo**
* **Resposta a):** A instrução `jal maximo` simultaneamente escreve o valor atual do registrador `PC + 4` dentro do registrador `$ra` (salvando o endereço de retorno) e, em seguida, altera o `PC` para o endereço da função (rótulo `maximo`), transferindo o controle do programa.
* **Resposta b):** A instrução `jr $ra` ("jump register") instrui o `PC` a receber o conteúdo atual do `$ra`. É o mecanismo que realiza o retorno efetivo para o código chamador na `main`.
* **Resposta c):** O `slt` checa se `$a1 < $a0`. Se for verdadeiro, `$t0 = 1`; se não, `$t0 = 0`. O `beq` checa se `$t0 == 0` (isto é, `$a1 >= $a0`). Caso positivo, salta para o `else` e retorna `$a1`. Em suma, retorna o valor máximo entre `$a0` e `$a1` no registrador `$v0`.

**7. Loop MIPS - Sequência de Fibonacci**
* **Resposta a):** O trecho `add $t3, $t1, $t2` calcula o próximo valor da sequência (soma atual + anterior). Em seguida, `move $t1, $t2` atualiza o valor "anterior" com o "atual". Finalmente, `move $t2, $t3` atualiza o "atual" com o novo valor "próximo". 
* **Resposta b):** O registrador `$t7` atua como um contador que decresce 1 por vez. A instrução `bgtz` (*Branch if Greater Than Zero*) faz o laço se repetir apenas enquanto `$t7 > 0`. A saída do laço ocorre assim que `$t7` atingir `0`.

**8. Cálculos em Laço Condicional (Hipotenusa)**
* **Resposta:** O loop incrementa `$t0` em 1 a cada iteração, calcula o seu quadrado (`$t1 = $t0 * $t0`) e compara com a soma dos catetos ao quadrado (`$a2`). A condição `bge` (*Branch if Greater than or Equal*) encerra o loop assim que `$t1 \ge $a2`. No final, `$t0` representará o valor inteiro da hipotenusa (arredondado para o teto caso a raiz não seja exata).

**9. Engenharia Reversa e Tradução (Binário $\leftrightarrow$ Assembly)**
* **Resposta a):** Convertendo `0x012A4020` para binário temos 32 bits: 
  `0000 0001 0010 1010 0100 0000 0010 0000`
* **Resposta b):** Como os 6 primeiros bits são `000000`, trata-se do formato Tipo R. Dividindo os campos em `| op (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6) |`:
  - `op`: 000000 (0)
  - `rs`: 01001 (9 em decimal) $\rightarrow$ Refere-se ao registrador `$t1`
  - `rt`: 01010 (10 em decimal) $\rightarrow$ Refere-se ao registrador `$t2`
  - `rd`: 01000 (8 em decimal) $\rightarrow$ Refere-se ao registrador `$t0`
  - `shamt`: 00000 (0)
  - `funct`: 100000 (32 em decimal) $\rightarrow$ Indica a operação `add`
  Montando a sintaxe `add rd, rs, rt`, a instrução reversa é: **`add $t0, $t1, $t2`**.

---

## Parte 3: Microcontrolador MSP430

**10. Especificidades do MSP430**
* **Resposta a):** No MSP430:
  * `R0`: Atua como o **Program Counter (PC)**, controlando o fluxo de execução.
  * `R1`: Atua como o **Stack Pointer (SP)**, apontando para o topo da pilha na RAM.
  * `R2`: Atua como **Status Register (SR)** (para as flags aritméticas/controle) e também como *Constant Generator* 1.
* **Resposta b):** Como a memória transita livremente dados e os opcodes são unificados, a ISA do MSP430 usa **sufixos declarativos nas próprias instruções**: `.w` (word) para operar sobre 16 bits (ex: `MOV.w`) e `.b` (byte) para operar em apenas 8 bits (ex: `MOV.b`). Caso o sufixo seja omitido, o assembler adota `.w` por padrão.
