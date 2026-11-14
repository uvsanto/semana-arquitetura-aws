#!/usr/bin/env bash
# Cria labels, milestones e issues. Requer GitHub CLI (gh) autenticado, dentro do repositório.
# Uso: bash scripts/criar-issues.sh
set -e
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

for m in "Dia 1" "Dia 2" "Dia 3" "Entrega"; do
  gh api "repos/$REPO/milestones" -f title="$m" >/dev/null 2>&1 || true
done
for l in "tarefa:1f6feb" "troubleshooting:cf222e" "docs:2da44e" "seguranca:bf8700" "evidencia:8957e5"; do
  gh label create "${l%%:*}" --color "${l##*:}" 2>/dev/null || true
done

new() { gh issue create --title "$1" --milestone "$2" --label "$3" --body "$4"; }

new "Fase 1: requisitos, métricas e baseline" "Dia 1" "tarefa,docs" "- [ ] docs/01-assessment.md revisado
- [ ] Baseline (o que o curso forneceu) explícito"
new "Fase 2: topologia e CIDRs das sub-redes" "Dia 1" "tarefa,docs" "- [ ] Preencher CIDRs em docs/02-network-topology.md"
new "Dia 1: checklist e evidências (registro textual)" "Dia 1" "tarefa,evidencia" "- [ ] Checklist em dia-01/README.md
- [ ] Marcar 📝 onde não há print"
new "Dia 2: Parameter Store, Session Manager, ASG, CloudFront, DLQ" "Dia 2" "tarefa,seguranca" "- [ ] Capturar prints (📸) de cada item
- [ ] Atualizar dia-02/README.md"
new "Dia 3: dashboard, alarmes SNS, ALB via CloudFront, backlog" "Dia 3" "tarefa" "- [ ] Capturar prints
- [ ] Atualizar dia-03/README.md"
new "Dia 3: Game Day (falhas provocadas)" "Dia 3" "tarefa,evidencia" "- [ ] Tabela esperado x observado
- [ ] Medir tempo de recuperação do ASG"
new "Troubleshooting: registrar as principais dificuldades" "Dia 3" "troubleshooting" "- [ ] Um arquivo por erro em evidence/errors/"
new "Diagramas redesenhados (draw.io + Mermaid)" "Dia 3" "docs" "- [ ] Seguir diagrams/README.md"
new "ADRs revisados com minhas palavras" "Entrega" "docs" "- [ ] 0001 a 0006"
new "Scorecard SAA-C03 atualizado com evidências" "Entrega" "docs" "- [ ] Rodar scripts/scorecard.py"
new "Limpeza do README principal e checagem de sensíveis" "Entrega" "docs,seguranca" "- [ ] Sem [cite], sem links quebrados
- [ ] Sem Account ID, e-mail, ARN, URL de fila, DNS de ALB
- [ ] Créditos à Escola da Nuvem"
new "Ativar secret scanning e push protection" "Dia 1" "seguranca" "- [ ] Settings > Code security"
new "Teardown (somente após ordem do professor)" "Entrega" "tarefa" "- [ ] Evidências concluídas antes
- [ ] Ordem do professor registrada"
