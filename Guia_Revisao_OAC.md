# Guia de Revisão Completo - Organização e Arquitetura de Computadores

Este guia compila os tópicos teóricos e práticos detalhados para a prova, com foco na arquitetura MIPS (32 bits) e no microcontrolador MSP430 (16 bits), englobando formatos exatos em bits, convenções de registradores e modos de endereçamento.

---

## 1. Arquitetura vs. Organização
* **Arquitetura (ISA - Instruction Set Architecture):** É o modelo mental do programador. Define **o que** o processador faz: as instruções, tamanho da palavra, registradores acessíveis e a forma como a memória é vista. Ex: MIPS32, x86, ARM.
* **Organização (Microarquitetura):** É o projeto de hardware. Define **como** a ISA é implementada em silício: transistores, ALUs (Unidade Lógica Aritmética), pipelining, cache e barramentos.
* **Modelos de Memória Gerais:**
  * **Von Neumann:** Dados e Instruções dividem o mesmo espaço de memória e os mesmos barramentos. (Gargalo de Von Neumann). É o caso do MSP430.
  * **Harvard:** Memórias e barramentos fisicamente separados para Dados e Instruções. Permite leitura simultânea.

## 2. Visão Detalhada dos Registradores
Os registradores são as memórias mais rápidas do sistema, localizadas dentro da CPU.

### A. Registradores MIPS (32 registradores de 32 bits)
No MIPS, embora haja 32 registradores genéricos, a convenção dita o uso de cada um:
* **$zero (0):** Sempre contém o valor 0. Imutável.
* **$v0 - $v1 (2-3):** Usados para armazenar o **valor de retorno** de uma função.
* **$a0 - $a3 (4-7):** Usados para passar os **argumentos** (parâmetros) para uma função.
* **$t0 - $t9 (8-15, 24-25):** Registradores **temporários**. A função chamada pode alterá-los livremente.
* **$s0 - $s7 (16-23):** Registradores **salvos**. Se uma função quiser usá-los, ela deve salvar o valor original na pilha (Stack) e restaurá-lo antes de retornar.
* **$sp (29):** *Stack Pointer* - Aponta para o topo da pilha.
* **$ra (31):** *Return Address* - Guarda o endereço para o qual a função deve retornar após terminar (usado pelo `jal`).

### B. Registradores MSP430 (16 registradores de 16 bits)
* **R0:** `PC` (Program Counter) - Aponta para a próxima instrução.
* **R1:** `SP` (Stack Pointer) - Ponteiro de pilha.
* **R2:** `SR/CG1` (Status Register / Constant Generator 1).
* **R3:** `CG2` (Constant Generator 2).
* **R4 - R15:** Uso geral para variáveis e cálculos.

## 3. Formatos de Instrução (O Código de Máquina)
Toda instrução no **MIPS possui exatamente 32 bits (4 bytes)**. A forma como esses 32 bits são fatiados depende do "Formato" da instrução:

### A. Tipo R (Register)
Usado para instruções lógicas e aritméticas onde todos os operandos são registradores (ex: `add`, `sub`, `and`).
* **Estrutura (32 bits):** `| opcode (6 bits) | rs (5 bits) | rt (5 bits) | rd (5 bits) | shamt (5 bits) | funct (6 bits) |`
  * **opcode:** Diz a categoria da operação (geralmente `0` para Tipo R).
  * **rs / rt:** Registradores fonte (5 bits permitem endereçar $2^5 = 32$ registradores).
  * **rd:** Registrador destino.
  * **shamt:** *Shift amount* (quantidade de deslocamento para operações de shift, ex: `sll`).
  * **funct:** Define qual operação exata realizar (já que o opcode é genérico).

### B. Tipo I (Immediate)
Usado quando a instrução carrega uma constante matemática (imediato), ou para Load/Store e Branches (ex: `addi`, `lw`, `sw`, `beq`).
* **Estrutura (32 bits):** `| opcode (6 bits) | rs (5 bits) | rt (5 bits) | imediato (16 bits) |`
  * **imediato:** O valor numérico embutido. Com 16 bits, pode representar de -32768 a +32767 (em complemento de dois).

### C. Tipo J (Jump)
Usado para saltos incondicionais absolutos (ex: `j`, `jal`).
* **Estrutura (32 bits):** `| opcode (6 bits) | endereço (26 bits) |`
  * O processador pega os 26 bits, multiplica por 4 (shift left 2) gerando 28 bits, e junta aos 4 bits mais significativos do PC atual para formar o salto.

### D. Exemplo Prático de Tradução (Assembly ↔ Binário/Hexadecimal)

**1. De Assembly para Binário/Hexadecimal:**
Vamos traduzir a instrução `addiu $29, $29, -32`.
* **Formato:** Tipo I (Imediato). O `opcode` da operação `addiu` é 9.
* **Separando os campos:** `| opcode (6) | rs (5) | rt (5) | imm (16) |`
* **Convertendo os valores para binário:**
  * `opcode` = 9 $\rightarrow$ `001001`
  * `rs` (`$29`) = 29 $\rightarrow$ `11101`
  * `rt` (`$29`) = 29 $\rightarrow$ `11101`
  * `imm` = -32 $\rightarrow$ Usando Complemento de 2 em 16 bits: `1111111111100000`
* **Juntando tudo (Binário contínuo):** `00100111101111011111111111100000`
* **Agrupando de 4 em 4 bits para Hexadecimal:**
  `0010` (2), `0111` (7), `1011` (B), `1101` (D), `1111` (F), `1111` (F), `1110` (E), `0000` (0)
* **Resultado Hexadecimal:** `0x27BDFFE0`

**2. De Hexadecimal para Assembly:**
Vamos fazer a engenharia reversa do código hexadecimal `0x012A4020`.
* **Convertendo para Binário (32 bits):**
  `0000 0001 0010 1010 0100 0000 0010 0000`
* Analisando o **opcode** (6 primeiros bits): `000000` (0). Opcode 0 no MIPS significa que é uma instrução do **Tipo R**.
* **Separando os campos Tipo R:** `| op (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6) |`
  * `op`: `000000` (0)
  * `rs`: `01001` (9) $\rightarrow$ Refere-se ao registrador `$t1` (pois `$t0` é 8)
  * `rt`: `01010` (10) $\rightarrow$ Refere-se ao registrador `$t2`
  * `rd`: `01000` (8) $\rightarrow$ Refere-se ao registrador `$t0`
  * `shamt`: `00000` (0)
  * `funct`: `100000` (32) $\rightarrow$ O código 32 indica a operação de adição `add`
* **Montando a instrução final:** O formato em Assembly escreve-se como `add rd, rs, rt`. 
* **Resultado Assembly:** `add $t0, $t1, $t2`

## 4. Modos de Endereçamento (Como encontrar o dado)
* **Imediato:** O operando está direto nos 16 bits da instrução. (ex: O `100` em `addi $t0, $t1, 100`).
* **A Registrador:** O operando é o conteúdo de um registrador codificado na instrução. (ex: `$t1`, `$t2` em Tipo R).
* **Base-Deslocamento:** Usado no acesso à memória (Load/Store). Soma-se o conteúdo de um registrador Base (`rs`) com uma constante/deslocamento (`imediato` de 16 bits). Ex: `lw $t0, 8($s0)` -> Endereço lido = conteúdo de `$s0` + `8`.
* **Relativo ao PC:** Usado por saltos condicionais (`beq`, `bne`). O novo endereço (se o salto ocorrer) será: `PC_atual + 4 + (imediato * 4)`. O imediato é a "quantidade de instruções" a pular para frente ou para trás.
* **Pseudo-Direto:** Usado no Jump (`j`). Como visto no Tipo J, forma o endereço combinando 26 bits da instrução com o PC.

## 5. O Acesso à Memória
A comunicação UCP $\leftrightarrow$ Memória é feita por sinais (barramentos):
1. **Sinais de Endereço:** Determina a posição lida/escrita. Se o barramento de endereço tiver $m$ bits, a CPU consegue endereçar $2^m$ posições de memória. No MIPS de 32-bits, $m=32$.
2. **Sinais de Operação (Controle):** *Read/Write* (RW) - Um sinal 0 ou 1 que avisa se a memória deve ejetar o dado (Load) ou salvar o dado (Store).
3. **Sinais de Dados:** O barramento por onde o valor efetivamente trafega ($n$ bits de largura). No MIPS, a largura típica é de 32 fios paralelos.

## 6. Tradução de Código e Lógica MIPS (Exercícios)
Para provas de MIPS, lembre-se destas equivalências clássicas de C para Assembly:
* **`if (A == B)`:** Usa-se instrução contrária para pular o bloco: `bne $t0, $t1, pula_o_bloco`.
* **Loops (`while` / `for`):** Configura-se uma condição de saída e, no fim do laço, coloca-se um `j loop` para voltar.
* **Arrays:** Para avançar em um array de inteiros no MIPS, você deve incrementar o ponteiro **de 4 em 4** (pois cada número de 32-bits = 4 bytes). Exemplo prático: `addiu $t0, $t0, 4`.

## 7. MSP430G2553 (Foco Avançado)
* Ao contrário do MIPS, o MSP430 usa a arquitetura **Von Neumann**. A Memória Flash (para as instruções do programa) e a Memória RAM (para os dados) estão fisicamente unificadas no mesmo mapa de endereços (0x0000 a 0xFFFF).
* O MSP430 pode referenciar um pino do hardware acendendo um LED (`P1OUT`) do mesmo jeito que salva um dado na RAM, usando simples instruções do tipo `MOV`.
* Instruções possuem sufixos de largura: `.w` para palavras inteiras de 16 bits (Word) e `.b` para 8 bits (Byte). O MIPS trata isso com instruções diferentes como `lw` e `lb`.
