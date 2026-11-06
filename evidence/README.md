# Evidências técnicas

Reunir evidências reais da execução. Não inserir credenciais, tokens, IDs de conta, dados pessoais ou informações que exponham o ambiente.

## Organização
- day-01/: rede, ALB, EC2, SQS e DynamoDB.
- day-02/: Parameter Store, IAM, Session Manager, Launch Templates, ASG, CloudFront e DLQ.
- day-03/: dashboards, alarmes, SNS, escalabilidade e recuperação.
- errors/: erros observados, diagnóstico e correção.
- tests/: plano, procedimento, resultado e limitações.

## Modelo de evidência
| Campo | Conteúdo |
|---|---|
| ID | EV-001 |
| Data | AAAA-MM-DD |
| Etapa | Dia 1, 2 ou 3 |
| Requisito | Ex.: persistência no DynamoDB |
| Procedimento | Passos executados |
| Resultado esperado | Comportamento esperado |
| Resultado observado | O que ocorreu |
| Status | Planejado / Implementado / Validado / Não validado |
| Arquivo | Captura ou log sanitizado |

## Troubleshooting
Registrar sintoma, mensagem literal se disponível, impacto, hipóteses, verificações, causa raiz (ou estado desconhecido), correção, reteste e aprendizado.

Se não houver print, registrar como relato retrospectivo. Não recriar capturas ou logs como se fossem evidências originais.
