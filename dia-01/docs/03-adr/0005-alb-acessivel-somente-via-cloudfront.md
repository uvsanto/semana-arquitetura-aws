# ADR-0005: ALB acessível somente via CloudFront

- **Status:** rascunho (revisar com suas palavras)
- **Dia:** 3

## Contexto
Até o Dia 2, o ALB aceita HTTP de qualquer origem (`0.0.0.0/0`). Com o CloudFront na frente, o acesso direto ao ALB fica como uma brecha: permite contornar a camada de borda.

## Opções consideradas
1. **Deixar o ALB aberto**: simples, porém expõe o ponto de entrada.
2. **SG do ALB restrito aos endereços do CloudFront** (lista de prefixos gerenciada).
3. **Opção 2 + cabeçalho secreto** validado pelo ALB: reforça contra tráfego vindo de outras distribuições CloudFront.

## Decisão
Restringir o SG do ALB ao CloudFront. O cabeçalho secreto e o WAF ficam como evolução.

## Consequências
- ✅ O tráfego passa pela borda (cache, TLS, proteção).
- ⚠️ O Dia 3 usa HTTP entre CloudFront e ALB; para produção, HTTPS ponta a ponta com ACM.

## Pilar / Domínio
Segurança · Domínio 1
