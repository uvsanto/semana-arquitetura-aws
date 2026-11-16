<div align="center">
  <h1>🛠️ Dia 01 — Construindo a Base</h1>
  <h3>Aplicação de 3 Camadas Desacoplada por Fila, Rede Multi-AZ e Balanceamento de Carga</h3>
  <p>
    <a href="../README.md">🏠 Página Principal</a> • 
    <a href="../dia-02/README.md">Avançar para o Dia 02: Evoluindo a Arquitetura ➡️</a>
  </p>
</div>

---

## 🎯 Descrição Didática do Desafio (O Projeto do Dia 01)

No **Dia 01**, estabelecemos a fundação essencial de uma aplicação web de três camadas (*3-Tier*) de alta disponibilidade:
1. **Infraestrutura de Rede e Borda:** Estruturação de uma VPC Multi-AZ na região `us-east-2`, separando sub-redes públicas e privadas, com Internet Gateway e NAT Gateways para roteamento seguro.
2. **Distribuição de Carga:** Implantação de um **[Application Load Balancer (ALB)](https://aws.amazon.com/pt/elasticloadbalancing/classic-load-balancer/)** voltado para a internet, associado a *Target Groups* para rotear requisições HTTP na porta 80.
3. **Desacoplamento Assíncrono e Persistência:** Conexão do Frontend (Flask) com o **[Amazon SQS](https://aws.amazon.com/pt/sqs/)** para fila de mensagens e persistência assíncrona dos registros no **[Amazon DynamoDB](https://aws.amazon.com/pt/dynamodb/)**.

## 🗺️ Visão geral do ambiente (baseline)
O projeto parte de uma infraestrutura de rede pré-existente como *baseline* (VPC, blocos CIDR, sub-redes e gateways), sobre a qual construímos o ecossistema de computação, balanceamento e mensageria em duas Zonas de Disponibilidade (`us-east-2a` e `us-east-2b`).

## ⚖️ Decisões de arquitetura (ADRs)
- **Application Load Balancer (ALB) vs. NLB:** Escolha do ALB por operar na Camada 7 (HTTP/HTTPS), permitindo o roteamento inteligente de requisições web para instâncias de frontend.
- **SQS Principal vs. Sincronismo Direto:** Adoção de mensageria assíncrona para desacoplar a camada web do backend de processamento, garantindo resiliência contra picos de tráfego.

---

## 📐 Topologia da Arquitetura — Cenário Dia 01 (Mermaid.js)

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

---

🛠️ Tecnologias AWS Utilizadas nessa EtapaServiço / Recurso AWSFunção Construída no Dia 01Definição no GlossárioAmazon VPC & Sub-redesIsolamento de tráfego em sub-redes públicas e privadas distribuídas em Multi-AZ.Rede virtual isolada logicamente na nuvem AWS para provisionar recursos.Internet & NAT GatewayPermite o tráfego de entrada da internet e saída segura para atualizações em instâncias privadas.Gateways de roteamento para comunicação com a internet pública.Application Load BalancerDistribui o tráfego HTTP recebido da web para as instâncias EC2 de frontend.Balanceador de carga de camada 7 para aplicações web.Amazon SQSFila de mensagens que recebe os payloads enviados pelo frontend de forma desacoplada.Serviço de mensageria gerenciada para desacoplar sistemas distribuídos.Amazon DynamoDBBanco de dados NoSQL de chave-valor para persistir os registros enviados.Banco NoSQL serverless de alta performance e baixa latência.🩺 Evidências de Testes e Troubleshooting Técnico — Dia 01Nota importante: Os prints de tela específicos da construção inicial do Dia 01 não foram salvos, mas todo o checklist de validação e a execução estrutural encontram-se rigorosamente registrados de forma textual (📝):Ação de Infraestrutura ExecutadaComportamento EsperadoStatus e Validação Real (Registro Textual)1. Validação de Sub-redes e Roteamento Multi-AZAs instâncias nas sub-redes privadas devem alcançar o NAT Gateway sem exposição pública.Validado via tabelas de rotas e associações de sub-redes na VPC.2. Teste de Acesso via DNS do Load BalancerO ALB deve responder às requisições HTTP na porta 80 e encaminhar para o Target Group.Validado com sucesso após ajustes de regras de tráfego de rede.3. Envio e Persistência de Mensagens (SQS ➔ DynamoDB)O envio de dados pelo formulário web deve gerar um requestId e persistir no DynamoDB.Validado ponta a ponta com o fluxo completo de mensagens processadas.🎯 Alinhamento e Cobertura AWS SAA-C03 — Dia 01Distribuição do peso técnico abordado especificamente na fundação do Dia 01 conforme o Guia do Exame SAA-C03:Domínio Oficial SAA-C03Cobertura no Dia 01Práticas e Melhores Práticas Aplicadas na EtapaDomínio 1: Arquiteturas Resilientes (Peso Oficial: 26%)40%Desenho de VPC Multi-AZ com redundância de zonas de disponibilidade e balanceamento de carga elástico com ALB.Domínio 2: Alto Desempenho (Peso Oficial: 24%)35%Desacoplamento de microsserviços via filas SQS e armazenamento de alta escala com DynamoDB.Domínio 3: Arquiteturas Seguras (Peso Oficial: 30%)15%Isolamento de camadas de computação em sub-redes privadas protegidas da internet direta.Domínio 4: Custo Otimizado (Peso Oficial: 20%)10%Utilização dimensionada de recursos essenciais para iniciar o laboratório de forma enxuta.🚀 Resumo de Boas Práticas e O que Deve Ser Melhorado (Gatilhos para o Dia 02)Boas Práticas Conquistadas: Separação clara entre camadas públicas e privadas, uso de balanceamento de carga Multi-AZ e mensageria assíncrona.O que seria diferente utilizando tecnologias de IaC (Terraform, CloudFormation ou Kiro) neste Cenário:A construção manual via console e CLI no Dia 01 é excelente para o aprendizado profundo dos fundamentos de rede. Contudo, se tivéssemos utilizado Terraform ou AWS CloudFormation, a criação da VPC, tabelas de rotas, gateways, ALB e filas estaria totalmente declarada em código, permitindo provisionar toda a infraestrutura base de rede em poucos segundos com um único comando terraform apply.Pontos de Melhoria (Gatilhos para o Dia 02):Credenciais e Parâmetros Chumbados no Código: No Dia 01, URLs de filas e nomes de tabelas ainda precisavam constar diretamente nos scripts; precisamos centralizar isso no Parameter Store.Ausência de Imutabilidade e Auto-Healing: As instâncias EC2 iniciais dependem de configuração estática; precisamos introduzir Launch Templates e Auto Scaling Groups.👉 Avançar para o Dia 02: Evoluindo a Arquitetura (Segurança e Auto Scaling) ➡️
