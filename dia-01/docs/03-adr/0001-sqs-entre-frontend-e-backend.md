# ADR-0001: Amazon SQS entre frontend e backend

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** 1

## Contexto
O frontend recebe requisições dos usuários e o backend as processa e grava. Se o frontend chamasse o backend diretamente, uma lentidão ou queda do backend se propagaria ao usuário (efeito dominó).

## Opções consideradas
1. **Chamada HTTP direta** frontend → backend: simples, mas acopla disponibilidade e desempenho das duas camadas.
2. **SQS (fila padrão)**: o frontend publica e responde de imediato; o backend consome no seu ritmo.
3. **Kinesis / SNS + SQS**: mais capacidade ou fan-out, desnecessário para este volume.

## Decisão
SQS fila padrão. O consumidor usa *long polling* (20 s) para reduzir chamadas vazias e só apaga a mensagem após gravar no DynamoDB.

## Consequências
- ✅ Absorve picos; o backend pode ficar fora do ar sem perder mensagens.
- ⚠️ Entrega *at-least-once* e sem ordem garantida: o backend precisa tolerar duplicatas (o `requestId` como chave torna a gravação idempotente).
- ⚠️ Sem DLQ no Dia 1, uma mensagem com erro reaparece até expirar (resolvido no Dia 2).

## Pilar / Domínio
Confiabilidade · Domínio 2 (Resiliente)
