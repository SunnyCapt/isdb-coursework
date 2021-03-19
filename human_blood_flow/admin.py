from django.contrib import admin
from human_blood_flow.models import *


@admin.register(HumanWealthLvl)
class HumanWealthLvlAdmin(admin.ModelAdmin):
    pass


@admin.register(HumanActivity)
class HumanActivityAdmin(admin.ModelAdmin):
    pass


@admin.register(HumanRole)
class HumanRoleAdmin(admin.ModelAdmin):
    pass


@admin.register(Human)
class HumanAdmin(admin.ModelAdmin):
    pass


@admin.register(OrganismStatus)
class OrganismStatusAdmin(admin.ModelAdmin):
    pass


@admin.register(Organism)
class OrganismAdmin(admin.ModelAdmin):
    pass


@admin.register(Substance)
class SubstanceAdmin(admin.ModelAdmin):
    pass


@admin.register(CirculatorySystem)
class CirculatorySystemAdmin(admin.ModelAdmin):
    pass


@admin.register(BiologicalSystem)
class BiologicalSystemAdmin(admin.ModelAdmin):
    pass


@admin.register(BloodCell)
class BloodCellAdmin(admin.ModelAdmin):
    pass


@admin.register(Action)
class ActionAdmin(admin.ModelAdmin):
    pass
