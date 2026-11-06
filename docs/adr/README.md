# Architecture Decision Records (ADRs)

ADRs registram decisões que afetam a arquitetura. Convenção: ADR-NNN-titulo.md.

## Modelo
- Status: Proposta | Aceita | Rejeitada | Substituída
- Data:
- Contexto: problema e restrições.
- Decisão: opção escolhida e justificativa.
- Alternativas: opções consideradas.
- Consequências: benefícios, custos e riscos.
- Evidências: links para configuração, código, teste ou documentação.

## Decisões candidatas
- ADR-001 — Usar SQS para desacoplar recepção e processamento.
- ADR-002 — Usar DynamoDB para persistência.
- ADR-003 — Distribuir componentes entre AZs.
- ADR-004 — Usar Parameter Store para centralizar parâmetros.
- ADR-005 — Usar Session Manager em vez de expor SSH.
- ADR-006 — Escalar workers por backlog.

Criar ADRs individuais após confirmar contexto e decisão realmente adotada no laboratório.
