# language: pt
Funcionalidade: Atualizar disciplina
  Como administrador da instituição
  Quero atualizar os dados de uma disciplina
  Para corrigir ou complementar informações

  Contexto:
    Dado que as seguintes disciplinas estão cadastradas:
      | titulo    | data_inicio | data_termino | num_vagas | e_verao |
      | Cálculo I | 2025-02-01  | 2025-06-30   | 40        | falso   |

  Cenário: Atualizar o título de uma disciplina
    Quando eu atualizar a disciplina de ID 1 com o título "Cálculo Avançado"
    Então a disciplina de ID 1 deve ter o título "Cálculo Avançado"

  Cenário: Atualizar o número de vagas
    Quando eu atualizar a disciplina de ID 1 com 60 vagas
    Então o número de vagas da disciplina de ID 1 deve ser 60

  Cenário: Atualizar se a disciplina é de verão
    Quando eu atualizar a disciplina de ID 1 marcando como de verão
    Então a disciplina de ID 1 deve ser marcada como de verão

  Cenário: Atualizar as datas de uma disciplina
    Quando eu atualizar a disciplina de ID 1 com início "2025-07-01" e término "2025-12-15"
    Então a data de início da disciplina de ID 1 deve ser "2025-07-01"
    E a data de término da disciplina de ID 1 deve ser "2025-12-15"

  Cenário: Tentar atualizar disciplina inexistente
    Quando eu tentar atualizar a disciplina de ID 99 com o título "Fantasma"
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Tentar atualizar disciplina com título vazio
    Quando eu tentar atualizar a disciplina de ID 1 com título vazio
    Então deve ocorrer um erro de validação com a mensagem "O título não pode ser vazio."

  Cenário: Tentar atualizar disciplina com data de término anterior à de início
    Quando eu tentar atualizar a disciplina de ID 1 com início "2025-06-30" e término "2025-01-01"
    Então deve ocorrer um erro de validação com a mensagem "A data de término não pode ser anterior à data de início."

  Cenário: Tentar atualizar disciplina com número inválido de vagas
    Quando eu tentar atualizar a disciplina de ID 1 com 0 vagas
    Então deve ocorrer um erro de validação com a mensagem "O número de vagas deve ser maior que zero."
