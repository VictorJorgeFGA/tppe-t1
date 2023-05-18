import pytest

from project_types import Leaf, Name


@pytest.mark.parametrize("element, is_complete",[
    (Leaf("CPF","111.111.111-11"),True),
    (Leaf("CPF",""),False),

    (Leaf("Matricula","11/1111111"),True),
    (Leaf("Matricula",""),False),

    (Leaf("Sexo","M"),True),
    (Leaf("Sexo",""),False),

    (Leaf("Email","jorge@email.com"),True),
    (Leaf("Email",""),False),

    (Leaf("PrimeiroNome","Andre"),True),
    (Leaf("PrimeiroNome",""),False),

    (Leaf("NomeMeio","Rodrigues"),True),
    (Leaf("NomeMeio",""),False),

    (Leaf("UltimoNome","Santos"),True),
    (Leaf("UltimoNome",""),False),
])
def test_get_completute_leaf(element: Leaf, is_complete: bool):
    assert element.get_completude() == is_complete
