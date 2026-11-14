# Evidências

```
evidence/
├── dia-01/   # prints do Dia 1 (versões sanitizadas)
├── errors/   # erros reais, diagnóstico e correção (um arquivo por problema)
└── tests/    # testes de integração, falha e carga
```

## Legenda de status (use sempre nas tabelas)

| Símbolo | Significado |
|---|---|
| 📸 | Comprovado com print ou log capturado na hora |
| 📝 | Executado e registrado por escrito, **sem print** |
| 🔁 | Captura refeita depois (registre a data) |
| ❌ | Sem evidência |

## Regras

- **Nunca** apresente uma captura refeita como se fosse a original: marque 🔁 e a data.
- Salve os originais (sem tarja) em `evidence/_originais/`, que está no `.gitignore`.
- Publique só versões com **Account ID, e-mails, ARNs, URL da fila e DNS do ALB ocultados**.
- Nome dos arquivos: `diaN-assunto-aaaa-mm-dd.png`.
- Cada erro vira um arquivo a partir do modelo [`errors/_template.md`](errors/_template.md).
