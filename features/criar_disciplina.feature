# language: pt
Funcionalidade: Criar disciplina
  Como administrador da instituição
  Quero cadastrar novas disciplinas
  Para que os alunos possam se matricular

  Cenário: Criar uma disciplina com dados válidos
    Dado que nenhuma disciplina foi cadastrada
    Quando eu criar a disciplina com título "Cálculo I", início "2025-02-01", término "2025-06-30", vagas 40 e verão falso
    Então a disciplina deve ser criada com sucesso
    E o título da disciplina deve ser "Cálculo I"
    E o número de vagas deve ser 40

  Cenário: Criar uma disciplina de verão
    Dado que nenhuma disciplina foi cadastrada
    Quando eu criar a disciplina com título "Inglês Intensivo", início "2025-01-05", término "2025-02-05", vagas 20 e verão verdadeiro
    Então a disciplina deve ser criada com sucesso
    E a disciplina deve ser marcada como de verão

  Cenário: Tentar criar disciplina com título vazio
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar criar uma disciplina com título vazio
    Então deve ocorrer um erro de validação com a mensagem "O título não pode ser vazio."

  Cenário: Tentar criar disciplina com data de término anterior à de início
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar criar uma disciplina com início "2025-06-30" e término "2025-01-01"
    Então deve ocorrer um erro de validação com a mensagem "A data de término não pode ser anterior à data de início."

  Cenário: Tentar criar disciplina com zero vagas
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar criar uma disciplina com 0 vagas
    Então deve ocorrer um erro de validação com a mensagem "O número de vagas deve ser maior que zero."

  Cenário: Tentar criar disciplina com número negativo de vagas
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar criar uma disciplina com -5 vagas
    Então deve ocorrer um erro de validação com a mensagem "O número de vagas deve ser maior que zero."

  Cenário: Criar múltiplas disciplinas e verificar IDs únicos
    Dado que nenhuma disciplina foi cadastrada
    Quando eu criar a disciplina com título "Física I", início "2025-02-01", término "2025-06-30", vagas 35 e verão falso
    E eu criar a disciplina com título "Química Geral", início "2025-02-01", término "2025-06-30", vagas 30 e verão falso
    Então devem existir 2 disciplinas cadastradas
    E as disciplinas devem ter IDs diferentes
