# 3

0x00400010: j label (endereço de label: 0x00400000)

J e JAL: Endereço Alvo = ( (PC + 4) AND 0xF0000000 ) + (Imediato * 4)
 
### Cálculo do endereço alvo de 32 bits
   - PC Atual = `0x00400010`
   - PC+4 = `0x00400014`
   - Em binário (32 bits): `0000 0000 0100 0000 0000 0000 0001 0100`
   - 4 bits superiores: `0000`

   - O valor na instrução para chegar em `0x00400000` é `0x0100000`.
   - Em binário (26 bits): `00000001000000000000000000`

   - Adicionamos `00` ao final, resultando em 28 bits:
   - `0000000100000000000000000000`

   - Juntamos os 4 bits superiores de PC+4 com o valor deslocado.
   - `0000` + `0000 0100 0000 0000 0000 0000 0000`
   - Binário final (32 bits): `0000 0000 0100 0000 0000 0000 0000 0000`



