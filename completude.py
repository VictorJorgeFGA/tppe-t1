from project_types import leaf


def get_completude_leaf(element: leaf) -> bool:
    return True if len(element.value) > 0 else False
