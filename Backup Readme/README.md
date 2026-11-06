# 🏛️ Semana Arquitetura AWS: Arquitetura em 3 Camadas Altamente Disponível e Desacoplada

Projeto prático desenvolvido durante a **Semana da Arquitetura AWS**, implementando um padrão corporativo em nuvem focado em resiliência, alta disponibilidade (Multi-AZ), desacoplamento assíncrono e segurança de ponta a ponta (Zero Trust).

---

## 📐 Topologia da Arquitetura

O sistema implementa o fluxo clássico de três camadas com buffer assíncrono para proteção contra picos de tráfego:


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

</Step>

  <Step subtitle="1 min" title="Commit e Push no GitHub Desktop">
    Abra o **GitHub Desktop**. No canto inferior esquerdo, escreva no resumo:
    `fix: fechar bloco de codigo da topologia e adicionar glossario`
    Clique em **Commit to main** e, em seguida, em **Push origin** no topo.
    *Verification:* O GitHub Desktop sincroniza sem erros e volta a exibir o botão "Fetch origin".
  </Step>

  <Step subtitle="30 seg" title="Validar a visualização no GitHub">
    Atualize a página do seu repositório no navegador com **F5**.
    *Verification:* Os títulos `## Componentes`, a tabela do Glossário e as listas aparecem com a formatação Markdown correta, fora do bloco cinza.
  </Step>
</Steps>

---

## ⚙️ Especificações e Recursos Criados

### 🌐 Rede e Infraestrutura Base (Amazon VPC)
* **Região:** `us-east-2` (Ohio)
* **VPC:** `projeto-vpc` (`vpc-0401507c7793c8633`) | Bloco CIDR: `10.0.0.0/16`
* **Sub-redes Públicas:**
  * `projeto-subnet-public1-us-east-2a` (ALB Nó 1)
  * `projeto-subnet-public2-us-east-2b` (ALB Nó 2)
* **Sub-redes Privadas:**
  * `projeto-subnet-private1-us-east-2a` (Frontend 2)
  * `projeto-subnet-private2-us-east-2b` (Frontend 1)
  * `projeto-subnet-private3-us-east-2a` (Backend Worker 1)
  * `projeto-subnet-private4-us-east-2b` (Backend Worker 2)
* **Saída de Rede:** Internet Gateway (`projeto-igw`) para balanceador público e NAT Gateway (`projeto-regional-nat`) para saída transparente de atualizações nas sub-redes privadas.

---

### 🛡️ Camada de Segurança (Security Groups & IAM)
1. **`loadbalancer-sg-vagner-tomaz` (`sg-0cb0a703e457be273`):**
   * Entrada: Porta `80` (HTTP) aberta para a Internet (`0.0.0.0/0`).
2. **`ec2-sg-vagner-tomaz` (`sg-0207307cf375e7982`):**
   * Entrada: Porta `80` (HTTP) autorizada **apenas** com origem referenciada em `sg-0cb0a703e457be273` (Zero Direct Access).
3. **IAM Instance Profile (`ec2-role-vagner-tomaz`):**
   * Papel anexado diretamente às EC2, eliminando credenciais estáticas (*Access Keys*) em código.
   * Políticas: `AmazonDynamoDBFullAccess` e `AmazonSQSFullAccess`.

---

### 🖥️ Camada de Apresentação (Frontend)
* **Application Load Balancer:** `projeto-alb-vagner-toma`
* **Target Group:** `grupo-frontend-vagner-tomaz` (Health Check: `/`, intervalo de 10s).
* **Nós:** Duas instâncias EC2 (`t2.micro`) sem IP público em Zonas distintas (`us-east-2a` e `us-east-2b`).
* **Stack:** Python 3, Flask e SDK `boto3`. Cada submissão web gera um `requestId` único via `uuid4` e encaminha a mensagem encapsulada para o Amazon SQS.

---

### 📦 Camada de Mensageria (Buffer Assíncrono)
* **Serviço:** Amazon SQS (Simple Queue Service)
* **Fila:** `fila-registros-vagner-tomaz`
* **Função:** Desacopla o frontend do processamento de banco de dados, protegendo o backend contra sobrecargas repentinas.

---

### ⚙️ Camada de Processamento (Backend Workers)
* **Nós:** Duas instâncias EC2 (`t2.micro`) privadas distribuídas em Multi-AZ (`us-east-2a` e `us-east-2b`).
* **Execução:** Serviço Linux `systemd` executando script Python com *long polling* (20s) na fila SQS.
* **Ciclo de Vida:** Extração da mensagem, persistência estruturada no DynamoDB e deleção confirmada da fila via `ReceiptHandle`.

---

### 🗄️ Camada de Persistência (Banco de Dados NoSQL)
* **Serviço:** Amazon DynamoDB
* **Tabela:** `tabela-registros-vagner-tomaz`
* **Partition Key:** `requestId` (String)
* **Modo de Capacidade:** Sob Demanda (On-Demand)

---

## 🧪 Validação dos Testes de Integração

1. **Acesso Web via ALB:**
   * Requisições submetidas pelo DNS público do balanceador:
     * Transação 1: `requestId: ef49b21d-aa3e-40b2-ac6e-17cfdb24dcbe` | Dado: `Teste de Mensagem AWS`
     * Transação 2: `requestId: 0dd96f08-2f02-4779-a8f8-5ee83c1be3da` | Dado: `Semana da arquitetura AWS`
2. **Consumo no SQS:**
   * Métricas do CloudWatch comprovaram entrada de mensagens e esvaziamento imediato da fila após o processamento dos nós trabalhadores.
3. **Persistência Confirmada no DynamoDB:**
   * Registros gravados com 100% de eficiência contendo `requestId`, `data`, `received_at` e `processed_at`.

---

## 🎯 Lições Aprendidas e Pilares do AWS Well-Architected Framework

* **Confiabilidade:** A separação Multi-AZ de balanceadores, frontends e workers impede que a falha de um datacenter interrompa o serviço.
* **Segurança:** O encadeamento de Security Groups garante que os servidores de aplicação fiquem blindados de acessos diretos externos. O uso de IAM Roles elimina o risco de vazamento de credenciais no código.
* **Desempenho e Eficiência:** O uso do SQS como amortecedor absorve picos sem degradação na experiência do usuário.

---

## 📖 Glossário de Serviços e Tecnologias AWS

| Serviço / Conceito | O que é? | Papel nesta Arquitetura |
| :--- | :--- | :--- |
| **Amazon VPC** (Virtual Private Cloud)[cite: 5, 27] | Rede virtual isolada e logicamente dedicada dentro da nuvem AWS. | Define o perímetro de rede, sub-redes públicas/privadas e tabelas de rotas do projeto[cite: 4, 5, 27]. |
| **Sub-rede Pública**[cite: 5] | Segmento de rede com rota direta para a Internet através de um Internet Gateway[cite: 5, 21]. | Hospeda as interfaces públicas do Application Load Balancer para receber tráfego externo[cite: 5, 21]. |
| **Sub-rede Privada**[cite: 5] | Segmento de rede isolado, sem IP público e sem rota direta de entrada da Internet[cite: 5, 27]. | Protege as instâncias de Frontend e Backend Workers contra varreduras e ataques externos diretos[cite: 4, 5]. |
| **NAT Gateway**[cite: 5, 21] | Mecanismo de tradução de endereços gerenciado pela AWS[cite: 21]. | Permite que as instâncias em sub-redes privadas baixem pacotes e atualizações do Linux sem expor seus IPs[cite: 4, 5]. |
| **Internet Gateway (IGW)**[cite: 5, 21] | Componente de borda redundante que conecta a VPC à Internet[cite: 21]. | Permite a comunicação bidirecional do balanceador de carga público com os usuários externos[cite: 5, 21]. |
| **Security Groups**[cite: 5] | Firewalls virtuais dinâmicos com controle de tráfego por regras de estado (Stateful)[cite: 5, 20]. | Controla o fluxo entre camadas; as instâncias EC2 só aceitam conexões originadas no SG do ALB[cite: 4, 5]. |
| **AWS IAM Role**[cite: 5, 24] | Mecanismo de permissões temporárias atribuídas a serviços ou recursos sem chaves estáticas[cite: 5, 24]. | Concede permissão às EC2 para gravar no DynamoDB e ler/apagar da fila SQS com rotação automática de credenciais[cite: 4, 5, 25]. |
| **Application Load Balancer (ALB)**[cite: 5, 22] | Balanceador de carga gerenciado na Camada 7 (Aplicação)[cite: 5, 22]. | Recebe o tráfego HTTP na porta 80 e distribui as requisições entre instâncias em múltiplas Zonas (Multi-AZ)[cite: 4, 5, 18, 22]. |
| **Target Group**[cite: 5] | Agrupamento lógico de destinos que receberão o tráfego roteado pelo balanceador[cite: 5]. | Registra as instâncias de frontend e executa testes periódicos de integridade (*Health Checks*)[cite: 5, 23]. |
| **Amazon EC2**[cite: 5, 27] | Servidores virtuais escaláveis de computação em nuvem[cite: 5, 27]. | Executa os servidores web em Flask (camada Frontend) e os scripts de consumo em lote (camada Backend)[cite: 4, 5]. |
| **User Data**[cite: 5] | Script de inicialização (*bootstrap*) executado no primeiro boot da instância EC2[cite: 5]. | Automatiza a instalação de bibliotecas Python, código da aplicação e inicialização via `systemd`[cite: 4, 5]. |
| **Amazon SQS**[cite: 5, 28] | Serviço de enfileiramento gerenciado para troca de mensagens assíncronas[cite: 5, 28]. | Atua como amortecedor (*buffer*) resiliente, desacoplando o Frontend do processamento final de banco[cite: 4, 5, 27]. |
| **Long Polling** | Técnica de requisição que mantém a conexão aberta no SQS aguardando novas mensagens. | Reduz custos operacionais de chamadas de API vazias e minimiza latência de consumo pelo backend[cite: 4]. |
| **Amazon DynamoDB**[cite: 5, 29] | Banco de dados NoSQL No-Ops, chave-valor e documento, totalmente gerenciado[cite: 29]. | Persiste o histórico de requisições e payloads com latência de milissegundos e escala sob demanda[cite: 4, 5, 20, 29]. |
