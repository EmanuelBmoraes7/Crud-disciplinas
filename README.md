# CRUD de Disciplinas

Gerenciador de disciplinas para instituições de ensino, com testes BDD e esteira de CI automatizada.

## Estrutura do Projeto

```
crud-disciplinas/
├── app/
│   └── disciplinas.py          # Lógica de negócio (CRUD)
├── features/
│   ├── criar_disciplina.feature
│   ├── ler_disciplina.feature
│   ├── atualizar_disciplina.feature
│   └── deletar_disciplina.feature
├── tests/
│   ├── conftest.py
│   └── steps/
│       └── test_disciplinas.py  # Step definitions BDD
├── .github/
│   └── workflows/
│       └── ci.yml              # Pipeline de CI (cobertura ≥ 75%)
├── pytest.ini
├── requirements.txt
└── README.md
```

## Modelo de Dados — Disciplina

| Campo        | Tipo    | Obrigatório | Restrições                              |
|-------------|---------|-------------|----------------------------------------|
| id          | int     | automático  | Gerado pelo sistema                    |
| titulo      | str     | ✅          | Não pode ser vazio                     |
| data_inicio | date    | ✅          | —                                      |
| data_termino| date    | ✅          | Deve ser ≥ data_inicio                |
| num_vagas   | int     | ✅          | Deve ser > 0                           |
| e_verao     | bool    | ✅          | True/False                             |

## Operações CRUD

- **Criar** — `gerenciador.criar(titulo, data_inicio, data_termino, num_vagas, e_verao)`
- **Ler por ID** — `gerenciador.buscar_por_id(id)`
- **Listar todas** — `gerenciador.listar_todas()`
- **Atualizar** — `gerenciador.atualizar(id, **campos_opcionais)`
- **Deletar** — `gerenciador.deletar(id)`

## Cobertura de Testes BDD

| Feature                   | Cenários |
|--------------------------|----------|
| Criar disciplina          | 7        |
| Ler disciplina            | 5        |
| Atualizar disciplina      | 8        |
| Deletar disciplina        | 5        |
| **Total**                | **25**   |
