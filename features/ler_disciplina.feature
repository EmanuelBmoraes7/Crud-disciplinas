# language: pt
Funcionalidade: Ler disciplinas
  Como administrador da instituição
  Quero consultar disciplinas cadastradas
  Para visualizar as informações disponíveis

  Contexto:
    Dado que as seguintes disciplinas estão cadastradas:
      | titulo         | data_inicio | data_termino | num_vagas | e_verao |
      | Cálculo I      | 2025-02-01  | 2025-06-30   | 40        | falso   |
      | Inglês Básico  | 2025-01-05  | 2025-02-05   | 20        | verdadeiro |
      | Programação II | 2025-02-01  | 2025-06-30   | 30        | falso   |

  Cenário: Buscar disciplina existente por ID
    Quando eu buscar a disciplina de ID 1
    Então devo receber a disciplina com título "Cálculo I"

  Cenário: Tentar buscar disciplina com ID inexistente
    Quando eu tentar buscar a disciplina de ID 99
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Listar todas as disciplinas
    Quando eu listar todas as disciplinas
    Então devo receber uma lista com 3 disciplinas

  Cenário: Listar disciplinas com repositório vazio
    Dado que nenhuma disciplina foi cadastrada
    Quando eu listar todas as disciplinas
    Então devo receber uma lista vazia

  Cenário: Verificar dados completos da disciplina retornada
    Quando eu buscar a disciplina de ID 2
    Então devo receber a disciplina com título "Inglês Básico"
    E a disciplina deve ser marcada como de verão
    E o número de vagas deve ser 20
