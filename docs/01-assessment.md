# 01 — Assessment e planejamento

## Contexto
O desafio da Escola da Nuvem propõe construir, em três dias, uma aplicação web de três camadas na AWS, com recebimento e processamento desacoplados. Este repositório organiza o laboratório como estudo de caso de System Design.

## Objetivos
- Separar apresentação, processamento e persistência.
- Distribuir componentes elegíveis entre Zonas de Disponibilidade.
- Desacoplar entrada e processamento com Amazon SQS.
- Persistir registros no Amazon DynamoDB.
- Evoluir segurança, gestão de configuração e acesso operacional.
- Adicionar observabilidade, alertas e escalabilidade orientada por backlog.

## Requisitos e critérios de validação

| Requisito | Critério | Evidência esperada |
|---|---|---|
| Alta disponibilidade | Componentes distribuídos entre AZs e alvos saudáveis | Sub-redes, ASG e Target Group |
| Segurança de rede | Backend sem exposição direta desnecessária | Security Groups e rotas |
| Gestão de configuração | Aplicação consulta Parameter Store | Parâmetros e configuração sanitizada |
| Desacoplamento | Frontend publica e workers consomem mensagens | Teste de envio e processamento |
| Persistência | Registro processado aparece no DynamoDB | Consulta pelo requestId |
| Resiliência | Mensagens com falha podem seguir para DLQ | Redrive policy e teste controlado |
| Observabilidade | Métricas e alarmes cobrem ALB, ASG e SQS | Dashboard e alarmes |
| Custos | Recursos relevantes e custos identificados | Estimativa ou relatório com período |

## Premissas e limites
- Região registrada no README anterior: us-east-2. Confirmar nas evidências antes de tratar como baseline final.
- Topologia, nomes e configurações devem ser confirmados por etapa.
- Um componente desenhado não é automaticamente um componente implementado ou validado.
- Não publicar credenciais, tokens, IDs de conta, parâmetros sensíveis ou dados pessoais.
- O laboratório educacional não deve ser descrito como ambiente de produção.

Migração de legado, homologação com áreas de negócio e pipelines corporativos não são requisitos comprovados pelo material do desafio; podem ser registrados como evolução futura.

## Estados oficiais da documentação
- Planejado: previsto no roteiro ou desenho.
- Implementado: configurado no ambiente.
- Validado: existe teste e evidência reproduzível.
- Não validado: há registro, mas evidência insuficiente.
- Melhoria proposta: recomendação ainda não executada.
