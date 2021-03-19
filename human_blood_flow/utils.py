import random

from .models import Human


def do_something_with_human(human: Human):
    if random.random() > 0.5:
        new = (human.organism.circulatory_system.speed + random.randint(-40, 40)) % 100
        human.organism.circulatory_system.speed = abs(new)
        human.organism.circulatory_system.save(update_fields=['speed'])
