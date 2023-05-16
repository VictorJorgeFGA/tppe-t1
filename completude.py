import json


def read_json(file: str):
    with open(file) as f:
        return json.loads(f.read())


def run_cases_get_completude():
    # Note como isso é só pra ver o que a função faz
    # e NÃO é um teste.
    cases = [
        'caso1.json',
        'caso2.json',
        'caso3.json',
    ]
    for case in cases:
        structure = read_json(case)
        print(f"====== CASO '{case}' ======")
        print(json.dumps(get_completude(structure), indent=4))
        print("\n\n")


def get_completude(item: dict, campo: dict = None) -> bool:
    """
    Retorna a completude de uma estrutura de dados
    no formato da estrutura de dados original.

    A análise de completude é feita com base no
    arquivo campos.json.

    :param itens: dict
    :return: bool
    """
    if campo is None:
        campo = read_json('campos.json')

    if campo["nome"] != item["nome"]:
        raise Exception(
            f"Campo '{campo['nome']}' não encontrado na estrutura de dados.")

    solucao = {
        "nome": campo["nome"],
        "tipo": campo["tipo"],
        "completo": True,
    }

    if len(campo.get("atributos")) == 0:
        valor = item.get("valor")
        if valor is None:
            solucao["completo"] = False
        solucao["valor"] = valor
    else:
        solucao["valores"] = []

        for atributo in campo["atributos"]:
            for actual_attr in item["valores"]:
                if actual_attr["nome"] == atributo["nome"]:
                    solucao["valores"].append(
                        get_completude(actual_attr, atributo))

        if solucao["tipo"] == "OU EXCLUSIVO":
            if len(solucao["valores"]) != 1:
                solucao["completo"] = False
        if solucao["tipo"] == "OU INCLUSIVO":
            if len(solucao["valores"]) < 1:
                solucao["completo"] = False

    return solucao


# run_cases_get_completude()
