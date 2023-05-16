import completude
import json
import unittest


class test_get_completude(unittest.TestCase):
    def test(self):
        test_cases = [
            {
                "campos":  {
                    "nome": "nome1",
                    "tipo": "OU EXCLUSIVO",
                    "atributos": [
                            {
                                "nome": "nome2",
                                "tipo": "OU INCLUSIVO",
                                "atributos": []
                            },
                        {
                                "nome": "nome3",
                                "tipo": "OU INCLUSIVO",
                                "atributos": []
                            }
                    ]
                },
                "item": {
                    "nome": "nome1",
                    "valores": [
                        {
                            "nome": "nome2",
                            "valor": "vitor",
                            "atributos": []
                        },
                        {
                            "nome": "nome2",
                            "valor": "pedro",
                            "atributos": []
                        },
                    ]
                },
                "resposta_esperada": {
                    "nome": "nome1",
                    "tipo": "OU EXCLUSIVO",
                    "completo": False,
                    "valores": [
                        {
                            "nome": "nome2",
                            "tipo": "OU INCLUSIVO",
                            "atributos": []
                        },
                        {
                            "nome": "nome3",
                            "tipo": "OU INCLUSIVO",
                            "atributos": []
                        }
                    ]
                }
            }
        ]

        for case in test_cases:
            resposta = completude.get_completude(case["item"], case["campos"])
            print("teste passou!")
            self.assertDictEqual(resposta, case["resposta_esperada"])


if __name__ == "__main__":
    unittest.main()
