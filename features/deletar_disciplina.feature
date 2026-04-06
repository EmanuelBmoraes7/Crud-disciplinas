# language: pt
Funcionalidade: Deletar disciplina
  Como administrador da instituição
  Quero remover disciplinas do sistema
  Para manter o cadastro atualizado

  Contexto:
    Dado que as seguintes disciplinas estão cadastradas:
      | titulo         | data_inicio | data_termino | num_vagas | e_verao |
      | Cálculo I      | 2025-02-01  | 2025-06-30   | 40        | falso   |
      | Inglês Básico  | 2025-01-05  | 2025-02-05   | 20        | verdadeiro |

  Cenário: Deletar uma disciplina existente
    Quando eu deletar a disciplina de ID 1
    Então a disciplina de ID 1 não deve mais existir no sistema

  Cenário: Verificar que somente a disciplina correta foi removida
    Quando eu deletar a disciplina de ID 1
    Então devem existir 1 disciplinas cadastradas
    E a disciplina de ID 2 ainda deve existir

  Cenário: Tentar deletar disciplina inexistente
    Quando eu tentar deletar a disciplina de ID 99
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Tentar buscar disciplina após deleção
    Quando eu deletar a disciplina de ID 1
    E eu tentar buscar a disciplina de ID 1
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=1 não encontrada."

  Cenário: Deletar todas as disciplinas
    Quando eu deletar a disciplina de ID 1
    E eu deletar a disciplina de ID 2
    Então devo receber uma lista vazia quando listar todas
