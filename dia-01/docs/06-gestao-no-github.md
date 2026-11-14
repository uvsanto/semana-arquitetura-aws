# 06 · Gestão do projeto no GitHub

## Decisão sobre cada recurso

| Recurso | Usar? | Motivo |
|---|---|---|
| **Issues** | ✅ Sim | Rastreabilidade: cada entrega e cada erro vira uma issue, vinculada ao commit/PR |
| **Projects** | ✅ Sim | Quadro Kanban das 4 fases; o próprio quadro entra no portfólio |
| **Actions** | ✅ Sim | Lint de Markdown, verificação de links locais (pegaria os links quebrados) e varredura de segredos. Arquivo pronto em `.github/workflows/qualidade.yml` |
| **Pages** | ⏳ Depois | Só agrega uma vitrine; o GitHub já renderiza Markdown e Mermaid. Fazer depois da entrega, se sobrar tempo |
| **Discussions** | ❌ Não | Projeto individual, sem comunidade a mediar |
| **Secret scanning + push protection** | ✅ Sim, já | Ativar em *Settings → Code security* |

## Fases do projeto como quadro Kanban

| Fase | Conteúdo | Milestone | Exemplos de issue |
|---|---|---|---|
| 1. Assessment | Requisitos, métricas, baseline | Dia 1 | "Documentar requisitos e baseline" |
| 2. Design | Topologia, diagramas, ADRs | Dia 1 e 2 | "Diagrama do Dia 1", "ADR-0001 SQS" |
| 3. Segurança, operação e observabilidade | Parameter Store, Session Manager, CloudWatch, SNS, backlog | Dia 2 e 3 | "Configurar alarmes SNS" |
| 4. Evidências e troubleshooting | Prints, erros, testes de falha | Dia 3 | "Game Day: derrubar instância" |

## Passo a passo

1. **Criar o Project** (*Projects → New project → Board*). Colunas: `A fazer`, `Em andamento`, `Em validação`, `Concluído`.
2. **Campos personalizados:** `Dia` (1, 2, 3, Doc, Entrega), `Fase` (as 4 acima), `Domínio SAA` (1 a 4), `Evidência` (📸, 📝, ❌).
3. **Visões:** Quadro (por status), Tabela (agrupada por `Dia`) e Roteiro (por milestone).
4. **Automações nativas** (*Workflows*): item fechado → `Concluído`; item adicionado → `A fazer`.
5. **Milestones:** `Dia 1`, `Dia 2`, `Dia 3`, `Entrega`.
6. **Issues:** use `bash scripts/criar-issues.sh`; os templates em `.github/ISSUE_TEMPLATE/` padronizam tarefas e erros.
7. **Rastreabilidade:** nos commits e PRs escreva `Closes #12`; a issue fecha sozinha ao fazer o merge.
8. **Actions:** ao subir o repositório, confira a aba *Actions*; corrija o que o lint e a verificação de links acusarem.

## Regra de prioridade (evitar preciosismo)

1. Limpeza do repositório (marcadores `[cite]`, links quebrados, afirmações sem prova, créditos).
2. Páginas dos dias com checklist honesto.
3. Evidências e troubleshooting.
4. Scorecard e frameworks.
5. Actions. 6. Pages.
