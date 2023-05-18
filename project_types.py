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
