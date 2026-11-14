# ADR-0002: DynamoDB para persistência das requisições

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** 1

## Contexto
As requisições são registros independentes, acessados por identificador, sem joins nem transações complexas.

## Opções consideradas
1. **Amazon RDS** (relacional): flexível para consultas, exige dimensionamento, patching e Multi-AZ configurado.
2. **DynamoDB**: serverless, escala automaticamente, resiliente entre AZs por padrão, acesso por chave.

## Decisão
DynamoDB com chave de partição `requestId` (String).

## Consequências
- ✅ Sem servidor de banco para operar; escala com a demanda.
- ⚠️ Consultas fora da chave (por data, por exemplo) exigem índices ou *scan*.
- ⚠️ Confirmar no console se a tabela está em modo sob demanda ou provisionado antes de afirmar no README.
- 🔧 Melhoria: habilitar *point-in-time recovery*.

## Pilar / Domínio
Confiabilidade, Eficiência de performance · Domínios 2 e 3
