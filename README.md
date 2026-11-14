<div align="center">
  <h1>🏛️ Semana da Arquitetura AWS — Turma C9 SET (DPCN 17)</h1>
  <h3>System Design em Nuvem: Arquitetura em 3 Camadas Altamente Disponível, Desacoplada e Observável</h3>
  <p><i>Projeto prático de engenharia e governança em nuvem: construindo um ecossistema capaz de absorver picos extremos de tráfego, proteger ativos críticos de dados e recuperar-se automaticamente de falhas sem intervenção humana.</i></p>

  <p>
    <a href="https://aws.amazon.com/pt/"><img src="https://img.shields.io/badge/AWS_Cloud-us--east--2_(Ohio)-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Region"></a>
    <a href="https://aws.amazon.com/pt/certification/certified-solutions-architect-associate/"><img src="https://img.shields.io/badge/Alinhado_ao_Exame-AWS_SAA--C03-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=FF9900" alt="SAA-C03"></a>
    <a href="https://github.com/users/uvsanto/projects/2"><img src="https://img.shields.io/badge/GitHub_Projects-Kanban_Ativo-2ea44f?style=for-the-badge&logo=github" alt="GitHub Project"></a>
    <a href="https://escoladanuvem.org/"><img src="https://img.shields.io/badge/Instituição-Escola_da_Nuvem-007ACC?style=for-the-badge" alt="Escola da Nuvem"></a>
  </p>
</div>

---

## 👥 Identificação Acadêmica, Mentoria e Ecossistema Tecnológico

| Papel no Projeto | Nome / Instituição | Links Oficiais e Redes |
| :--- | :--- | :--- |
| 👨‍🏫 **Professor / Mestre Avaliador** | **Ednilson Cipolla** | [![LinkedIn](https://img.shields.io/badge/LinkedIn-Ednilson_Cipolla-0A66C2?style=flat-square&logo=linkedin)](https://br.linkedin.com/in/ednilsoncipolla) |
| 👨‍💻 **Aluno / Cloud Analyst & Architect** | **Vagner Tomaz** | [![LinkedIn](https://img.shields.io/badge/LinkedIn-Vagner_Tomaz-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/vagner-tomaz) [![GitHub](https://img.shields.io/badge/GitHub-uvsanto-181717?style=flat-square&logo=github)](https://github.com/uvsanto/semana-arquitetura-aws) |
| 🏫 **Instituição e Gestora** | **Escola da Nuvem** | [![Site Oficial](https://img.shields.io/badge/Web-escoladanuvem.org-00A8E8?style=flat-square&logo=google-chrome)](https://escoladanuvem.org/) [![Instagram](https://img.shields.io/badge/Instagram-@escola__da__nuvem-E4405F?style=flat-square&logo=instagram)](https://www.instagram.com/escola_da_nuvem/) |

### 🌟 Sobre a Escola da Nuvem
A **[Escola da Nuvem](https://escoladanuvem.org/)** é uma organização sem fins lucrativos que transforma vidas por meio da educação tecnológica gratuita, conectando talentos diversos ao ecossistema de Computação em Nuvem e às maiores empresas de tecnologia do mercado. Ao promover imersões práticas como a **Semana da Arquitetura AWS (Turma C9 SET - DPCN 17)**, a instituição desenvolve não apenas o domínio técnico da plataforma, mas a mentalidade real de resolução de problemas complexos de negócio exigida de arquitetos e engenheiros de nuvem.

### 🛠️ Ferramentas e Tecnologias Utilizadas no Desenvolvimento
* **Ambiente de Nuvem:** [Amazon Web Services (AWS)](https://aws.amazon.com/pt/) (Região `us-east-2` - Ohio).
* **IDE e Edição Técnica:** [Visual Studio Code (VS Code)](https://code.visualstudio.com/) para estruturação de código Python, scripts *User Data* e documentação Markdown.
* **Controle de Versão, Gestão Ágil e CI/CD:** [GitHub](https://github.com/uvsanto/semana-arquitetura-aws), [GitHub Projects (Kanban)](https://github.com/users/uvsanto/projects/2) e [GitHub Actions](https://github.com/features/actions).
* **Inteligência Artificial Aplicada (Co-Engenharia e Auditoria):** **Google Gemini** (atuando como IA Mestre na estruturação arquitetural, revisão pedagógica e diagramação em código) e **GitHub Copilot / GPT** (atuando como IA auxiliar e validadora de governança e checklists).

---

## ☁️ O que é a Amazon Web Services (AWS) e sua Liderança Global

A **[Amazon Web Services (AWS)](https://aws.amazon.com/pt/)** é a plataforma de computação em nuvem mais abrangente e amplamente adotada do mundo, oferecendo mais de 200 serviços completos de data centers globalmente.

* **Liderança no Gartner (14+ Anos Consecutivos):** De acordo com o *Gartner Magic Quadrant for Strategic Cloud Platform Services (CIPS)*, a AWS ocupa de forma ininterrupta o quadrante de **Líder Global**, seguida por Microsoft Azure e Google Cloud Platform (GCP).
* **Dominância Global e no Brasil:** Com cerca de **31% a 33% de participação de mercado mundial (Market Share)** e presença consolidada no Brasil (Região São Paulo `sa-east-1` e zonas de borda), a AWS é a escolha primária para missões críticas no setor financeiro, varejo, governo e startups devido à sua maturidade em segurança, baixa latência e amplitude de serviços gerenciados.

---

## 💡 O Propósito do Desafio 

Imagine uma bilheteria de um grande show ou um site de vendas na Black Friday. Em um sistema comum, quando **10 mil pessoas clicam em "Enviar" ao mesmo tempo**, o servidor do site tenta receber o cliente e gravar no banco de dados no mesmo instante. O resultado? O banco de dados sobrecarrega, a tela trava e o sistema inteiro cai.

**Qual é o propósito deste projeto?**
Construir uma arquitetura inteligente dividida em **3 camadas independentes** onde **nenhuma peça derruba a outra**:
1. **A Recepção Rápida (Frontend):** Recebe o pedido do cliente em milésimos de segundo, gera um protocolo único e libera a tela imediatamente.
2. **A Fila Amortecedora ([Amazon SQS](https://aws.amazon.com/pt/sqs/)):** Guarda todos os pedidos em segurança por ordem de chegada, não importa se chegaram 10 ou 100 mil de uma vez.
3. **Os Trabalhadores de Bastidores (Backend + [Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/)):** Servidores internos pegam os pedidos da fila no seu próprio ritmo e salvam tudo no banco de dados sem estresse e sem perder nenhuma informação.

### 🧩 Este projeto pode se tornar um Modelo (Blueprint) de System Design na AWS?
**Sim!** Este repositório implementa o padrão arquitetural corporativo conhecido como **Queue-Based Load Leveling (Nivelamento de Carga Baseado em Fila)** em uma topologia **3-Tier Multi-AZ**. Ele serve como um **Modelo Oficial de System Design** pronto para ser replicado em:
* Processamento de pedidos de E-commerce e meios de pagamento (PIX/Cartões);
* Sistemas de emissão assíncrona de Notas Fiscais, boletos ou relatórios pesados;
* Ingestão de eventos de IoT, telemetria e microsserviços financeiros.

---

## 🔄 Metodologia de Engenharia em 6 Fases (Confronto Teórico vs. Prático)

O projeto foi conduzido seguindo as 6 etapas clássicas de transformação em nuvem e os fundamentos científicos do **NIST SP 800-145**:

| Fase de Engenharia | Definição e Escopo Teórico | O que Foi Aplicado na Prática neste Projeto |
| :--- | :--- | :--- |
| **1. Avaliação e Descoberta (Assessment)** | Alinhar objetivos de negócio, mapear legado e definir KPIs (Latência, Uptime e Orçamento). | Mapeamento de gargalos de aplicações monolíticas legadas; definição de meta de **100% de retenção de mensagens** e disponibilidade Multi-AZ. |
| **2. Definição de Modelos e Provedores** | Escolha entre **IaaS, PaaS ou SaaS**, nuvem Pública/Privada/Híbrida e seleção do provedor. | Adoção de **Nuvem Pública (AWS)** em modelo híbrido de serviço: **IaaS** ([Amazon EC2](https://aws.amazon.com/pt/ec2/)) para controle das aplicações Python e **PaaS/Serverless** ([Amazon SQS](https://aws.amazon.com/pt/sqs/) e [Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/)) para eliminar administração de banco e filas. |
| **3. Desenho da Arquitetura (Design)** | Topologia de rede ([Amazon VPC](https://aws.amazon.com/pt/vpc/)), Zero Trust ([AWS IAM](https://aws.amazon.com/pt/iam/)), Multi-AZ e estimativa FinOps. | Desenho de VPC (`10.0.0.0/16`) em 2 Zonas (`us-east-2a` e `us-east-2b`), 2 sub-redes públicas e 4 privadas, Security Groups encadeados e IAM Roles sem chaves fixas. |
| **4. Construção e Automação (IaC & Bootstrap)** | Provisionamento reproduzível, scripts de inicialização e esteira de validação CI/CD. | Automação de bootstrap via scripts *User Data* e gerenciador `systemd`, armazenamento central no [AWS Systems Manager Parameter Store](https://aws.amazon.com/pt/systems-manager/features/#Parameter_Store) e CI/CD documental via **GitHub Actions**. |
| **5. Migração e Testes de Resiliência** | Testes de integração ponta a ponta, estresse de carga e simulação deliberada de falhas. | Testes de ingestão HTTP via [Elastic Load Balancing (ALB)](https://aws.amazon.com/pt/elasticloadbalancing/application-load-balancer/), consumo via *Long Polling* (20s) e **Engenharia do Caos** (desligamento forçado de EC2 para validar *Self-Healing*). |
| **6. Operação, Monitoramento e FinOps** | Observabilidade contínua, otimização de custos e revisão pelo [AWS Well-Architected](https://aws.amazon.com/pt/architecture/well-architected/). | Painéis e alarmes no [Amazon CloudWatch](https://aws.amazon.com/pt/cloudwatch/), alertas via [Amazon SNS](https://aws.amazon.com/pt/sns/), escala por Backlog da fila e banco DynamoDB em modo *On-Demand*. |

---

## 🗺️ Navegação pelos Desafios de Laboratório (Dia 01, Dia 02 e Dia 03)

> 📌 **Clique nos links abaixo para acessar a documentação pedagógica detalhada de cada etapa:**

| Módulo | Título Pedagógico do Desafio | Foco Técnico Principal | Acesso Direto |
| :---: | :--- | :--- | :---: |
| **Dia 01** | **Construindo a Solução:** Fundação em 3 Camadas e Desacoplamento | [Amazon VPC](https://aws.amazon.com/pt/vpc/), [ALB](https://aws.amazon.com/pt/elasticloadbalancing/application-load-balancer/), [Amazon EC2](https://aws.amazon.com/pt/ec2/), [Amazon SQS](https://aws.amazon.com/pt/sqs/) e [Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/) | [📂 Abrir Lab Dia 01](./dia-01/README.md) |
| **Dia 02** | **Evoluindo a Arquitetura:** Blindagem de Segurança e Auto Scaling | [SSM Parameter Store](https://aws.amazon.com/pt/systems-manager/), [Session Manager](https://aws.amazon.com/pt/systems-manager/features/#Session_Manager), [Auto Scaling](https://aws.amazon.com/pt/ec2/autoscaling/) e DLQ | [📂 Abrir Lab Dia 02](./dia-02/README.md) |
| **Dia 03** | **Operação e Resiliência:** Observabilidade, FinOps e Engenharia do Caos | [Amazon CloudWatch](https://aws.amazon.com/pt/cloudwatch/), [Amazon SNS](https://aws.amazon.com/pt/sns/), Backlog Scaling e Testes de Falha | [📂 Abrir Lab Dia 03](./dia-03/README.md) |

---

## 🧭 Mapeamento de Linha de Base (Baseline) e Visão Geral do Ambiente

* **Região Selecionada:** `us-east-2` (Leste dos EUA - Ohio) — escolhida pelo menor custo operacional e baixa latência para testes globais.
* **VPC (`projeto-vpc`):** Bloco CIDR `10.0.0.0/16` dividido simetricamente entre `us-east-2a` e `us-east-2b`.
* **Camada Pública:** 2 sub-redes públicas contendo o Internet Gateway (`IGW`), nós do ALB (`projeto-alb-vagner-toma`) e NAT Gateways.
* **Camada Privada:** 4 sub-redes privadas isoladas (2 para Web Frontend e 2 para Workers Backend), sem endereço IPv4 público.

### Evolução Visual da Arquitetura (Baseline ➔ Implementado)

#### 1. Arquitetura Inicial (Baseline de Rede antes do Laboratório)
![Arquitetura Antes do Laboratório](assets/img/arquitetura-antes.png)

#### 2. Arquitetura em 3 Camadas Implementada (Após o Laboratório)
![Arquitetura Após o Laboratório](assets/img/arquitetura-depois.png)

---

## 📐 Topologia Macro Geral da Arquitetura (Mermaid.js)

```mermaid
flowchart TB
    subgraph Edge ["🌐 Borda Externa & Entrega"]
        User(["👤 Clientes / Usuários Web"])
        CF["⚡ Amazon CloudFront (Entrega Segura / Edge)"]
    end

    subgraph AWS ["☁️ AWS Cloud — Região us-east-2 (Ohio) | VPC: projeto-vpc (10.0.0.0/16)"]
        IGW["🌐 Internet Gateway"]

        subgraph Public ["Sub-redes Públicas (us-east-2a & us-east-2b)"]
            ALB["⚖️ Application Load Balancer\n(projeto-alb-vagner-toma)"]
            NAT["🚪 NAT Gateways (Multi-AZ)"]
        end

        subgraph WebTier ["1ª Camada Privada: Apresentação (Frontend Web)"]
            ASG_FE["💻 EC2 Auto Scaling Group — Frontend\n(Python Flask | Target Group: grupo-frontend-vagner-tomaz)"]
        end

        subgraph QueueTier ["Camada de Desacoplamento Assíncrono (Buffer)"]
            SQS[("📬 Amazon SQS\n(fila-registros-vagner-tomaz)")]
            DLQ[("🛑 Dead Letter Queue (DLQ)\nIsolamento de Falhas")]
            SQS -.->|Excesso de Tentativas| DLQ
        end

        subgraph AppTier ["2ª Camada Privada: Processamento (Backend Workers)"]
            ASG_BE["⚙️ EC2 Auto Scaling Group — Backend\n(Python systemd Worker | Long Polling 20s)"]
        end

        subgraph DataTier ["3ª Camada: Persistência NoSQL Escalável"]
            DDB[("🗄️ Amazon DynamoDB\n(tabela-registros-vagner-tomaz)\nPartition Key: requestId | On-Demand")]
        end

        subgraph SecGov ["🛡️ Segurança, Governança, Observabilidade & FinOps"]
            IAM["🔑 AWS IAM Role\n(ec2-role-vagner-tomaz)"]
            SSM["🔐 AWS Systems Manager\n(Parameter Store & Session Manager Zero-SSH)"]
            CW["📈 Amazon CloudWatch\n(Dashboards, Logs & Backlog Alarms)"]
            SNS["📣 Amazon SNS & Cost Anomaly\n(Notificações e Controle FinOps)"]
        end
    end

    User -->|HTTP / HTTPS| CF
    CF --> IGW
    IGW --> ALB
    ALB -->|SG Encadeado :80| ASG_FE
    ASG_FE -->|SendMessage JSON + UUID| SQS
    SQS -->|ReceiveMessage (20s)| ASG_BE
    ASG_BE -->|PutItem NoSQL| DDB
    ASG_FE -.->|GetParameter| SSM
    ASG_BE -.->|GetParameter| SSM
    IAM -.->|Credenciais Temporárias| ASG_FE
    IAM -.->|Credenciais Temporárias| ASG_BE
    CW -.->|Política de Escala por Fila| ASG_BE
    CW -->|Dispara Alerta| SNS
    WebTier -.->|Saída p/ Pacotes| NAT
    AppTier -.->|Saída p/ APIs| NAT
```

---

## 🤔 Decisão Arquitetural: Por que não utilizar Terraform, CloudFormation ou Kiro no início?

Embora ferramentas de **Infraestrutura como Código (IaC)** como [HashiCorp Terraform](https://www.terraform.io/), [AWS CloudFormation](https://aws.amazon.com/pt/cloudformation/) e **Kiro** sejam o padrão para reprodução em larga escala, a construção guiada nos 3 cenários priorizou o provisionamento direto com automação via *User Data* pelos seguintes motivos técnicos e pedagógicos:
1. **Domínio da Anatomia dos Serviços:** Criar manualmente o encadeamento entre Security Groups, anexar IAM Instance Profiles, configurar listeners de Target Groups e políticas de Auto Scaling constrói o modelo mental real exigido de um arquiteto na prova **[AWS SAA-C03](https://aws.amazon.com/pt/certification/certified-solutions-architect-associate/)**.
2. **Qual herramienta ajudaria melhor neste cenário futuro?**
   * **AWS CloudFormation:** Ideal se a empresa operar 100% na AWS e desejar suporte nativo sem gerenciar arquivos de estado (`tfstate`) externos.
   * **Terraform / OpenTofu:** A melhor escolha para este projeto evoluir como portfólio de mercado, devido à sua sintaxe modular HCL e adoção massiva em vagas de Cloud/DevOps.
   * **Kiro (Spec-driven Development):** Excelente para transformar requisitos arquiteturais e especificações em código e documentação estruturada a partir dos diagramas já validados.

---

## 🎯 Mapeamento Oficial e Ranking: Certificação [AWS SAA-C03](https://aws.amazon.com/pt/certification/certified-solutions-architect-associate/)

Esta arquitetura foi desenhada e auditada seguindo o [Guia Oficial do Exame AWS Certified Solutions Architect - Associate (SAA-C03)](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03.html).

### 1. Ranking Geral dos Domínios da Prova Aplicados ao Projeto

| Posição no Ranking | Domínio Oficial ([Guia SAA-C03](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03.html)) | Peso Oficial na Prova | Entregas Comprovadas no Projeto |
| :---: | :--- | :---: | :--- |
| **🥇 1º Lugar** | **Domínio 1: Criação de Arquiteturas Seguras** | **30%** | Isolamento em 4 sub-redes privadas, encadeamento de Security Groups (*Zero Direct Access*), [AWS IAM](https://aws.amazon.com/pt/iam/) Roles sem chaves estáticas, [SSM Parameter Store](https://aws.amazon.com/pt/systems-manager/) e acesso remoto sem porta SSH via Session Manager. |
| **🥈 2º Lugar** | **Domínio 2: Criação de Arquiteturas Resilientes** | **26%** | Topologia Multi-AZ (`us-east-2a` e `us-east-2b`), balanceamento via [ALB](https://aws.amazon.com/pt/elasticloadbalancing/application-load-balancer/), desacoplamento com [Amazon SQS](https://aws.amazon.com/pt/sqs/) + DLQ, [EC2 Auto Scaling](https://aws.amazon.com/pt/ec2/autoscaling/) e testes reais de *Self-Healing*. |
| **🥉 3º Lugar** | **Domínio 3: Arquiteturas de Alto Desempenho** | **24%** | Separação em 3 camadas independentes, consumo otimizado via *Long Polling* (20s), escalabilidade por *Backlog* de mensagens e persistência em milissegundos no [Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/). |
| **🏅 4º Lugar** | **Domínio 4: Arquiteturas com Custo Otimizado** | **20%** | Banco DynamoDB em modo *On-Demand* (pagamento por requisição), eliminação de chamadas vazias de API no SQS, instâncias dimensionadas (`t2.micro`/`t3.micro`) e alertas de anomalia de custo. |

### 2. Distribuição Percentual de Foco Técnico em Cada Dia do Desafio

Como o esforço de arquitetura se distribuiu entre os 4 domínios da **[AWS SAA-C03](https://aws.amazon.com/pt/certification/certified-solutions-architect-associate/)** ao longo dos três laboratórios:

| Domínio SAA-C03 | 🏗️ Dia 01: Construindo a Solução | 🛡️ Dia 02: Evoluindo a Arquitetura | 📊 Dia 03: Operação e Resiliência |
| :--- | :---: | :---: | :---: |
| **Segurança (Domínio 1)** | **20%** *(VPC Privada, SG Encadeado e IAM Role)* | **45%** *(Parameter Store e Session Manager Zero-SSH)* | **15%** *(Auditoria de Acesso e Governança)* |
| **Resiliência (Domínio 2)** | **50%** *(Multi-AZ, ALB Health Check e Fila SQS)* | **30%** *(Auto Scaling Groups, Launch Templates e DLQ)* | **45%** *(Engenharia do Caos e Self-Healing)* |
| **Performance (Domínio 3)** | **20%** *(3 Camadas, Long Polling 20s e DynamoDB)* | **15%** *(Bootstrap Automatizado e Elasticidade)* | **20%** *(Métricas em Tempo Real e Backlog Scaling)* |
| **Custos / FinOps (Domínio 4)** | **10%** *(DynamoDB On-Demand e Redução de API Calls)* | **10%** *(Scale-In Automático na Ociosidade)* | **20%** *(Monitoramento CloudWatch, SNS e FinOps)* |
| **Total do Cenário** | **100% do Escopo Dia 01** | **100% do Escopo Dia 02** | **100% do Escopo Dia 03** |

---

## 🏛️ Governança, Responsabilidade Compartilhada e Conformidade (Maturidade)

### 1. Modelo de Responsabilidade Compartilhada da AWS
* **Responsabilidade da AWS ("Segurança DA Nuvem"):** Proteção física dos data centers em Ohio (`us-east-2`), hipervisores do EC2, infraestrutura global de rede e disponibilidade física dos serviços gerenciados (SQS, DynamoDB, SSM).
* **Responsabilidade do Cliente / Arquiteto ("Segurança NA Nuvem"):** Configuração das regras de Security Groups, políticas de mínimo privilégio no IAM, ocultação de parâmetros no Parameter Store, atualização do sistema operacional Linux e configuração de Multi-AZ.

### 2. Avaliação de Maturidade nos Frameworks de Mercado

| Framework / Norma | Maturidade Atingida | Aplicação e Comprovação no Projeto |
| :--- | :---: | :--- |
| **[AWS Well-Architected Framework](https://aws.amazon.com/pt/architecture/well-architected/)** | **95% (Avançado)** | Atende aos 6 pilares: Excelência Operacional (SSM/CloudWatch), Segurança (Zero Trust/IAM), Confiabilidade (Multi-AZ/SQS/ASG), Eficiência de Performance (NoSQL/Assíncrono), Otimização de Custos (On-Demand) e Sustentabilidade (recursos elásticos sem ociosidade). |
| **LGPD (Lei nº 13.709/2018)** | **92% (Conforme)** | *Privacy by Design*: Identificação de registros por hashes universais (`UUID v4`), criptografia em repouso nativa no DynamoDB/SQS, sanitização de Account IDs na documentação pública e tráfego restrito a sub-redes privadas. |
| **[AWS Cloud Adoption Framework (AWS CAF)](https://aws.amazon.com/pt/cloud-adoption-framework/)** | **90% (Estruturado)** | Alinhamento entre as perspectivas de Negócio (continuidade operacional), Plataforma (arquitetura desacoplada), Segurança (IAM/SSM) e Operações (monitoramento ativo). |
| **FinOps & Mitigação de Vendor Lock-in** | **88% (Otimizado)** | Controle de custos em componentes críticos (NAT Gateway, ALB e EC2) e aplicação escrita em **Python/Flask padrão**, facilitando futura portabilidade para containers (Docker/Kubernetes) caso necessário. |

---

## ✅ Matriz Geral de Etapas e Evidências Técnicas Comprovadas

| Etapa | Componente AWS | Evidência Técnica Comprovada no Ambiente | Status |
| :---: | :--- | :--- | :---: |
| **01** | **[Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/)** | Tabela `tabela-registros-vagner-tomaz` criada com Partition Key `requestId` (String). | ✅ Comprovado |
| **02** | **[Amazon SQS](https://aws.amazon.com/pt/sqs/)** | Fila `fila-registros-vagner-tomaz` provisionada e URL integrada aos serviços. | ✅ Comprovado |
| **03** | **Security Groups** | `loadbalancer-sg-vagner-tomaz` (público :80) encadeado ao `ec2-sg-vagner-tomaz`. | ✅ Comprovado |
| **04** | **[AWS IAM](https://aws.amazon.com/pt/iam/)** | Role `ec2-role-vagner-tomaz` anexada às instâncias EC2 sem chaves hardcoded. | ✅ Comprovado |
| **05** | **Frontend ([Amazon EC2](https://aws.amazon.com/pt/ec2/))** | Duas instâncias Flask distribuídas em `us-east-2a` e `us-east-2b` (sub-redes privadas). | ✅ Comprovado |
| **06** | **Target Group** | `grupo-frontend-vagner-tomaz` reportando 100% dos destinos como **Healthy**. | ✅ Comprovado |
| **07** | **[Application Load Balancer](https://aws.amazon.com/pt/elasticloadbalancing/application-load-balancer/)** | Balanceador `projeto-alb-vagner-toma` ativo roteando tráfego via DNS público. | ✅ Comprovado |
| **08** | **Teste de Frontend** | Página carregada via DNS do ALB e envio de mensagens confirmado com retorno de UUID. | ✅ Comprovado |
| **09** | **Backend ([Amazon EC2](https://aws.amazon.com/pt/ec2/))** | Duas instâncias Workers em sub-redes privadas rodando serviço contínuo `systemd`. | ✅ Comprovado |
| **10** | **Processamento** | Leitura via *Long Polling* (20s) e exclusão automática da mensagem (`DeleteMessage`). | ✅ Comprovado |
| **11** | **Persistência Final** | Registros encontrados no DynamoDB com carimbos `received_at` e `processed_at`. | ✅ Comprovado |

