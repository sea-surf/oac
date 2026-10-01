# Guia de Revisão Resumido - Organização e Arquitetura de Computadores

Este guia compila os tópicos teóricos e práticos mais cruciais exigidos na prova, com base nos slides da disciplina e nos exercícios de MIPS e MSP430.

---

## 1. Arquitetura vs. Organização
* **Arquitetura (ISA - Instruction Set Architecture):** É a abstração do processador visível ao programador de baixo nível. Define **o que** o processador faz: seu conjunto de instruções, modos de endereçamento, tamanho da palavra e registradores acessíveis. (Ex: x86, ARM, MIPS32).
* **Organização (Microarquitetura):** É como a ISA é implementada fisicamente pelo engenheiro de hardware. Define **como** o processador faz: transistores, ALUs, pipelining, portas lógicas e barramentos internos.
* *Nota crucial:* Várias **organizações** diferentes podem compartilhar e implementar uma mesma **arquitetura** (ISA). (Ex: Processadores Intel e AMD usam organizações diferentes para executar a mesma ISA x86).

## 2. Componentes Fundamentais
* **Processador (CPU):** Executa um ciclo infinito de 3 passos: (1) **Buscar** a instrução, (2) **Decodificar/Identificar** e (3) **Executar**.
* **Registradores:** São pequenas e rapidíssimas memórias *internas* da CPU feitas de flip-flops. 
  * No **MIPS32**, há 32 registradores de uso geral. 
  * No **MSP430**, há 16 registradores (R0 a R3 têm funções especiais como PC e SP, e R4 a R15 são de uso geral).

## 3. Formato de Instruções e Código de Máquina
As instruções da ISA têm um tamanho fixo (ex: 32 bits no MIPS) e possuem formatos bem definidos que traduzem Assembly para Binário (Código Objeto).
* **Opcode (Código de Operação):** É o campo da instrução que diz ao hardware qual operação matemática, lógica ou de controle deve ser feita (ex: se é um ADD, um LOAD ou um BRANCH).
* **Campos Variáveis:** Definem os operandos (registradores de origem `rs`, de destino `rt` e constantes imediatas `imm`).
* **Tradução:** Constantes negativas (ex: `-32`) são representadas em **complemento de dois**. 

## 4. Modos de Endereçamento (CRUCIAL)
Modo de endereçamento é "a forma como o processador localiza ou recupera cada operando de uma instrução". 
* **Imediato:** O dado é uma constante "embutida" no próprio código da instrução. (Ex: `addiu $t0, $t0, 10`).
* **A Registrador:** O operando é recuperado diretamente de um registrador da CPU. (Ex: `$t0`, `$a1`).
* **Direto ou Absoluto:** O operando é um endereço de memória explícito. (O MIPS não possui isso nativamente, exige 2 instruções como `lui` e `ori`).
* **Relativo ao PC:** Usa o Program Counter (PC) atual mais um deslocamento (offset). Muito usado em instruções de salto (Branch, ex: `bne`, `beq`).
* **Base-Deslocamento (ou Indexado):** Usa um registrador contendo um endereço-base e soma uma constante (offset) a ele. Essencial para acessar arrays e structs. (Ex: `lw $t0, 4($s0)` calcula o endereço como `$s0 + 4`).

## 5. Modelo de Acesso à Memória
A comunicação entre o processador e a memória se dá pelos barramentos:
1. **Endereço:** O processador envia qual a exata "gaveta" (posição) da memória que deseja acessar. (Se houver *m* fios, a memória pode ter $2^m$ posições).
2. **Operação/Controle:** O processador diz se deseja **Ler** (Load) ou **Escrever** (Store) na memória.
3. **Dados:** Os fios por onde o dado lido transita da memória para o processador, ou o dado a ser escrito transita do processador para a memória.

## 6. Lógica de Código MIPS (Baseado nos Exercícios)
* **Estrutura de Saltos e Loops:** No assembly MIPS, comandos de controle de fluxo como `while` e `if-else` em C usam rótulos (labels) e saltos (branches/jumps). 
  * `beq` (branch if equal), `bne` (not equal), `bge` (greater or equal). 
  * Um laço geralmente decremente ou incremente um registrador e faça uma checagem (ex: `bgtz $t7, loop` repete enquanto `$t7 > 0`).
* **Chamadas de Função:** Usa-se `jal` (Jump and Link) para ir para uma função. O endereço de retorno fica salvo em `$ra`. A função termina com `jr $ra` para voltar. 
* **Regras de Registradores:** Parâmetros de função vão em `$a0-$a3`. O retorno da função vai em `$v0`.

## 7. Microcontrolador MSP430
* **Arquitetura Von Neumann:** O MSP430 utiliza um **espaço de memória unificado**. Isso significa que a Memória Flash (instruções), a Memória RAM (dados) e os Periféricos compartilham exatamente o mesmo mapa de endereçamento (0x0000 a 0xFFFF).
  * *Diferença para a Harvard:* A arquitetura Harvard divide fisicamente memórias de dados e de instruções. O MSP430 mistura ambos em um único barramento.
* **16 bits nativos:** Todas as passagens e ponteiros do MSP430 são idealizados para palavras (words) de 16-bits (sufixo `.w`), mas ele também permite manipulação a nível de byte (8-bits, sufixo `.b`).
