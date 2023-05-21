from __future__ import annotations

class Leaf:
    """
    Basic data type for analise if an atribute is complete.
    """
    def __init__(self, name: str = "", value: str = "") -> None:
        self.name = name
        self.value = value

    def get_completude(self) -> bool:
        """
        Obtain if leaf is complete or not.
        """
        return True if len(self.value) > 0 else False

class Name:
    def __init__(self, first_name: str = "", middle_name: str = "", last_name :str = "", type_completude: str = "or"):
        self.first_name = first_name
        self.middle_name = middle_name
        self.last_name = last_name

        self.type_completude = type_completude

    def get_completude(self):
        if self.type_completude == "xor":
            return self.first_name.get_completude() ^ self.middle_name.get_completude() ^ self.last_name.get_completude()
        return self.first_name.get_completude() | self.middle_name.get_completude() | self.last_name.get_completude()

    @property
    def first_name(self):
        return self._first_name

    @first_name.setter
    def first_name(self, value):
        self._first_name = Leaf("FirstName",value)

    @property
    def middle_name(self):
        return self._middle_name

    @middle_name.setter
    def middle_name(self, value):
        self._middle_name = Leaf("MiddleName",value)

    @property
    def last_name(self):
        return self._last_name

    @last_name.setter
    def last_name(self, value):
        self._last_name = Leaf("LastName",value)

    @property
    def type_completude(self):
        return self._type_completude

    @type_completude.setter
    def type_completude(self, value):
        if value in "xor":
            self._type_completude = value
        else:
            raise ValueError("Type completude must be one of the following options: xor, or.")

class Person:
    def __init__(self, name : Name = Name(), cpf : str = "", matricula : str = "", sexo: str = "", email : str = "", type_completude="or"):
        self.name = name
        self.cpf = cpf
        self.matricula = matricula
        self.sexo = sexo
        self.email = email
        self.type_completude = type_completude


    def get_completude(self):
        return True

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def cpf(self):
        return self._cpf

    @cpf.setter
    def cpf(self, value):
        self._cpf = Leaf("CPF",value)

    @property
    def matricula(self):
        return self._matricula

    @matricula.setter
    def matricula(self, value):
        self._matricula = Leaf("matricula", value)

    @property
    def sexo(self):
        return self._sexo

    @sexo.setter
    def sexo(self, value):
        self._sexo = Leaf("sexo", value)

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = Leaf("email", value)

    @property
    def type_completude(self):
        return self._type_completude

    @type_completude.setter
    def type_completude(self, value):
        if value in "xor":
            self._type_completude = value
        else:
            raise ValueError("Type completude must be one of the following options: xor, or.")
