from datetime import date
from pathlib import Path
import pytest
from pytest_bdd import given, when, then, parsers, scenarios
from app.disciplinas import GerenciadorDisciplinas, DisciplinaError

FEATURES = Path(__file__).parent.parent.parent / "features"
scenarios(
    str(FEATURES / "criar_disciplina.feature"),
    str(FEATURES / "ler_disciplina.feature"),
    str(FEATURES / "atualizar_disciplina.feature"),
    str(FEATURES / "deletar_disciplina.feature"),
)

@pytest.fixture
def gerenciador():
    return GerenciadorDisciplinas()

@pytest.fixture
def contexto():
    return {}

@given("que nenhuma disciplina foi cadastrada")
def repositorio_vazio(gerenciador, contexto):
    contexto["gerenciador"] = gerenciador

@given(parsers.parse('eu cadastro "{titulo}" inicio "{inicio}" termino "{termino}" vagas {vagas:d} verao {verao}'))
def cadastrar_direto(gerenciador, contexto, titulo, inicio, termino, vagas, verao):
    contexto["gerenciador"] = gerenciador
    gerenciador.criar(
        titulo=titulo,
        data_inicio=date.fromisoformat(inicio),
        data_termino=date.fromisoformat(termino),
        num_vagas=vagas,
        e_verao=(verao.lower() == "verdadeiro"),
    )

@when(parsers.parse('eu criar a disciplina com título "{titulo}", início "{inicio}", término "{termino}", vagas {vagas:d} e verão {verao}'))
def criar_disciplina_valida(gerenciador, contexto, titulo, inicio, termino, vagas, verao):
    contexto["gerenciador"] = gerenciador
    contexto["erro"] = None
    try:
        contexto["disciplina"] = gerenciador.criar(
            titulo=titulo,
            data_inicio=date.fromisoformat(inicio),
            data_termino=date.fromisoformat(termino),
            num_vagas=vagas,
            e_verao=(verao.lower() == "verdadeiro"),
        )
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when("eu tentar criar uma disciplina com título vazio")
def criar_titulo_vazio(gerenciador, contexto):
    contexto["gerenciador"] = gerenciador
    contexto["erro"] = None
    try:
        gerenciador.criar(titulo="", data_inicio=date(2025,2,1), data_termino=date(2025,6,30), num_vagas=30, e_verao=False)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse('eu tentar criar uma disciplina com início "{inicio}" e término "{termino}"'))
def criar_datas_invalidas(gerenciador, contexto, inicio, termino):
    contexto["gerenciador"] = gerenciador
    contexto["erro"] = None
    try:
        gerenciador.criar(titulo="Teste", data_inicio=date.fromisoformat(inicio), data_termino=date.fromisoformat(termino), num_vagas=30, e_verao=False)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu tentar criar uma disciplina com {vagas:d} vagas"))
def criar_vagas_invalidas(gerenciador, contexto, vagas):
    contexto["gerenciador"] = gerenciador
    contexto["erro"] = None
    try:
        gerenciador.criar(titulo="Teste", data_inicio=date(2025,2,1), data_termino=date(2025,6,30), num_vagas=vagas, e_verao=False)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu buscar a disciplina de ID {id:d}"))
def buscar_por_id(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        contexto["disciplina"] = gerenciador.buscar_por_id(id)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu tentar buscar a disciplina de ID {id:d}"))
def tentar_buscar_por_id(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        contexto["disciplina"] = gerenciador.buscar_por_id(id)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when("eu listar todas as disciplinas")
def listar_todas(gerenciador, contexto):
    contexto["lista"] = gerenciador.listar_todas()

@when(parsers.parse('eu atualizar a disciplina de ID {id:d} com o título "{titulo}"'))
def atualizar_titulo(gerenciador, contexto, id, titulo):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, titulo=titulo)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu atualizar a disciplina de ID {id:d} com {vagas:d} vagas"))
def atualizar_vagas(gerenciador, contexto, id, vagas):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, num_vagas=vagas)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu atualizar a disciplina de ID {id:d} marcando como de verão"))
def atualizar_verao(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, e_verao=True)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse('eu atualizar a disciplina de ID {id:d} com início "{inicio}" e término "{termino}"'))
def atualizar_datas(gerenciador, contexto, id, inicio, termino):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, data_inicio=date.fromisoformat(inicio), data_termino=date.fromisoformat(termino))
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse('eu tentar atualizar a disciplina de ID {id:d} com o título "{titulo}"'))
def tentar_atualizar_titulo(gerenciador, contexto, id, titulo):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, titulo=titulo)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu tentar atualizar a disciplina de ID {id:d} com título vazio"))
def tentar_atualizar_titulo_vazio(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, titulo="")
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse('eu tentar atualizar a disciplina de ID {id:d} com início "{inicio}" e término "{termino}"'))
def tentar_atualizar_datas_invalidas(gerenciador, contexto, id, inicio, termino):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, data_inicio=date.fromisoformat(inicio), data_termino=date.fromisoformat(termino))
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu tentar atualizar a disciplina de ID {id:d} com {vagas:d} vagas"))
def tentar_atualizar_vagas_invalidas(gerenciador, contexto, id, vagas):
    contexto["erro"] = None
    try:
        gerenciador.atualizar(id=id, num_vagas=vagas)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu deletar a disciplina de ID {id:d}"))
def deletar_disciplina(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        gerenciador.deletar(id)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@when(parsers.parse("eu tentar deletar a disciplina de ID {id:d}"))
def tentar_deletar_disciplina(gerenciador, contexto, id):
    contexto["erro"] = None
    try:
        gerenciador.deletar(id)
    except DisciplinaError as e:
        contexto["erro"] = str(e)

@then("a disciplina deve ser criada com sucesso")
def disciplina_criada(contexto):
    assert contexto.get("erro") is None
    assert contexto.get("disciplina") is not None

@then(parsers.parse('o título da disciplina deve ser "{titulo}"'))
def verificar_titulo(contexto, titulo):
    assert contexto["disciplina"].titulo == titulo

@then(parsers.parse("o número de vagas deve ser {vagas:d}"))
def verificar_vagas(contexto, vagas):
    assert contexto["disciplina"].num_vagas == vagas

@then("a disciplina deve ser marcada como de verão")
def verificar_verao(contexto):
    assert contexto["disciplina"].e_verao is True

@then(parsers.parse('devo receber a disciplina com título "{titulo}"'))
def receber_disciplina_por_titulo(contexto, titulo):
    assert contexto.get("erro") is None
    assert contexto["disciplina"].titulo == titulo

@then(parsers.parse("devo receber uma lista com {qtd:d} disciplinas"))
def lista_com_quantidade(contexto, qtd):
    assert len(contexto["lista"]) == qtd

@then("devo receber uma lista vazia")
def lista_vazia(contexto):
    lista = contexto.get("lista") or contexto["gerenciador"].listar_todas()
    assert lista == []

@then(parsers.parse('deve ocorrer um erro de validação com a mensagem "{mensagem}"'))
def erro_de_validacao(contexto, mensagem):
    assert contexto.get("erro") == mensagem

@then(parsers.parse("devem existir {qtd:d} disciplinas cadastradas"))
def qtd_disciplinas(contexto, qtd):
    assert len(contexto["gerenciador"].listar_todas()) == qtd

@then("as disciplinas devem ter IDs diferentes")
def ids_diferentes(contexto):
    ids = [d.id for d in contexto["gerenciador"].listar_todas()]
    assert len(ids) == len(set(ids))

@then(parsers.parse('a disciplina de ID {id:d} deve ter o título "{titulo}"'))
def disciplina_titulo_atualizado(gerenciador, id, titulo):
    assert gerenciador.buscar_por_id(id).titulo == titulo

@then(parsers.parse("o número de vagas da disciplina de ID {id:d} deve ser {vagas:d}"))
def disciplina_vagas_atualizadas(gerenciador, id, vagas):
    assert gerenciador.buscar_por_id(id).num_vagas == vagas

@then(parsers.parse("a disciplina de ID {id:d} deve ser marcada como de verão"))
def disciplina_verao_atualizado(gerenciador, id):
    assert gerenciador.buscar_por_id(id).e_verao is True

@then(parsers.parse('a data de início da disciplina de ID {id:d} deve ser "{inicio}"'))
def disciplina_inicio_atualizado(gerenciador, id, inicio):
    assert str(gerenciador.buscar_por_id(id).data_inicio) == inicio

@then(parsers.parse('a data de término da disciplina de ID {id:d} deve ser "{termino}"'))
def disciplina_termino_atualizado(gerenciador, id, termino):
    assert str(gerenciador.buscar_por_id(id).data_termino) == termino

@then(parsers.parse("a disciplina de ID {id:d} não deve mais existir no sistema"))
def disciplina_nao_existe(gerenciador, id):
    with pytest.raises(DisciplinaError):
        gerenciador.buscar_por_id(id)

@then(parsers.parse("a disciplina de ID {id:d} ainda deve existir"))
def disciplina_ainda_existe(gerenciador, id):
    assert gerenciador.buscar_por_id(id) is not None

@then("devo receber uma lista vazia quando listar todas")
def lista_vazia_apos_delecao(gerenciador):
    assert gerenciador.listar_todas() == []
