# 🏗️ Dia 01 — Construindo a Solução: Arquitetura em 3 Camadas com Desacoplamento Assíncrono

[⬅️ Voltar para a Página Principal](../README.md) | [Avançar para o Dia 02: Evoluindo a Arquitetura ➡️](../dia-02/README.md)

---

## 🎯 Descrição e Objetivo Pedagógico da Etapa

No **Dia 01**, construímos a fundação de uma aplicação web corporativa dividida em **3 níveis (Apresentação, Processamento/Mensageria e Banco de Dados)**. 

**Como funciona na prática:** 
Em vez de fazer o servidor do site gravar os dados diretamente no banco de dados (o que travaria o site caso o banco ficasse lento ou recebesse milhares de acessos simultâneos), colocamos uma fila do **Amazon SQS** no meio do caminho. O site apenas deposita o pedido na fila e responde imediatamente ao cliente. Em outra camada isolada, servidores de **Backend** leem essa fila continuamente e salvam os registros no **Amazon DynamoDB**. Esse padrão de **acoplamento fraco** garante que uma falha em uma parte do sistema jamais derrube as demais.

---

## 📐 Topologia da Arquitetura — Cenário Dia 01

```mermaid
flowchart LR
    User(["👤 Usuário Externo"]) -->|HTTP :80| ALB["⚖️ ALB Público\n(projeto-alb-vagner-toma)\nus-east-2a / 2b"]

    subgraph PrivateWeb ["Sub-redes Privadas Web"]
        FE1["💻 EC2 Frontend 1\n(AZ: us-east-2b)\nIP: 10.0.151.X"]
        FE2["💻 EC2 Frontend 2\n(AZ: us-east-2a)\nIP: 10.0.138.X"]
    end

    subgraph Buffer ["Camada de Desacoplamento"]
        SQS[("📬 Amazon SQS\nfila-registros-vagner-tomaz")]
    end

    subgraph PrivateApp ["Sub-redes Privadas Backend"]
        BE1["⚙️ EC2 Backend 1\n(AZ: us-east-2a)\nWorker systemd"]
        BE2["⚙️ EC2 Backend 2\n(AZ: us-east-2b)\nWorker systemd"]
    end

    subgraph Database ["Camada de Dados"]
        DDB[("🗄️ Amazon DynamoDB\ntabela-registros-vagner-tomaz\nPK: requestId")]
    end

    ALB -->|Target Group: Porta 80| FE1
    ALB -->|Target Group: Porta 80| FE2
    FE1 -->|SendMessage JSON| SQS
    FE2 -->|SendMessage JSON| SQS
    SQS -->|ReceiveMessage (Long Polling 20s)| BE1
    SQS -->|ReceiveMessage (Long Polling 20s)| BE2
    BE1 -->|PutItem| DDB
    BE2 -->|PutItem| DDB
```

---

## 🌐 Topologia e Endereçamento de Rede (VPC & Sub-redes)

A infraestrutura utiliza a VPC `projeto-vpc` (`10.0.0.0/16`) na região `us-east-2` (Ohio), dividida estrategicamente em 6 sub-redes distribuídas em duas Zonas de Disponibilidade:

| Nome da Sub-rede | Zona (AZ) | Tipo de Rede | Rota de Saída Padrão (`0.0.0.0/0`) | Recursos Alocados na Sub-rede |
| :--- | :---: | :---: | :--- | :--- |
| **Sub-rede Pública 1** | `us-east-2a` | Pública | Internet Gateway (`IGW`) | Nó do Application Load Balancer + NAT Gateway A |
| **Sub-rede Pública 2** | `us-east-2b` | Pública | Internet Gateway (`IGW`) | Nó do Application Load Balancer + NAT Gateway B |
| **Sub-rede Privada 1** | `us-east-2a` | Privada (Web) | NAT Gateway A | Instância EC2 `frontend2-vagner-tomaz` |
| **Sub-rede Privada 2** | `us-east-2b` | Privada (Web) | NAT Gateway B | Instância EC2 `frontend1-vagner-tomaz` |
| **Sub-rede Privada 3** | `us-east-2a` | Privada (App) | NAT Gateway A | Instância EC2 `backend1-vagner-tomaz` |
| **Sub-rede Privada 4** | `us-east-2b` | Privada (App) | NAT Gateway B | Instância EC2 `backend2-vagner-tomaz` |

---

## 🛠️ Tecnologias AWS Utilizadas nesta Etapa e Glossário Técnico

| Serviço / Recurso | Função Prática no Dia 01 | Conceito de Glossário (O que é?) |
| :--- | :--- | :--- |
| **Amazon VPC** | Isola os servidores em sub-redes privadas sem exposição direta à internet. | Rede virtual privada e logicamente isolada dentro da nuvem AWS. |
| **NAT Gateway** | Permite que as EC2 privadas instalem `python3`, `flask` e `boto3` via internet. | Tradutor de endereços que permite saída para a internet bloqueando conexões de entrada. |
| **Security Groups** | Filtra o tráfego: as EC2 só aceitam requisições vindas do Load Balancer. | Firewall virtual *stateful* que opera no nível da interface de rede da instância. |
| **AWS IAM Role** | Autoriza as EC2 a acessarem o SQS e o DynamoDB sem usar senhas fixas no código. | Identidade com permissões temporárias assumidas automaticamente por serviços AWS. |
| **Application Load Balancer** | Ponto único de entrada (`DNS público`) que divide os acessos entre as duas AZs. | Balanceador de carga que opera na Camada 7 (HTTP/HTTPS) do modelo OSI. |
| **Target Group** | Verifica a cada 10 segundos se o site Flask nas EC2 está respondendo (`HTTP 200`). | Grupo lógico de alvos monitorados continuamente por sondas de integridade (*Health Checks*). |
| **Amazon EC2 (User Data)** | Hospeda o site em Flask (Frontend) e o script consumidor em Python (Backend). | Máquinas virtuais na nuvem configuradas automaticamente no boot via script shell. |
| **Amazon SQS** | Armazena as mensagens enviadas pelo site até que o backend possa processá-las. | Fila de mensagens gerenciada para desacoplar microsserviços e sistemas distribuídos. |
| **Amazon DynamoDB** | Armazena definitivamente cada mensagem junto com o horário de recebimento e gravação. | Banco de dados NoSQL chave-valor totalmente gerenciado de altíssima performance. |

---

## 🤔 Decisão Arquitetural: Por que não utilizar IaC (Terraform, CloudFormation ou Kiro) nesta etapa?

Uma dúvida comum em portfólios de arquitetura é o motivo de realizar o provisionamento inicial via Console AWS e scripts *User Data* em vez de partir diretamente para **Terraform**, **AWS CloudFormation** ou **Kiro**:

1. **Compreensão Profunda dos Fundamentos (Anatomia dos Serviços):** A construção passo a passo no Dia 01 evidencia dependências reais de rede e segurança — como o encadeamento de IDs de Security Groups, associação de tabelas de rotas aos NAT Gateways e propagação de IAM Instance Profiles — que ferramentas de IaC abstraem.
2. **Diagnóstico e Troubleshooting de Base:** Entender exatamente onde um *Health Check* falha ou por que um *User Data* não encontra um pacote no Linux constrói a bagagem necessária para escrever módulos Terraform limpos no futuro.
3. **Evolução Planejada:** A codificação em Terraform consta mapeada no backlog de evolução do projeto após a validação empírica das três fases operacionais.

---

## 🩺 Registro de Troubleshooting e Dificuldades Superadas (Controle de Qualidade)

Durante a implementação e validação do Dia 01, os seguintes desafios técnicos foram diagnosticados e solucionados:

| Ponto de Atenção / Erro | Sintoma Observado | Diagnóstico da Causa Raiz | Solução Aplicada |
| :--- | :--- | :--- | :--- |
| **1. Alvos no Target Group em estado `Unhealthy`** | O ALB retornava erro `502 Bad Gateway` ou `503 Service Unavailable` logo após criar as EC2. | O script *User Data* ainda estava instalando os pacotes `pip` (Flask/Boto3) ou o Security Group das EC2 bloqueava a sonda do ALB. | Aguardado o término do bootstrap (`systemd`) e validada a regra de entrada no `ec2-sg-vagner-tomaz` liberando a porta `80` para a origem `loadbalancer-sg-vagner-tomaz`. |
| **2. Instâncias Privadas sem acesso aos repositórios Linux (`dnf`/`pip`)** | O script de inicialização travava ao tentar baixar o Flask na sub-rede privada. | Sub-redes privadas não possuem rota direta para o Internet Gateway. | Verificada a tabela de rotas das sub-redes privadas garantindo o apontamento do destino `0.0.0.0/0` para o **NAT Gateway** situado na sub-rede pública. |
| **3. Falha de comunicação com SQS / DynamoDB por Região ou URL** | O Frontend apresentava erro ao submeter o formulário ou o Worker não encontrava a fila. | Divergência entre a região configurada no cliente `boto3` (`us-east-2`) e a URL da fila SQS copiada no script. | Padronização explícita de `REGION = "us-east-2"` e revisão da URL exata da `fila-registros-vagner-tomaz` e `tabela-registros-vagner-tomaz`. |
| **4. Mensagens processadas mas não removidas da fila** | O item aparecia no DynamoDB, porém voltava a ser processado após o *Visibility Timeout*. | Necessidade de executar explicitamente o método `sqs.delete_message()` passando o `ReceiptHandle` após o `put_item`. | Confirmação do bloco `try/except` no script do `worker.py` garantindo a exclusão imediata após confirmação de gravação no banco. |

---

## ✅ Checklist de Validação e Evidências do Dia 01

- [x] **Tabela DynamoDB:** `tabela-registros-vagner-tomaz` ativa no modo *On-Demand* com chave `requestId`.
- [x] **Fila SQS:** `fila-registros-vagner-tomaz` criada com *Long Polling* de 20s validado nos consumidores.
- [x] **Isolamento de Segurança:** `ec2-sg-vagner-tomaz` aceitando tráfego HTTP unicamente do `loadbalancer-sg-vagner-tomaz`.
- [x] **IAM Instance Profile:** Role `ec2-role-vagner-tomaz` anexada às 4 instâncias EC2 sem uso de Access Keys no código.
- [x] **Alta Disponibilidade Frontend:** `frontend1` (`us-east-2b`) e `frontend2` (`us-east-2a`) operacionais e **Healthy** no Target Group.
- [x] **Processamento Assíncrono Backend:** `backend1` e `backend2` executando `worker.service` no `systemd` e persistindo no DynamoDB.

---

## 🚀 O que Pode Ser Melhorado? (Gatilhos para o Dia 02)

Apesar de funcional e desacoplada, a arquitetura do Dia 01 possui **três vulnerabilidades operacionais** que serão resolvidas no **Dia 02**:
1. **Informações Sensíveis no Código (*Hardcoded*):** A URL da fila SQS e o nome da tabela do DynamoDB estão escritos diretamente dentro dos scripts Python das instâncias.
2. **Baixa Manutenibilidade:** Se o nome da fila ou da tabela mudar, seria necessário acessar manualmente todas as máquinas ou recriá-las para atualizar o script.
3. **Ausência de Autorrecuperação (*Self-Healing*) e Elasticidade:** As 4 instâncias EC2 foram criadas manualmente. Se uma máquina travar ou se uma Zona inteira cair, nenhuma nova instância sobe sozinha para repor a capacidade.

👉 **[Clique aqui para avançar para o Dia 02: Evoluindo a Arquitetura com Parameter Store e Auto Scaling ➡️](../dia-02/README.md)**

## 🎯 Alinhamento com a Certificação AWS SAA-C03

* **Domínio 1: Arquiteturas Seguras (30%):** Encadeamento de Security Groups (*Zero Direct Access*), sub-redes privadas e gestão centralizada de parâmetros via SSM sem credenciais estáticas[cite: 5, 20, 27, 32].
* **Domínio 2: Arquiteturas Resilientes (26%):** Distribuição Multi-AZ (`us-east-2a` e `us-east-2b`), absorção de rajadas com Amazon SQS e recuperação automática com Auto Scaling[cite: 4, 18, 27, 28, 32].
* **Domínio 3: Arquiteturas de Alto Desempenho (24%):** Balanceamento na Camada 7 via ALB, processamento via Long Polling e leitura/escrita em milissegundos no DynamoDB[cite: 4, 5, 22, 29, 32].
* **Domínio 4: Arquiteturas com Custo Otimizado (20%):** Elasticidade sob demanda, DynamoDB On-Demand e dimensionamento fino de recursos computacionais[cite: 5, 29, 32].


🏛️ Dia 01: Arquitetura em 3 Camadas com Desacoplamento Assíncrono

## 🎯 Objetivo do Dia
Implementar a fundação da arquitetura corporativa de 3 camadas na AWS para hospedar uma aplicação web simples, desacoplando o recebimento de dados da persistência final para suportar workloads legados ou de processamento demorado.

---

## 📐 Topologia Implementada

```text
[ Usuário / Internet ]
         │ (HTTP :80)
         ▼
[ Application Load Balancer ] (Público / Multi-AZ)
         │
    ┌────┴────────────────────────┐
    ▼                             ▼
[ EC2: Frontend 1 ]         [ EC2: Frontend 2 ] (Sub-redes Privadas)
(AZ: us-east-2b)            (AZ: us-east-2a)
    │                             │
    └────┬────────────────────────┘
         │ (JSON com UUID + Payload)
         ▼
[ Amazon SQS: Fila Padrão ] (Buffer Assíncrono)
         │
    ┌────┴────────────────────────┐
    ▼                             ▼
[ EC2: Worker Backend 1 ]   [ EC2: Worker Backend 2 ] (Sub-redes Privadas)
(Consumo Long Polling)       (Consumo Long Polling)
    │                             │
    └────┬────────────────────────┘
         │ (Gravação NoSQL)
         ▼
[ Amazon DynamoDB ] (Tabela Sob Demanda)
```

---

## 🛠️ Recursos Provisionados e Configurados

* **Rede:** VPC `projeto-vpc` (`10.0.0.0/16`) em `us-east-2` com 2 sub-redes públicas e 4 privadas Multi-AZ (`us-east-2a` e `us-east-2b`), Internet Gateway e NAT Gateway[cite: 5, 17, 18, 21].
* **Segurança:** 
  * `loadbalancer-sg-vagner-tomaz`: porta 80 pública.
  * `ec2-sg-vagner-tomaz`: porta 80 restrita exclusivamente ao Security Group do ALB[cite: 5, 20].
  * `ec2-role-vagner-tomaz`: IAM Role anexada às instâncias EC2 com permissões para SQS e DynamoDB sem chaves estáticas[cite: 5, 24].
* **Apresentação:** 2 instâncias EC2 rodando aplicação Python Flask via *User Data* atrás de um Application Load Balancer (`projeto-alb-vagner-toma`)[cite: 5, 18, 22].
* **Mensageria:** Fila padrão `fila-registros-vagner-tomaz` (SQS) absorvendo mensagens assíncronas[cite: 5, 28].
* **Processamento:** 2 instâncias EC2 de backend com serviços `systemd` consumindo a fila via *Long Polling* (20s)[cite: 5, 18].
* **Persistência:** Tabela `tabela-registros-vagner-tomaz` (DynamoDB) gravando dados com eficiência de 100%[cite: 5, 20, 29, 30].

---

## ⚠️ Diagnóstico e Débitos Técnicos Identificados 

Ao final do Dia 01, foram apontados três débitos técnicos críticos para a sustentação corporativa da aplicação:
1. **Configurações Hardcoded:** A URL da fila SQS e o nome da tabela DynamoDB estão gravados diretamente no script de aplicação das instâncias.
2. **Falta de Agilidade Operacional:** Alterar qualquer recurso exige login manual em cada EC2 e recriação do código.
3. **Ausência de Auto-Healing:** Se uma instância sofrer falha de hardware, pane de software ou sobrecarga, a arquitetura atual não provisiona um novo nó automaticamente[cite: 5].

> 📌 *Esses problemas serão solucionados no [Dia 02](../dia-02/README.md) utilizando AWS Systems Manager Parameter Store e Auto Scaling Groups.*



## 📐 Topologia Macro da Arquitetura (Mermaid.js)

```mermaid
flowchart TD
    subgraph Internet ["🌐 Borda Externa"]
        User(["👤 Clientes / Usuários"])
    end

    subgraph VPC ["AWS Cloud - VPC Multi-AZ (10.0.0.0/16)"]
        subgraph PublicSubnets ["Sub-redes Públicas (AZ A & AZ B)"]
            ALB["⚖️ Application Load Balancer (ALB)"]
            NAT["🚪 NAT Gateways"]
        end

        subgraph PrivateWeb ["Sub-redes Privadas: Apresentação"]
            ASG_Web["💻 Auto Scaling Group (Frontend Flask)"]
        end

        subgraph Messaging ["Camada de Buffer & Desacoplamento"]
            SQS[("📬 Amazon SQS (Fila de Ingestão)")]
            DLQ[("🛑 Dead Letter Queue (DLQ)")]
            SQS -.->|Falhas Repetidas| DLQ
        end

        subgraph PrivateApp ["Sub-redes Privadas: Processamento"]
            ASG_Back["⚙️ Auto Scaling Group (Workers Backend)"]
        end

        subgraph Storage ["Persistência de Dados & Governança"]
            DDB[("🗄️ Amazon DynamoDB (On-Demand)")]
            SSM["🔐 AWS Systems Manager (Parameter Store)"]
            CW["📈 Amazon CloudWatch (Dashboards & Alarmes)"]
        end
    end

    User -->|HTTP :80| ALB
    ALB -->|Zero Direct Access| ASG_Web
    ASG_Web -->|Mensagem Assíncrona com UUID| SQS
    SQS -->|Long Polling 20s| ASG_Back
    ASG_Back -->|Gravação NoSQL| DDB
    ASG_Web -.->|Busca Parâmetros| SSM
    ASG_Back -.->|Busca Parâmetros| SSM
    ASG_Back -.->|Métricas| CW
    PrivateWeb -.->|Tráfego de Saída| NAT
    PrivateApp -.->|Tráfego de Saída| NAT