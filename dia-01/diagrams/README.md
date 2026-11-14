# Diagramas

| Arquivo | Conteúdo |
|---|---|
| `architecture.mmd` | Arquitetura final (estado após o Dia 3) |
| `dia-01.mmd`, `dia-02.mmd`, `dia-03.mmd` | Arquitetura de cada etapa, para as páginas dos dias |

O GitHub renderiza Mermaid dentro do Markdown (bloco com ` ```mermaid `). Os `.mmd` são a fonte; o conteúdo é colado nos READMEs.

## Boas práticas para os diagramas visuais (draw.io)

Use o draw.io com a biblioteca oficial **AWS Architecture Icons** e refaça os desenhos você mesmo (não use os do roteiro).

1. **Hierarquia de contêineres:** Conta/Região › VPC › Zona de disponibilidade › Sub-rede. Cores e legenda seguindo o padrão AWS.
2. **Serviços regionais fora da VPC:** SQS, DynamoDB, SSM, CloudWatch e SNS ficam fora do retângulo da VPC. O que fica dentro são recursos de rede (sub-redes, ALB, EC2, NAT).
3. **Fluxo da esquerda para a direita**, com setas **numeradas** (1, 2, 3…) e uma legenda explicando cada número.
4. **Rótulos nas setas:** protocolo e ação (`HTTP 80`, `SendMessage`, `PutItem`).
5. **Uma ideia por diagrama:** um diagrama de rede, um de fluxo de dados e outro de segurança, em vez de um único diagrama sobrecarregado.
6. **Destaque o que mudou** em cada dia (cor diferente para os componentes novos).
7. **Sem dados sensíveis:** não escreva Account ID, ARN nem DNS reais.
8. Exporte em **PNG e SVG**, e guarde o `.drawio` no repositório para edição futura.
