import datetime

from django.core.validators import MaxValueValidator
from django.db import models

from .managers import HumanManager, SubstanceManager


class HumanWealthLvl(models.Model):
    lvl = models.PositiveIntegerField(default=10, validators=[MaxValueValidator(100)])
    description = models.CharField(null=True, max_length=128)

    def __str__(self):
        return f'<{self.lvl} [{self.id}]>'


class HumanActivity(models.Model):
    shortname = models.CharField(max_length=32)
    description = models.CharField(null=True, max_length=256)

    def __str__(self):
        return f'<{self.shortname} [{self.id}]>'


class HumanRole(models.Model):
    shortname = models.CharField(max_length=32)
    description = models.CharField(null=True, max_length=256)

    def __str__(self):
        return f'<{self.shortname} [{self.id}]>'


class Human(models.Model):
    first_name = models.CharField(max_length=32)
    last_name = models.CharField(max_length=32)
    wealth = models.ForeignKey(HumanWealthLvl, null=True, on_delete=models.SET_NULL)
    activity = models.ForeignKey(HumanActivity, null=True, on_delete=models.SET_NULL)
    role = models.ForeignKey(HumanRole, null=True, on_delete=models.SET_NULL)

    objects = HumanManager()

    @property
    def fullname(self):
        return f'{self.first_name} {self.last_name}'

    def __str__(self):
        return f'<{self.fullname} [{self.id}]>'


class OrganismStatus(models.Model):
    shortname = models.CharField(max_length=32)
    description = models.CharField(null=True, max_length=256)

    def __str__(self):
        return f'<{self.shortname} [{self.id}]>'


class Organism(models.Model):
    class SexChoices(models.TextChoices):
        man = 'man', 'man'
        woman = 'woman', 'woman'

    owner = models.OneToOneField(Human, related_name='organism', on_delete=models.CASCADE)
    birthday = models.DateField(
        default=datetime.date(year=1991, month=1, day=1)
    )
    date_to_die = models.DateField()
    sex = models.CharField(max_length=5, choices=SexChoices.choices)
    weight = models.PositiveIntegerField(default=60)
    height = models.PositiveIntegerField(default=180)
    status = models.OneToOneField(OrganismStatus, null=True, on_delete=models.SET_NULL)

    def __str__(self):
        return f'<{self.owner.fullname}\'s organism: {self.status} [{self.date_to_die}][{self.id}]>'


class Substance(models.Model):
    shortname = models.CharField(max_length=32)
    description = models.CharField(null=True, max_length=256)
    harmfulness = models.PositiveIntegerField(default=0, validators=[MaxValueValidator(100)])

    objects = SubstanceManager()

    def __str__(self):
        return f'<{self.shortname}: {self.harmfulness} [{self.id}]>'


class CirculatorySystem(models.Model):
    organism = models.OneToOneField(Organism, related_name='circulatory_system', on_delete=models.CASCADE)
    speed = models.PositiveIntegerField(default=228, validators=[MaxValueValidator(1488)])
    substances = models.ManyToManyField(Substance, blank=True)

    def __str__(self):
        return f'<{self.organism.owner.fullname}\'s organism: {self.speed} [{self.id}]>'


class BiologicalSystem(models.Model):
    shortname = models.CharField(max_length=32)

    def __str__(self):
        return f'<{self.shortname} [{self.id}]>'


class BloodCell(models.Model):
    class BloodCellTypeChoices(models.TextChoices):
        erythrocyte = 'erythrocytes', 'erythrocytes'
        leukocytes = 'leukocytes', 'leukocytes'
        thrombocyte = 'thrombocyte', 'thrombocyte'

    cell_type = models.CharField(max_length=32, choices=BloodCellTypeChoices.choices)
    place = models.ForeignKey(BiologicalSystem, null=True, on_delete=models.SET_NULL)
    circulatory_system = models.ForeignKey(
        CirculatorySystem, null=True, on_delete=models.CASCADE,
        related_name='blood_cells'
    )

    def __str__(self):
        return f'<{self.cell_type} in {self.place} of {self.circulatory_system.organism.owner.fullname} [{self.id}]>'


class Action(models.Model):
    action_name = models.CharField(max_length=32)
    target = models.ForeignKey(Human, on_delete=models.CASCADE)
    cause = models.CharField(max_length=128, null=True)

    def __str__(self):
        return f'<{self.target.fullname}: {self.action_name} [{self.cause}][{self.id}]>'
