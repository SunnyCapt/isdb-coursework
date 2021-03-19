from typing import List

from django.db import models


# noinspection PyPep8Naming
class HumanManager(models.Manager):
    def getPossibleDeadPeople(self) -> List['Human']:
        return list(self.raw("select * from getPossibleDeadPeople()"))

    def getRichPeople(self) -> List['Human']:
        return list(self.raw("select * from getRichPeople()"))


# noinspection PyPep8Naming
class SubstanceManager(models.Manager):
    def getHumanSubstances(self, human) -> List['Substance']:
        if isinstance(human, int):
            human_id = human
        elif issubclass(human.__class__, models.Model) \
                and human.__class__.__name__ == 'Human':
            human_id = human.id
        else:
            raise ValueError(
                '[getSubstancesByHuman]: human arg must '
                'be int or Human instance'
            )

        return list(self.raw(f"select * from getSubstances({human_id})"))
