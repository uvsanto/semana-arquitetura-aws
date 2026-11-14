#!/usr/bin/env python3
"""Pontuação didática SAA-C03 por dia, a partir de docs/saa-c03-scorecard.csv.

Status aceitos:
  ok         -> item entregue COM evidência (print/log)
  registrado -> item executado, sem print (registro textual do autor)
  pendente   -> previsto no roteiro, ainda não comprovado
  lacuna     -> melhoria que o laboratório não cobre (conta no total, mas não como entregue)

É um indicador próprio para estudo. NÃO é a nota do exame nem uma auditoria.
"""
import csv, sys
from collections import defaultdict

PESOS = {"1-Seguranca": 30, "2-Resiliencia": 26, "3-Performance": 24, "4-Custo": 20}
ARQ = sys.argv[1] if len(sys.argv) > 1 else "docs/saa-c03-scorecard.csv"

linhas = list(csv.DictReader(open(ARQ, encoding="utf-8")))
total = defaultdict(int)
for r in linhas:
    total[r["dominio"]] += 1

def pontos(ate_dia, aceitos):
    soma, por_dominio = 0.0, {}
    for d, peso in PESOS.items():
        n = sum(1 for r in linhas if r["dominio"] == d
                and 1 <= int(r["dia"]) <= ate_dia and r["status"] in aceitos)
        por_dominio[d] = n
        soma += peso * n / total[d]
    return soma, por_dominio

cenarios = [("Dia 1 - Construindo a solucao", 1),
            ("Dia 1+2 - Evoluindo a arquitetura", 2),
            ("Dia 1+2+3 - Operacao e resiliencia", 3)]
visoes = [("Comprovado (ok)", {"ok"}),
          ("Declarado (ok+registrado)", {"ok", "registrado"}),
          ("Potencial (ok+registrado+pendente)", {"ok", "registrado", "pendente"})]

print("Domínio (peso): itens no total ->", {d: total[d] for d in PESOS})
print()
print(f"{'Cenário':38}" + "".join(f"{v[0]:>38}" for v in visoes))
for nome, dia in cenarios:
    print(f"{nome:38}" + "".join(f"{pontos(dia, ac)[0]:>37.1f}%" for _, ac in visoes))
