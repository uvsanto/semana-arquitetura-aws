<div align="center">
  <h1>🏛️ Semana da Arquitetura AWS</h1>
  <h3>Da Fundação à Observabilidade e Auto-Recuperação em Nuvem</h3>
  <p><i>Construindo um sistema digital capaz de absorver altos volumes de acessos, proteger dados sigilosos e se recuperar sozinho de falhas.</i></p>
</div>

---

## 💡 O Problema de Negócio (Para Gestores, Recrutadores e Técnicos)

Imagine uma loja virtual durante uma grande promoção ou um sistema bancário em dia de pagamento. Quando milhares de clientes tentam acessar ao mesmo tempo, sistemas tradicionais costumam travar, perder pedidos ou sair do ar porque o servidor que recebe o cliente é o mesmo que tenta salvar os dados no banco.

Este projeto resolve exatamente esse desafio real de negócio em **três etapas evolutivas**:
1. **Organização do Fluxo (Dia 01):** Criamos uma "fila inteligente" entre o site e o banco de dados. O cliente faz o pedido, recebe a confirmação na hora, e o sistema processa tudo em segundo plano sem travar, mesmo em horários de pico.
2. **Segurança e Elasticidade (Dia 02):** Blindamos as informações confidenciais em um cofre digital e configuramos a estrutura para crescer ou diminuir automaticamente conforme o número de clientes aumenta ou diminui.
3. **Visão de Negócio e Resistência (Dia 03):** Instalamos um painel de controle em tempo real e simulamos quedas propositais de servidores para comprovar que o sistema continua funcionando sem que o usuário perceba qualquer interrupção.

---

## 🗺️ Visão Geral da Jornada (Cronograma Evolutivo)

> 🖱️ *Clique no nome da etapa para rolar até os detalhes ou em "Abrir Projeto" para acessar a documentação técnica exclusiva de cada dia.*

| Ordem Cronológica | Etapa do Projeto | Foco de Negócio e Técnico | Navegação Rápida | Documentação Completa |
| :---: | :--- | :--- | :---: | :---: |
| **01/03** | **Dia 01: A Fundação** | Arquitetura em 3 Camadas e Fila de Mensagens | [Ver Resumo 👇](#dia-01) | [📂 Abrir Dia 01](./dia-01/README.md) |
| **02/03** | **Dia 02: O Hardening** | Segurança de Dados e Escala Automática | [Ver Resumo 👇](#dia-02) | [📂 Abrir Dia 02](./dia-02/README.md) |
| **03/03** | **Dia 03: A Operação** | Painéis de Monitoramento e Testes de Falha | [Ver Resumo 👇](#dia-03) | [📂 Abrir Dia 03](./dia-03/README.md) |

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
  └──────

---

## 📐 Evolução Visual da Arquitetura

### 1. Cenário Inicial (Antes do Projeto)
![Arquitetura Antes do Laboratório](assets/img/arquitetura-antes.png)

### 2. Cenário Implementado (Arquitetura em 3 Camadas Desacoplada)
![Arquitetura Após o Laboratório](assets/img/arquitetura-depois.png)


## 📚 Detalhamento dos Módulos por Etapa

<a id="dia-01"></a>
### 🔹 Dia 01 (Etapa 01/03) — Arquitetura em 3 Camadas Desacoplada e Resiliente
* **O que foi feito:** Construção da rede segura (VPC) dividida em duas zonas geográficas independentes em Ohio (`us-east-2a` e `us-east-2b`), criação de um distribuidor de acessos (Load Balancer), servidores web em rede privada, fila de mensagens (Amazon SQS) e banco de dados de alta velocidade (Amazon DynamoDB).
* **Resultado prático:** O usuário envia informações pelo navegador e recebe confirmação instantânea, enquanto os servidores internos gravam os dados com 100% de sucesso sem risco de sobrecarga.
* 🔗 **[Acessar página técnica completa do Dia 01 ➔](./dia-01/README.md)**

<a id="dia-02"></a>
### 🔹 Dia 02 (Etapa 02/03) — Segurança Centralizada e Escalabilidade Automática
* **O que foi feito:** Remoção de endereços e configurações expostas no código usando o cofre **AWS Systems Manager (Parameter Store)** e substituição de servidores fixos por grupos de **Auto Scaling** com modelos padronizados (*Launch Templates*).
* **Resultado prático:** Se um servidor falhar ou o tráfego dobrar de repente, a própria nuvem cria um novo servidor saudável em minutos, sem intervenção humana.
* 🔗 **[Acessar página técnica completa do Dia 02 ➔](./dia-02/README.md)**

<a id="dia-03"></a>
### 🔹 Dia 03 (Etapa 03/03) — Observabilidade, Métricas e Engenharia do Caos
* **O que foi feito:** Criação de painéis visuais no **Amazon CloudWatch**, configuração de alertas automáticos e execução de testes de estresse desligando máquinas propositalmente (*Chaos Engineering*).
* **Resultado prático:** Comprovação prática de que a arquitetura se recupera sozinha (*Self-Healing*) e mantém os indicadores operacionais visíveis para a tomada de decisão.
* 🔗 **[Acessar página técnica completa do Dia 03 ➔](./dia-03/README.md)**

## 🗺️ Mapa da Jornada de Engenharia

| Módulo | Escopo & Desafio | Serviços Chave | Documentação |
| :---: | :--- | :--- | :---: |
| 🏗️ **Dia 01** | **A Fundação:** Arquitetura em 3 Camadas Desacoplada | VPC Multi-AZ, ALB, EC2, SQS, DynamoDB | [Acessar Lab Dia 01 ➔](./dia-01/README.md) |
| 🛡️ **Dia 02** | **O Hardening:** Segurança & Escalabilidade Elástica | SSM Parameter Store, Launch Templates, ASG | [Acessar Lab Dia 02 ➔](./dia-02/README.md) |
| 📊 **Dia 03** | **A Operação:** Observabilidade & Engenharia do Caos | CloudWatch, Alarmes SNS, Backlog Scaling, Chaos Test | [Acessar Lab Dia 03 ➔](./dia-03/README.md) |


---

## 🏆 Ranking geral de Alinhamento: Certificação AWS Solutions Architect (SAA-C03)

Abaixo está o ranking oficial de relevância exigido no exame **AWS SAA-C03** (do maior para o menor peso na prova) e como cada um dos 3 cenários deste projeto cumpre esses requisitos na prática:

| Posição | Domínio Oficial da Prova SAA-C03 | Peso no Exame | Aplicação no Dia 01 (Fundação) | Aplicação no Dia 02 (Segurança/Escala) | Aplicação no Dia 03 (Operação/Caos) |
| :---: | :--- | :---: | :--- | :--- | :--- |
| **1º Lugar** | **Domínio 1: Arquiteturas Seguras** | **30%** | Servidores isolados em sub-redes privadas, bloqueio de acesso direto (*Zero Direct Access*) e permissões via IAM Role. | Eliminação de dados sensíveis do código-fonte utilizando o **SSM Parameter Store** e acesso sem porta SSH exposta. | Auditoria de acessos e validação das regras de proteção durante simulações de incidente. |
| **2º Lugar** | **Domínio 2: Arquiteturas Resilientes** | **26%** | Infraestrutura duplicada em 2 Zonas (Multi-AZ), Load Balancer e fila **SQS** para não perder requisições. | Implementação de **Auto Scaling Groups** para substituir máquinas com defeito automaticamente. | Testes reais de queda (*Chaos Testing*) comprovando a recuperação autônoma do ambiente. |
| **3º Lugar** | **Domínio 3: Alto Desempenho** | **24%** | Resposta rápida ao usuário com separação entre camada web (Flask), mensageria e banco NoSQL **DynamoDB**. | Padronização de inicialização rápida via *Launch Templates* e escalabilidade elástica sob demanda. | Ajuste fino de desempenho acompanhando métricas de tempo de resposta e vazão da fila em tempo real. |
| **4º Lugar** | **Domínio 4: Custo Otimizado** | **20%** | Uso de banco **DynamoDB On-Demand** (custo zero quando ocioso) e leitura inteligente da fila (*Long Polling* 20s). | Redução automática de servidores em horários de baixo movimento para evitar desperdício financeiro. | Monitoramento de consumo de recursos no **CloudWatch** para manter a operação enxuta (FinOps). |

---

## 📖 Glossário Rápido (Traduzindo o "Techniquês")

| Termo Técnico | O que significa no mundo real? | Papel no Projeto |
| :--- | :--- | :--- |
| **Amazon VPC** | Condomínio fechado digital | Isola toda a nossa estrutura do restante da internet pública. |
| **Sub-rede Privada** | Área restrita apenas para funcionários | Onde ficam os servidores e o banco de dados, longe do acesso direto de desconhecidos. |
| **Load Balancer (ALB)** | Recepcionista / Organizador de fila | Recebe os visitantes na entrada e distribui para o servidor que estiver mais livre. |
| **Amazon SQS** | Senha de atendimento / Caixa de entrada | Guarda os pedidos em segurança por ordem de chegada para nenhum dado se perder. |
| **Amazon DynamoDB** | Arquivo digital ultrarrápido | Banco de dados que guarda os registros finais em milésimos de segundo. |
| **Parameter Store** | Cofre de configurações | Guarda os endereços internos do sistema fora do código para aumentar a segurança. |
| **Auto Scaling** | Equipe elástica sob demanda | Contrata mais servidores quando a loja enche e dispensa quando esvazia. |

