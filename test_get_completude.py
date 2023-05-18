import pytest

from completude import get_completude_leaf
from project_types import leaf


@pytest.mark.parametrize("element, is_complete",[
    (leaf("CPF","111.111.111-11"),True),
    (leaf("CPF",""),False),

    (leaf("Matricula","11/1111111"),True),
    (leaf("Matricula",""),False),

    (leaf("Sexo","M"),True),
    (leaf("Sexo",""),False),

    (leaf("Email","jorge@email.com"),True),
    (leaf("Email",""),False),

    (leaf("PrimeiroNome","Andre"),True),
    (leaf("PrimeiroNome",""),False),

    (leaf("NomeMeio","Rodrigues"),True),
    (leaf("NomeMeio",""),False),

    (leaf("UltimoNome","Santos"),True),
    (leaf("UltimoNome",""),False),
])
def test_get_completute_leaf(element: leaf, is_complete: bool):
    assert get_completude_leaf(element) == is_complete
