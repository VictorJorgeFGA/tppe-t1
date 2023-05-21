import pytest

from project_types import Leaf, Name, Person


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

@pytest.mark.parametrize("name, is_complete",[
    (Name("Andre","Santos","Rodrigues","or"),True),
    (Name("Andre","Santos","Rodrigues","xor"),True),

    (Name("","","","xor"),False),
    (Name("","","","or"),False),

    (Name("Andre","","","or"),True),
    (Name("","Santos","","or"),True),
    (Name("","","Rodrigues","or"),True),

    (Name("Andre","","","xor"),True),
    (Name("","Santos","","xor"),True),

    (Name("Andre","Santos","","xor"),False),
    (Name("Andre","","Rodrigues","xor"),False),
])
def test_get_completute_name(name: Name, is_complete: bool):
    assert name.get_completude() == is_complete



@pytest.mark.parametrize("person, is_complete",[
    (Person(Name("Andre","Santos","Rodrigues","or"),"333.333.333-33","M","andre.santos@gmail.com", "or"), True)
])
def test_get_completute_person(person: Person, is_complete: bool):
    assert person.get_completude() == is_complete
