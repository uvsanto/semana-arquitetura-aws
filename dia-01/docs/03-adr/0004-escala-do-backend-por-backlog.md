# ADR-0004: Escalar o backend pelo backlog da fila, não pela CPU

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** 3

## Contexto
No Dia 2 o backend escala por CPU média em 60% (mínimo 1, máximo 2). O backend é um consumidor de fila. A CPU pode estar baixa enquanto a fila cresce (por exemplo, se o trabalho espera I/O), então a CPU não reflete a demanda real.

## Opções consideradas
1. **Escala por CPU**: simples, mas indireta.
2. **Escala por profundidade da fila**: reage ao trabalho pendente, porém não considera quantas instâncias já existem.
3. **Backlog por instância** (mensagens visíveis ÷ instâncias em serviço): reflete a carga por trabalhador.

## Decisão
Política de escala baseada em backlog por instância.

## Consequências
- ✅ Escala proporcional ao trabalho acumulado.
- ⚠️ Exige métrica personalizada e testes de carga para calibrar a meta.
- 🔧 Medir e registrar no Game Day o tempo entre o crescimento da fila e a entrada de novas instâncias.

## Pilar / Domínio
Eficiência de performance, Custo · Domínios 3 e 4
