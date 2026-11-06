# 04 — Frameworks, governança e otimização

## AWS Well-Architected Framework
Avaliar os seis pilares sem declarar conformidade integral apenas por utilizar serviços AWS.

| Pilar | Aspectos a avaliar | Evidência necessária |
|---|---|---|
| Excelência operacional | Procedimentos, logs, alarmes e troubleshooting | Runbook, logs e alarmes testados |
| Segurança | IAM, segmentação, criptografia e acesso | Políticas, Security Groups e configurações |
| Confiabilidade | Multi-AZ, filas, DLQ e recuperação | Testes de falha e recuperação |
| Eficiência de desempenho | Balanceamento, escala, filas e banco | Métricas e testes |
| Otimização de custos | NAT Gateway, EC2, armazenamento e tráfego | Estimativa e análise |
| Sustentabilidade | Dimensionamento e recursos ociosos | Justificativa de capacidade |

## AWS Cloud Adoption Framework
O CAF é uma referência de transformação organizacional. Neste laboratório individual, usar como lente de reflexão, não como avaliação formal de prontidão empresarial. Registrar observações sobre negócio, pessoas, governança, plataforma, segurança e operações somente quando houver conteúdo real.

## LGPD
Não declarar conformidade jurídica. Para este laboratório:
- Evitar dados pessoais reais nos testes e capturas.
- Não publicar credenciais, tokens ou identificadores sensíveis.
- Documentar finalidade, minimização, retenção e acesso caso dados pessoais sejam utilizados.
- Reconhecer que conformidade depende de contexto e processos além deste laboratório.

## FinOps
Avaliar EC2/ASG, NAT Gateway, ALB, CloudFront, SQS, DynamoDB e CloudWatch, registrando período, região e premissas. Cost Anomaly Detection identifica padrões incomuns de gasto; não substitui orçamento ou análise de custo unitário.

## Maturidade
Usar estados: Não avaliado; Planejado; Parcialmente implementado; Implementado; Validado com evidência. Não converter estados em percentuais sem metodologia explícita.
