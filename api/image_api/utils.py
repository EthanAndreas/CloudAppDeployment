import random
import string

alphabet = string.ascii_lowercase + string.ascii_uppercase + string.digits
id_length = 8


def random_id() -> str:
    """Generate a random id"""
    return "".join(random.choices(alphabet, k=id_length))


def valid_id(id: str) -> bool:
    """Check if an id has a valid shape"""
    if len(id) != id_length:
        return False

    if any(c not in alphabet for c in id):
        return False

    return True


__all__ = ["random_id", "valid_id"]
