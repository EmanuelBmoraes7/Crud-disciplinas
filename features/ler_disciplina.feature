# language: pt
Funcionalidade: Ler disciplinas
  Como administrador da instituição
  Quero consultar disciplinas cadastradas
  Para visualizar as informações disponíveis

  Cenário: Buscar disciplina existente por ID
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    E eu cadastro "Programação II" inicio "2025-02-01" termino "2025-06-30" vagas 30 verao falso
    Quando eu buscar a disciplina de ID 1
    Então devo receber a disciplina com título "Cálculo I"

  Cenário: Tentar buscar disciplina com ID inexistente
    Dado que nenhuma disciplina foi cadastrada
    Quando eu tentar buscar a disciplina de ID 99
    Então deve ocorrer um erro de validação com a mensagem "Disciplina com id=99 não encontrada."

  Cenário: Listar todas as disciplinas
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    E eu cadastro "Programação II" inicio "2025-02-01" termino "2025-06-30" vagas 30 verao falso
    Quando eu listar todas as disciplinas
    Então devo receber uma lista com 3 disciplinas

  Cenário: Listar disciplinas com repositório vazio
    Dado que nenhuma disciplina foi cadastrada
    Quando eu listar todas as disciplinas
    Então devo receber uma lista vazia

  Cenário: Verificar dados completos da disciplina retornada
    Dado que nenhuma disciplina foi cadastrada
    E eu cadastro "Cálculo I" inicio "2025-02-01" termino "2025-06-30" vagas 40 verao falso
    E eu cadastro "Inglês Básico" inicio "2025-01-05" termino "2025-02-05" vagas 20 verao verdadeiro
    Quando eu buscar a disciplina de ID 2
    Então devo receber a disciplina com título "Inglês Básico"
    E a disciplina deve ser marcada como de verão
    E o número de vagas deve ser 20
