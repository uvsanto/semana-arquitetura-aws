# 🚀 Projeto de Arquitetura AWS Multi-Tier de Alta Disponibilidade (3-Tier)
**Turma C9 SET - DPCN 17 | Escola da Nuvem**  
**Autor:** Vagner Tomaz dos Santos  

---

## 📌 Identificação Acadêmica, Mentoria e Governança Tecnológica
Este projeto foi desenvolvido como parte da trilha prática de arquitetura em nuvem da Escola da Nuvem, simulando um ambiente de missão crítica corporativa. 

* **Inteligência Artificial Aplicada (Co-Engenharia e Auditoria):** 
  * **Google Gemini:** Atuando como IA Mestre na estruturação arquitetural de alto nível, revisão pedagógica, diagramação lógica em Mermaid e geração de código de infraestrutura.
  * **Claude:** Atuando como IA auxiliar na validação de governança, diretrizes de segurança e revisão de checklists técnicos.

---

## 🌐 1. O que é a Amazon Web Services (AWS) e sua Liderança Global
A **Amazon Web Services (AWS)** é a plataforma de nuvem mais adotada e abrangente do mundo, oferecendo centenas de serviços completos de data centers globalmente. 
* **Liderança de Mercado:** Relatórios de analistas de mercado (como Gartner e Synergy Research Group) apontam consistentemente a AWS na liderança global de infraestrutura de nuvem (*Cloud Infrastructure as a Service*), detendo mais de 30% do market share mundial.
* **Vantagens Competitivas:** Agilidade de implantação, resiliência multi-região comprovada, inovação acelerada em Inteligência Artificial/Machine Learning e o modelo financeiro **Pay-as-you-go** (Pague pelo que usar), que substitui custos de capital antecipados (CapEx) por despesas operacionais flexíveis (OpEx).

---

## 🎯 2. O Propósito do Desafio e Modelo de System Design (Blueprint)
O objetivo principal deste projeto é consolidar na prática os pilares do **AWS Well-Architected Framework** (Excelência Operacional, Segurança, Confiabilidade, Eficiência de Desempenho e Otimização de Custos). 

Este repositório funciona como um **Blueprint de System Design** escalável e reutilizável, demonstrando como projetar uma aplicação web desacoplada, resiliente e segura, atendendo diretamente aos domínios do exame **AWS Certified Solutions Architect – Associate (SAA-C03)**.

---

## 📅 3. Navegação pelos Desafios de Laboratório (Dias 01, 02 e 03)

O laboratório foi executado de forma progressiva ao longo de três dias, mapeando os seguintes serviços essenciais da AWS:

### 🛠️ Dia 01: Fundamentação de Rede e Camadas (Networking & ALB)
* **Serviços AWS Utilizados:** Amazon VPC, Internet Gateway, NAT Gateway, Sub-redes (Públicas e Privadas), Application Load Balancer (ALB), Target Groups.
* **Resumo:** Construção da fundação de rede Multi-AZ na região `us-east-2`, garantindo isolamento de tráfego e distribuição inteligente de requisições web.

### 🔒 Dia 02: Segurança, Computação e Escalabilidade (IAM, SSM & ASGs)
* **Serviços AWS Utilizados:** AWS IAM, AWS Systems Manager (Parameter Store & Session Manager), Amazon EC2, Amazon SQS (com DLQ), Amazon DynamoDB, Auto Scaling Groups (ASGs), Launch Templates.
* **Resumo:** Centralização de parâmetros sensíveis, automação e empacotamento de aplicações Python (Flask e Worker) com recuperação automática de falhas (*Self-Healing*).

### 📊 Dia 03: Observabilidade, Alertas e Notificações (CloudWatch & SNS)
* **Serviços AWS Utilizados:** Amazon CloudWatch (Métricas e Alarmes), Amazon SNS (Simple Notification Service).
* **Resumo:** Implementação de monitoramento proativo para uso de CPU e acúmulo de mensagens (*backlog*), disparando notificações por e-mail em tempo real.

---

## 🏗️ 4. Topologia e Evolução Visual da Arquitetura

### 4.1. Arquitetura Inicial (Baseline de Rede)
Infraestrutura estática baseada em sub-redes públicas e privadas em duas Zonas de Disponibilidade, onde o Application Load Balancer atua como ponto de entrada reverso.

### 4.2. Topologia Macro Geral da Arquitetura
```mermaid
flowchart LR
    User([Cliente / Internet]) -->|HTTP :80| ALB[Application Load Balancer]
    
    subgraph VPC Multi-AZ (us-east-2)
        subgraph Sub-redes Públicas
            ALB -->|Proxy Reverso| FE1[Instância EC2 - Frontend Flask]
            ALB --> FE2[Instância EC2 - Frontend Flask]
        end

        subgraph Sub-redes Privadas (Isolated)
            FE1 -->|Enfileira Mensagem| SQS[(Amazon SQS Principal)]
            SQS -.->|DLQ Falhas| DLQ[(SQS Dead Letter Queue)]
            
            BE1[Instância EC2 - Backend Worker] -->|Consome Fila| SQS
            BE1 -->|Persiste Dados| DynamoDB[(Amazon DynamoDB)]
            
            SSM[(AWS SSM Parameter Store)] -.->|Injeção de Configs| FE1
            SSM -.->|Injeção de Configs| BE1
        end
    end

    CloudWatch[Amazon CloudWatch Alarms] -->|Gatilho de Alerta| SNS[Amazon SNS Topic]
    SNS -->|E-mail| Admin([Administrador / Operador])