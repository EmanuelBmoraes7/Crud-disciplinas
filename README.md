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

## Instalação e Execução Local

```bash
# Clonar o repositório
git clone https://github.com/SEU_USUARIO/crud-disciplinas.git
cd crud-disciplinas

# Instalar dependências
pip install -r requirements.txt

# Executar todos os testes
pytest tests/ -v

# Executar com relatório de cobertura
pytest tests/ --cov=app --cov-report=term-missing --cov-fail-under=75
```

## Pipeline de CI — GitHub Actions

O arquivo `.github/workflows/ci.yml` configura a esteira automatizada que:

1. **Dispara** em todo pull request direcionado à branch `main`
2. **Instala** as dependências do projeto
3. **Executa** os testes BDD com `pytest-bdd`
4. **Verifica cobertura** com `pytest-cov` — o PR **falha** se a cobertura for < 75%
5. **Publica** um comentário no PR com o resumo de cobertura

### Como configurar o repositório no GitHub

```bash
# 1. Criar repositório público no GitHub (via interface ou CLI)
gh repo create crud-disciplinas --public

# 2. Inicializar e enviar o código
git init
git add .
git commit -m "feat: CRUD de disciplinas com testes BDD e pipeline CI"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/crud-disciplinas.git
git push -u origin main
```

### Proteção de branch (recomendado)

No GitHub, acesse **Settings → Branches → Add rule** para a branch `main`:

- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging
  - Selecione: `Testes BDD + Cobertura (≥ 75%)`
- ✅ Require branches to be up to date before merging

Isso garante que nenhum PR será mergeado sem passar na esteira de CI.

## Compartilhamento com o Professor

Após criar o repositório público, adicione o professor como colaborador:

1. Acesse **Settings → Collaborators**
2. Clique em **Add people**
3. Informe o e-mail: `neutonmelo-neutonmelo@gmail.com`
