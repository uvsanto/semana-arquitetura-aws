# 01 · Assessment: requisitos, métricas e baseline

> Este é um laboratório guiado. Os requisitos abaixo são **premissas de estudo** derivadas do cenário do curso, não de um cliente real.

## Cenário

Hospedar uma aplicação web de 3 camadas (frontend, backend e banco de dados) que receba e processe requisições de usuários de forma desacoplada, sem que a falha de uma parte comprometa o todo.

## Requisitos funcionais

| ID | Requisito |
|---|---|
| RF-01 | O usuário envia um texto por um formulário web e recebe confirmação imediata com um identificador (`requestId`) |
| RF-02 | A requisição é processada de forma assíncrona e persistida a longo prazo |

## Requisitos não funcionais

| ID | Requisito | Dia em que é atendido | Como verifico |
|---|---|---|---|
| RNF-01 | Frontend e backend em 2 Zonas de Disponibilidade | 1 | Target group *healthy* em AZs distintas |
| RNF-02 | Falha de uma camada não derruba as demais | 1 | Mensagens ficam na fila com o backend parado |
| RNF-03 | Nenhuma instância com IP público; só o ALB exposto | 1 | Configuração das instâncias e dos SGs |
| RNF-04 | Sem configuração fixa no código | 2 | Parâmetros no Parameter Store |
| RNF-05 | Acesso às instâncias sem abrir SSH | 2 | Session Manager |
| RNF-06 | Instância com falha é substituída automaticamente | 2 | Encerrar instância e observar o ASG |
| RNF-07 | Nenhuma mensagem perdida em falhas de processamento | 2 | Mensagem inválida chega à DLQ |
| RNF-08 | Operação observável e com alertas | 3 | Dashboard e e-mail via SNS |
| RNF-09 | Backend escala pela fila, não por CPU | 3 | Política por backlog por instância |

## Baseline (o que já existia antes do laboratório)

O roteiro exige, como **pré-requisito**, uma VPC já criada. Portanto, **a rede não foi construída por mim**. Isso precisa ficar claro no portfólio.

| Item | Origem |
|---|---|
| VPC `projeto-vpc`, 2 sub-redes públicas e 4 privadas em 2 AZs | Fornecido pela Escola da Nuvem |
| Internet Gateway, NAT Gateway **regional** (um só) e endpoint `projeto-vpce-s3` | Fornecido pela Escola da Nuvem |
| Conta AWS com permissões restritas ao necessário | Fornecida pela Escola da Nuvem |
| Tabela DynamoDB, fila SQS, Security Groups, IAM Role, EC2, Target Group, ALB | **Criados por mim (Dia 1)** |
| Parameter Store, ASG, CloudFront, DLQ, Session Manager | **Criados por mim (Dia 2)** <!-- confirmar --> |
| Dashboard, alarmes SNS, regra do ALB, escala por backlog | **Criados por mim (Dia 3)** <!-- confirmar --> |

## Métricas de sucesso

- Nenhum erro 5xx na página durante a troca de uma instância (verificar no Game Day).
- Fila zerada após o processamento; mensagens com erro isoladas na DLQ.
- Tempo para o ASG substituir uma instância encerrada: **medir** no Dia 3 e registrar aqui. <!-- TODO -->
