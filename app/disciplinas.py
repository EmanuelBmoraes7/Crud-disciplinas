"""
CRUD de Disciplinas
Gerencia disciplinas oferecidas em uma instituição de ensino.
"""

from datetime import date
from typing import Optional


class DisciplinaError(Exception):
    pass


class Disciplina:
    def __init__(
        self,
        id: int,
        titulo: str,
        data_inicio: date,
        data_termino: date,
        num_vagas: int,
        e_verao: bool,
    ):
        self.id = id
        self.titulo = titulo
        self.data_inicio = data_inicio
        self.data_termino = data_termino
        self.num_vagas = num_vagas
        self.e_verao = e_verao

    def to_dict(self):
        return {
            "id": self.id,
            "titulo": self.titulo,
            "data_inicio": str(self.data_inicio),
            "data_termino": str(self.data_termino),
            "num_vagas": self.num_vagas,
            "e_verao": self.e_verao,
        }


class GerenciadorDisciplinas:
    def __init__(self):
        self._disciplinas: dict[int, Disciplina] = {}
        self._proximo_id = 1

    # ------------------------------------------------------------------
    # CREATE
    # ------------------------------------------------------------------
    def criar(
        self,
        titulo: str,
        data_inicio: date,
        data_termino: date,
        num_vagas: int,
        e_verao: bool,
    ) -> Disciplina:
        self._validar_campos(titulo, data_inicio, data_termino, num_vagas)
        disciplina = Disciplina(
            id=self._proximo_id,
            titulo=titulo,
            data_inicio=data_inicio,
            data_termino=data_termino,
            num_vagas=num_vagas,
            e_verao=e_verao,
        )
        self._disciplinas[self._proximo_id] = disciplina
        self._proximo_id += 1
        return disciplina

    # ------------------------------------------------------------------
    # READ
    # ------------------------------------------------------------------
    def buscar_por_id(self, id: int) -> Disciplina:
        if id not in self._disciplinas:
            raise DisciplinaError(f"Disciplina com id={id} não encontrada.")
        return self._disciplinas[id]

    def listar_todas(self) -> list[Disciplina]:
        return list(self._disciplinas.values())

    # ------------------------------------------------------------------
    # UPDATE
    # ------------------------------------------------------------------
    def atualizar(
        self,
        id: int,
        titulo: Optional[str] = None,
        data_inicio: Optional[date] = None,
        data_termino: Optional[date] = None,
        num_vagas: Optional[int] = None,
        e_verao: Optional[bool] = None,
    ) -> Disciplina:
        disciplina = self.buscar_por_id(id)

        novo_titulo = titulo if titulo is not None else disciplina.titulo
        nova_inicio = data_inicio if data_inicio is not None else disciplina.data_inicio
        nova_termino = data_termino if data_termino is not None else disciplina.data_termino
        novas_vagas = num_vagas if num_vagas is not None else disciplina.num_vagas
        novo_verao = e_verao if e_verao is not None else disciplina.e_verao

        self._validar_campos(novo_titulo, nova_inicio, nova_termino, novas_vagas)

        disciplina.titulo = novo_titulo
        disciplina.data_inicio = nova_inicio
        disciplina.data_termino = nova_termino
        disciplina.num_vagas = novas_vagas
        disciplina.e_verao = novo_verao

        return disciplina

    # ------------------------------------------------------------------
    # DELETE
    # ------------------------------------------------------------------
    def deletar(self, id: int) -> None:
        if id not in self._disciplinas:
            raise DisciplinaError(f"Disciplina com id={id} não encontrada.")
        del self._disciplinas[id]

    # ------------------------------------------------------------------
    # Validações internas
    # ------------------------------------------------------------------
    def _validar_campos(
        self,
        titulo: str,
        data_inicio: date,
        data_termino: date,
        num_vagas: int,
    ) -> None:
        if not titulo or not titulo.strip():
            raise DisciplinaError("O título não pode ser vazio.")
        if data_termino < data_inicio:
            raise DisciplinaError("A data de término não pode ser anterior à data de início.")
        if num_vagas <= 0:
            raise DisciplinaError("O número de vagas deve ser maior que zero.")
