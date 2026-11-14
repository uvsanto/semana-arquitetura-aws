# ADR-0003: Parameter Store para configuração da aplicação

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** 2

## Contexto
No Dia 1, região, URL da fila e nome da tabela ficavam fixos no código. Trocar um recurso exigia editar e reimplantar em cada instância.

## Opções consideradas
1. **Manter no código**: simples, mas frágil.
2. **Variáveis de ambiente no Launch Template**: melhora, mas ainda exige novo template a cada mudança.
3. **SSM Parameter Store**: a aplicação lê a configuração na inicialização; uma mudança é feita em um só lugar.
4. **Secrets Manager**: indicado para segredos reais com rotação; custo adicional.

## Decisão
Parameter Store.

## Consequências
- ✅ Configuração centralizada e auditável.
- ⚠️ No laboratório, o código lê os parâmetros **uma vez, na inicialização**: uma mudança só vale após reiniciar o serviço ou substituir a instância.
- ⚠️ A região (para criar o cliente do SSM) e o prefixo do caminho continuam no código; a externalização é parcial.
- ℹ️ O laboratório usa o tipo `String` e justifica não usar KMS pelo custo.
- ℹ️ URL de fila e nome de tabela são **configuração**, não segredo. Para segredos reais (senhas, tokens), usar `SecureString` com KMS ou Secrets Manager.
- 🔧 Melhoria: o laboratório anexa `AmazonSSMReadOnlyAccess` (leitura ampla do Systems Manager); restringir a role a `ssm:GetParameter` somente no caminho dos parâmetros da aplicação.

## Pilar / Domínio
Segurança, Excelência operacional · Domínio 1
