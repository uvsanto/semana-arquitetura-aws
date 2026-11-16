# Dia 1: Construindo a base, rede e arquitetura de 3 camadas

**Em uma frase:** a infraestrutura base de rede já existia como baseline; construí a aplicação de 3 camadas desacoplada por fila, garantindo a fundação Multi-AZ.

> Laboratório da Escola da Nuvem. Roteiro e scripts do curso não estão neste repositório.

## Objetivo do dia

Estabelecer a fundação da aplicação de três camadas (Frontend, Fila e Backend) integrada a um Application Load Balancer em alta disponibilidade, estruturando os pilares de rede e computação em nuvem.

## Tecnologias AWS desta etapa e suas funções

| Serviço | Função |
|---|---|
| **Amazon VPC & Sub-redes** | Isolamento de tráfego em sub-redes públicas e privadas (Multi-AZ) |
| **Internet & NAT Gateway** | Conectividade externa e saída segura para atualizações |
| **Application Load Balancer (ALB)** | Distribuição inteligente de requisições HTTP entre as instâncias |
| **Amazon SQS** | Fila de mensagens para desacoplamento assíncrono entre camadas |
| **Amazon DynamoDB** | Persistência NoSQL gerenciada e de alta escalabilidade |
| **AWS IAM** | Controle de acesso baseado no Princípio do Menor Privilégio |

## Glossário

| Termo | Significado simples |
|---|---|
| 3-Tier (3 Camadas) | Separação lógica entre Apresentação (Web), Processamento (App) e Dados |
| Sub-rede Pública / Privada | Segmento de rede com ou sem rota direta para a internet |
| Target Group | Conjunto de instâncias de destino para o balanceador de carga |
| Desacoplamento | Independência operacional entre sistemas através de buffer (mensageria) |

## Diagrama deste cenário

```mermaid
flowchart LR
  U["Usuários"] -->|"HTTP 80"| ALB
  subgraph REG["Região us-east-2"]
    subgraph VPC["VPC projeto-vpc - 10.0.0.0/16"]
      subgraph PUB["Sub-redes públicas - AZ A e AZ B"]
        ALB["Application Load Balancer"]
      end
      NAT["NAT Gateway regional"]
      subgraph WEB["Sub-redes privadas: frontend"]
        FE1["EC2 Frontend 1 - us-east-2b"]
        FE2["EC2 Frontend 2 - us-east-2a"]
      end
      subgraph APP["Sub-redes privadas: backend"]
        BE1["EC2 Backend 1 - us-east-2a"]
        BE2["EC2 Backend 2 - us-east-2b"]
      end
    end
    SQS[["Amazon SQS - fila padrão"]]
    DDB[("Amazon DynamoDB")]
  end
  ALB --> FE1
  ALB --> FE2
  FE1 -->|"SendMessage"| SQS
  FE2 -->|"SendMessage"| SQS
  SQS -->|"long polling 20 s"| BE1
  SQS -->|"long polling 20 s"| BE2
  BE1 -->|"PutItem"| DDB
  BE2 -->|"PutItem"| DDB
  FE1 -.->|"saída"| NAT
  FE2 -.->|"saída"| NAT
  BE1 -.->|"saída"| NAT
  BE2 -.->|"saída"| NAT
