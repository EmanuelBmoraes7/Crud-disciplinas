"""
conftest.py — torna as fixtures disponíveis para todos os testes.
"""
import pytest
from app.disciplinas import GerenciadorDisciplinas


@pytest.fixture
def gerenciador():
    return GerenciadorDisciplinas()


@pytest.fixture
def contexto():
    return {}
