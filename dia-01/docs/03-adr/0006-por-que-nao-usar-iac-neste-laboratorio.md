# ADR-0006: Console da AWS em vez de infraestrutura como código neste laboratório

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** todos

## Contexto
O roteiro é conduzido pelo Console de Gerenciamento, em uma conta fornecida e com permissões restritas ao necessário. O objetivo é aprender os componentes e suas relações em 3 dias.

## Opções consideradas
1. **Terraform**: padrão de mercado, reprodutível; exige permissões amplas e tempo para configurar *backend* e estado, o que não cabe no prazo e pode ser bloqueado pela conta restrita.
2. **CloudFormation / CDK**: nativos da AWS; mesma limitação de permissões e curva de aprendizado.
3. **Kiro** (IDE com agente da AWS, pelo que sei): não é ferramenta de IaC em si, mas pode ajudar a gerar templates; não substitui a decisão.
4. **Console**: mais lento e menos reprodutível, porém adequado para entender cada serviço antes de automatizar.

## Decisão
Console, seguindo o roteiro. IaC fica como evolução, com a pasta `terraform/` reservada.

## Consequências
- ⚠️ O ambiente não é reproduzível por código; a reprodução depende da documentação.
- ✅ Mitigação: diagramas como código (Mermaid), parâmetros documentados e checklist por etapa.
- 🔧 Próximo passo: escrever o Terraform e validá-lo com `terraform validate` e `terraform plan`. **Só afirmar que foi aplicado se for aplicado.**

## Pilar / Domínio
Excelência operacional
