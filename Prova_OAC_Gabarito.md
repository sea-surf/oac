# Gabarito - Prova de Organização e Arquitetura de Computadores

## Parte 1: Teoria dos Elementos Definitórios da ISA

**1. Arquitetura vs. Organização**
* **Resposta:** A Arquitetura (ISA) é a visão abstrata do programador de baixo nível, definindo o conjunto de instruções, modos de endereçamento e registradores visíveis (ex: ARM v8, x86). A Organização (ou Microarquitetura) é a visão do engenheiro de hardware, tratando da implementação física (transistores, ALUs, fios, pipelining). Sim, é possível que organizações diferentes usem a mesma ISA. Por exemplo, a arquitetura x86 é implementada com organizações internas diferentes por processadores da Intel (Core i7) e da AMD (Ryzen).

**2. Registradores e Memória**
* **Resposta:** Na visão da ISA, os registradores são pequenas unidades de armazenamento de acesso imediato localizadas *dentro* do processador, enquanto a memória é um grande meio de armazenamento localizado *fora* do processador, acessado por meio de endereços e barramentos. A quantidade de registradores varia: ISAs RISC (como MIPS32) costumam ter muitos registradores gerais (ex: 32 regs genéricos + extras), enquanto ISAs CISC como x86 possuem menos registradores visíveis (8 ou 16 registradores).

**3. Formatos de Instrução**
* **Resposta:** A instrução `addiu` (Adição com dado imediato) no MIPS é convertida num formato que possui, entre seus campos, o `opcode` (código de operação de 6 bits), referências aos registradores fonte (`rs`) e destino (`rt`), e o campo de imediato (`imm`, com 16 bits para armazenar o valor da constante -32 em complemento de 2). A finalidade do campo `opcode` é informar ao hardware de controle qual é a instrução específica a ser executada (neste caso, uma adição imediata).

**4. Modos de Endereçamento**
* **Resposta:** Modos de Endereçamento definem "a forma como o processador localiza ou recupera cada operando de uma instrução". Na instrução `lw $t0, 4($s0)`, existem dois modos de endereçamento:
    - **Modo a Registrador:** no operando `$t0` (que será o destino do dado carregado).
    - **Modo Base-Deslocamento:** nos operandos `4($s0)`. O registrador base `$s0` aponta para um endereço e a constante `4` (deslocamento) é somada a esse endereço dentro do processador para localizar a posição final na memória.

**5. Modelo de Acesso à Memória**
* **Resposta:**
    - **Sinais de Endereço:** Enviam à memória a localização exata (índice) da palavra que se deseja acessar.
    - **Sinais de Operação (Controle/RW):** Informam à memória o tipo de operação, ou seja, se o processador deseja Ler (Read/Load) ou Escrever (Write/Store) naquele endereço.
    - **Sinais de Dados:** São os fios pelos quais a informação trafega. Em um *Load*, o dado lido viaja da memória para o processador através desses fios.

---

## Parte 2: Interpretação de Código MIPS

**6. Interpretação de Funções Condicionais**
* **Resposta a):** Os registradores de entrada no MIPS são `$a0, $a1, $a2, $a3` (nesta função são usados `$a0` e `$a1`). O valor de retorno é guardado em `$v0`.
* **Resposta b):** A função compara se `$a1` é menor que `$a0` (`slt $t0, $a1, $a0`). Se for menor, `$t0` recebe 1, caso contrário, 0. Em seguida, verifica se `$t0` é zero (`beq $t0, $zero, else`). Se for zero (ou seja, `$a1 >= $a0`), ele pula para o bloco `else` e retorna `$a1` em `$v0`. Se não for zero (ou seja, `$a0 > $a1`), não pula, atribui `$a0` a `$v0` e salta para o fim. Em resumo, a função calcula e retorna o valor máximo (o maior) entre os dois parâmetros informados.

**7. Estruturas de Repetição (Loop) e Lógica**
* **Resposta a):** As instruções efetuam a atualização dos valores da sequência de Fibonacci. A primeira instrução soma o valor anterior (`$t1`) com o atual (`$t2`), guardando no registrador temporário `$t3` (o próximo elemento). Em seguida, atualizam-se os registradores: o "anterior" passa a ser o valor "atual", e o "atual" passa a ser o "próximo" (calculado em `$t3`).
* **Resposta b):** O registrador `$t7` atua como o contador de iterações do laço. A instrução `bgtz $t7, loop` verifica se o valor em `$t7` é "maior que zero" (*branch if greater than zero*). Enquanto for positivo, o laço continua; se atingir zero (ou menos), o laço é encerrado.

**8. Cálculos em Laço**
* **Resposta a):** A instrução `mul $t1, $t0, $t0` calcula o quadrado do valor atual de `$t0` ($t0 \times t0$) e armazena o resultado em `$t1`.
* **Resposta b):** O loop está buscando a raiz quadrada inteira de `$a2` ($a^2 + b^2$), que é equivalente ao comprimento da hipotenusa. Ele faz isso incrementando `$t0` de 1 em 1 e checando se o quadrado de `$t0` (`$t1`) atingiu ou ultrapassou o valor de `$a2` (`bge $t1, $a2, fim`). Ao alcançar o rótulo `fim`, `$t0` conterá a raiz quadrada aproximada (ou exata) da soma dos quadrados dos catetos, representando a hipotenusa inteira.

---

## Parte 3: Microcontrolador MSP430

**9. Arquitetura do MSP430**
* **Resposta a):** Um espaço de memória unificado significa que todos os endereços da máquina pertencem a um único mapa lógico. A CPU pode ler um dado na RAM, buscar uma instrução na memória Flash ou alterar a configuração de um periférico (Portas I/O, Timers) usando as mesmas instruções (como `mov`), bastando informar os endereços corretos daquele mapa contínuo, sem a necessidade de comandos especiais (como *in* ou *out*).
* **Resposta b):** Na arquitetura Harvard, existem memórias físicas e barramentos separados para os Dados e para as Instruções, permitindo que ambos sejam acessados paralelamente. Na arquitetura Von Neumann (usada no MSP430), instruções e dados dividem o mesmo espaço de endereçamento e os mesmos barramentos de comunicação com o processador.
