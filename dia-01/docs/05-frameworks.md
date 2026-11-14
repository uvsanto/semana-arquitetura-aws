# 05 · Frameworks: aderência e maturidade

> Autoavaliação honesta. Percentuais só aparecem onde há critérios verificáveis. Declarar "conformidade total" ou um percentual sem critério seria afirmar o que não foi demonstrado.

## AWS Well-Architected Framework

Maturidade por pilar com base nos critérios do [scorecard](04-saa-c03-scorecard.md) e nas evidências. Atualize ao confirmar cada dia.

| Pilar | O que a solução faz | Lacuna | Nível |
|---|---|---|---|
| Excelência operacional | Dashboard, alarmes, Game Day (Dia 3) | Sem runbooks, sem IaC | Parcial |
| Segurança | Sub-redes privadas, SG encadeado, Instance Profile, Parameter Store, Session Manager | `FullAccess` no IAM, HTTP sem TLS, sem WAF | Parcial |
| Confiabilidade | Multi-AZ, SQS, ASG, DLQ | Sem backup/PITR; falha de região não coberta | Parcial |
| Eficiência de performance | Long polling, CloudFront, escala por backlog | Sem teste de carga medido | Parcial |
| Otimização de custos | Instâncias pequenas, escala elástica, Cost Anomaly Detection | Sem estimativa; NAT Gateway de custo fixo | Inicial |
| Sustentabilidade | Escala elástica reduz capacidade ociosa | Sem análise específica | Inicial |

Legenda: **Inicial** = poucas práticas · **Parcial** = práticas principais, com lacunas conhecidas · **Adequado** = sem lacunas relevantes para o escopo.

## LGPD

**Não declaro conformidade.** O projeto é um laboratório sem dados reais de titulares. Mesmo assim, o formulário aceita texto livre, que poderia conter dados pessoais. Considerações para uma versão de produção:

| Princípio / requisito | Situação no laboratório | O que faria |
|---|---|---|
| Finalidade e necessidade | Não definidas (texto livre) | Definir quais dados coletar e por quê |
| Segurança | Sub-redes privadas, IAM; sem TLS ponta a ponta | HTTPS, criptografia em repouso (KMS), menor privilégio |
| Retenção | Dados guardados indefinidamente | TTL no DynamoDB conforme a finalidade |
| Direitos do titular | Não tratados | Processo para consulta e eliminação |
| Registro de acesso | Não configurado | CloudTrail e logs de acesso |

Por isso, **retire "conformidade com a LGPD" do README** e use "considerações de privacidade (LGPD)".

## AWS Cloud Adoption Framework (CAF)

O CAF trata de adoção de nuvem em nível organizacional (perspectivas de negócio, pessoas, governança, plataforma, segurança e operações). Um laboratório individual **não adota o CAF**. O que cabe dizer é que o projeto exercita, em pequena escala, as perspectivas de **Plataforma**, **Segurança** e **Operações**. Não atribuo percentual de maturidade.

## Operação, monitoramento e FinOps

| Prática | Situação |
|---|---|
| Painel unificado (ALB, ASG, SQS) | Dia 3 |
| Alertas por e-mail (SNS) | Dia 3 |
| Detecção de anomalia de custo | Dia 3 |
| Estimativa e custo real documentados | **Lacuna** |
| Teardown após ordem do professor | **Pendente** |
