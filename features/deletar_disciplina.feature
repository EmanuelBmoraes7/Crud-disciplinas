# language: pt
Funcionalidade: Deletar disciplina
  Como administrador da instituição
  Quero remover disciplinas do sistema
  Para manter o cadastro atualizado

  Cenário: Deletar uma disciplina existente
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    Quando eu deletar a disciplina de ID 1
    Então a disciplina de ID 1 não deve mais existir no sistema

  Cenário: Verificar que somente a disciplina correta foi removida
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    Quando eu deletar a disciplina de ID 1
    Então devem existir 1 disciplinas cadastradas
    E a disciplina de ID 2 ainda deve existir

  Cenário: Tentar deletar disciplina inexistente
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar deletar a disciplina de ID 99
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Tentar buscar disciplina após deleção
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    Quando eu deletar a disciplina de ID 1
    E eu tentar buscar a disciplina de ID 1
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=1 não encontrada."

  Cenário: Deletar todas as disciplinas
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    Quando eu deletar a disciplina de ID 1
    E eu deletar a disciplina de ID 2
    Então devo receber uma lista vazia quando listar todas
