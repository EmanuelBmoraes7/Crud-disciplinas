# language: pt
Funcionalidade: Atualizar disciplina
  Como administrador da instituição
  Quero atualizar os dados de uma disciplina
  Para corrigir ou complementar informações

  Cenário: Atualizar o título de uma disciplina
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu atualizar a disciplina de ID 1 com o título "Cálculo Avançado"
    Então a disciplina de ID 1 deve ter o título "Cálculo Avançado"

  Cenário: Atualizar o número de vagas
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu atualizar a disciplina de ID 1 com 60 vagas
    Então o número de vagas da disciplina de ID 1 deve ser 60

  Cenário: Atualizar se a disciplina é de verão
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu atualizar a disciplina de ID 1 marcando como de verão
    Então a disciplina de ID 1 deve ser marcada como de verão

  Cenário: Atualizar as datas de uma disciplina
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu atualizar a disciplina de ID 1 com início "2025-07-01" e término "2025-12-15"
    Então a data de início da disciplina de ID 1 deve ser "2025-07-01"
    E a data de término da disciplina de ID 1 deve ser "2025-12-15"

  Cenário: Tentar atualizar disciplina inexistente
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar atualizar a disciplina de ID 99 com o título "Fantasma"
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Tentar atualizar disciplina com título vazio
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu tentar atualizar a disciplina de ID 1 com título vazio
    Então deve ocorrer um erro de validação com a mensagem "O título não pode ser vazio."

  Cenário: Tentar atualizar disciplina com data de término anterior à de início
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu tentar atualizar a disciplina de ID 1 com início "2025-06-30" e término "2025-01-01"
    Então deve ocorrer um erro de validação com a mensagem "A data de término não pode ser anterior à data de início."

  Cenário: Tentar atualizar disciplina com número inválido de vagas
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu tentar atualizar a disciplina de ID 1 com 0 vagas
    Então deve ocorrer um erro de validação com a mensagem "O número de vagas deve ser maior que zero."
