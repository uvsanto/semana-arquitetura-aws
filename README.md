# 🏛️ Semana da Arquitetura AWS: Da Fundação à Observabilidade e Auto-Recuperação

Repositório dedicado à construção, evolução e operação de uma arquitetura corporativa em 3 camadas na AWS. O projeto documenta uma esteira real de engenharia de nuvem dividida em 3 etapas progressivas: implementação de baseline, refatoração de segurança/escalabilidade e testes de resiliência com observabilidade.

---

## 🗺️ Visão Geral da Jornada Técnica

```text
  ┌─────────────────────────┐
  │   DIA 01: A Fundação    │ ➔ 3 Camadas, Multi-AZ, ALB, SQS e DynamoDB
  └───────────┬─────────────┘
              ▼
  ┌─────────────────────────┐
  │  DIA 02: O Hardening    │ ➔ SSM Parameter Store, Launch Templates e Auto Scaling
  └───────────┬─────────────┘
              ▼
  ┌─────────────────────────┐
  │  DIA 03: A Operação     │ ➔ CloudWatch Dashboards, Testes de Caos e Auto-Healing
  └─────────────────────────┘
```

---

## 📚 Módulos do Projeto

### 🔹 [Dia 01: Arquitetura em 3 Camadas Desacoplada e Resiliente](./dia-01/README.md)
* **Foco:** Criação do ambiente base, segregação de sub-redes públicas/privadas na VPC `projeto-vpc` (`us-east-2`)[cite: 5, 27].
* **Implementação:** Application Load Balancer público, camadas de Frontend (Flask) e Backend Workers em EC2 privadas, fila Amazon SQS para amortecimento de tráfego e banco NoSQL Amazon DynamoDB[cite: 4, 5, 28, 29].
* **Evidências:** 100% de persistência validada de ponta a ponta via UUIDs únicos[cite: 5, 25, 26, 30].

### 🔹 [Dia 02: Segurança com Parameter Store e Auto Scaling Group](./dia-02/README.md)
* **Foco:** Resolução de débitos técnicos de segurança e mitigação de ponto único de falha em instâncias estáticas.
* **Implementação:** 
  * Desacoplamento de parâmetros sensíveis (URL da fila e tabela DynamoDB) com **AWS Systems Manager Parameter Store**.
  * Substituição de instâncias manuais por **Launch Templates** e **Auto Scaling Groups (ASG)** com políticas de escalabilidade dinâmica e substituição automática de instâncias degradadas.

### 🔹 [Dia 03: Observabilidade, Monitoramento e Engenharia do Caos](./dia-03/README.md)
* **Foco:** Operação da arquitetura sob estresse e validação empírica de autorrecuperação (*Self-Healing*).
* **Implementação:** Painéis unificados no **Amazon CloudWatch**, alarmes com métricas de profundidade de fila e injeção deliberada de falhas (derrubada manual de instâncias e sobrecarga de CPU) para auditoria de comportamento autônomo.

---

## 🎯 Alinhamento com a Certificação AWS SAA-C03

* **Domínio 1: Arquiteturas Seguras (30%):** Encadeamento de Security Groups (*Zero Direct Access*), sub-redes privadas e gestão centralizada de parâmetros via SSM sem credenciais estáticas[cite: 5, 20, 27, 32].
* **Domínio 2: Arquiteturas Resilientes (26%):** Distribuição Multi-AZ (`us-east-2a` e `us-east-2b`), absorção de rajadas com Amazon SQS e recuperação automática com Auto Scaling[cite: 4, 18, 27, 28, 32].
* **Domínio 3: Arquiteturas de Alto Desempenho (24%):** Balanceamento na Camada 7 via ALB, processamento via Long Polling e leitura/escrita em milissegundos no DynamoDB[cite: 4, 5, 22, 29, 32].
* **Domínio 4: Arquiteturas com Custo Otimizado (20%):** Elasticidade sob demanda, DynamoDB On-Demand e dimensionamento fino de recursos computacionais[cite: 5, 29, 32].


# 🏛️ Dia 01: Arquitetura em 3 Camadas com Desacoplamento Assíncrono

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

## ⚠️ Diagnóstico e Débitos Técnicos Identificados (Gatilhos para o Dia 02)

Ao final do Dia 01, foram apontados três débitos técnicos críticos para a sustentação corporativa da aplicação:
1. **Configurações Hardcoded:** A URL da fila SQS e o nome da tabela DynamoDB estão gravados diretamente no script de aplicação das instâncias.
2. **Falta de Agilidade Operacional:** Alterar qualquer recurso exige login manual em cada EC2 e recriação do código.
3. **Ausência de Auto-Healing:** Se uma instância sofrer falha de hardware, pane de software ou sobrecarga, a arquitetura atual não provisiona um novo nó automaticamente[cite: 5].

> 📌 *Esses problemas serão solucionados no [Dia 02](../dia-02/README.md) utilizando AWS Systems Manager Parameter Store e Auto Scaling Groups.*





# 🏛️ Enterprise Cloud System Design: Arquitetura em 3 Camadas Resiliente, Elástica e Observável na AWS

Este projeto documenta o ciclo de vida completo de engenharia, governança e operação de uma arquitetura corporativa distribuída em nuvem na **AWS (Região us-east-2)**. O ambiente foi desenhado para suportar cargas de trabalho desacopladas com tolerância a falhas, aderindo aos princípios do **AWS Well-Architected Framework**, diretrizes do **AWS Cloud Adoption Framework (CAF)** e conformidade com a **LGPD**.

---

## 🗺️ Mapa da Jornada de Engenharia

| Módulo | Escopo & Desafio | Serviços Chave | Documentação |
| :---: | :--- | :--- | :---: |
| 🏗️ **Dia 01** | **A Fundação:** Arquitetura em 3 Camadas Desacoplada | VPC Multi-AZ, ALB, EC2, SQS, DynamoDB | [Acessar Lab Dia 01 ➔](./dia-01/README.md) |
| 🛡️ **Dia 02** | **O Hardening:** Segurança & Escalabilidade Elástica | SSM Parameter Store, Launch Templates, ASG | [Acessar Lab Dia 02 ➔](./dia-02/README.md) |
| 📊 **Dia 03** | **A Operação:** Observabilidade & Engenharia do Caos | CloudWatch, Alarmes SNS, Backlog Scaling, Chaos Test | [Acessar Lab Dia 03 ➔](./dia-03/README.md) |

## 🗺️ Visão Geral da Jornada Técnica

> 📌 **Navegue pelas etapas da jornada clicando nos títulos abaixo:**

### 1️⃣ [DIA 01: A Fundação — Arquitetura Resiliente em 3 Camadas](./dia-01/README.md)
* **Pilar:** Arquitetura & Infraestrutura Base
* **Entrega:** Provisionamento de VPC Multi-AZ, Application Load Balancer, instâncias EC2 privadas para Frontend/Backend, buffer desacoplador com Amazon SQS e banco NoSQL DynamoDB.
* 🔗 **[Explorar documentação e scripts do Dia 01 ➔](./dia-01/README.md)**


### 2️⃣ [DIA 02: O Hardening — Governança, Segurança e Elasticidade](./dia-02/README.md)
* **Pilar:** Segurança da Informação & Resiliência
* **Entrega:** Remoção de credenciais e parâmetros hardcoded usando AWS Systems Manager (SSM) Parameter Store, padronização via Launch Templates e alta disponibilidade com Auto Scaling Groups.
* 🔗 **[Explorar documentação e templates do Dia 02 ➔](./dia-02/README.md)**

### 3️⃣ [DIA 03: A Operação — Observabilidade, Negócio e Auto-Healing](./dia-03/README.md)
* **Pilar:** Operações, Negócios & Engenharia do Caos
* **Entrega:** Criação de painéis no Amazon CloudWatch com métricas de negócio, testes de estresse para validação de autorrecuperação e análise de impacto operacional.
* 🔗 **[Explorar documentação e dashboards do Dia 03 ➔](./dia-03/README.md)**



---

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

