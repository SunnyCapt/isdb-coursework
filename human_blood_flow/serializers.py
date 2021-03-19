from rest_framework.serializers import HyperlinkedModelSerializer, ModelSerializer

from human_blood_flow.models import *


class HumanWealthLvlSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = HumanWealthLvl
        fields = ('lvl', 'description')


class HumanActivitySerializer(HyperlinkedModelSerializer):
    class Meta:
        model = HumanActivity
        fields = ('shortname', 'description')


class HumanRoleSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = HumanRole
        fields = ('shortname', 'description')


class SubstanceSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = Substance
        fields = ('shortname', 'description', 'harmfulness')


class OrganismStatusSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = OrganismStatus
        fields = ('shortname', 'description')


class BiologicalSystemSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = BiologicalSystem
        fields = ('shortname',)


class BloodCellSerializer(HyperlinkedModelSerializer):
    place = BiologicalSystemSerializer(read_only=True)

    class Meta:
        model = BloodCell
        fields = ('place', 'cell_type')


class CirculatorySystemSerializer(HyperlinkedModelSerializer):
    substances = SubstanceSerializer(many=True, read_only=True)
    blood_cells = BloodCellSerializer(many=True, read_only=True)

    class Meta:
        model = CirculatorySystem
        fields = ('speed', 'substances', 'blood_cells')


class OrganismSerializer(HyperlinkedModelSerializer):
    circulatory_system = CirculatorySystemSerializer(read_only=True)
    status = OrganismStatusSerializer(read_only=True)

    class Meta:
        model = Organism
        fields = (
            'circulatory_system', 'status', 'date_to_die',
            'birthday', 'sex', 'weight', 'height', 'url'
        )


class HumanSerializer(ModelSerializer):
    organism = OrganismSerializer(read_only=True)
    wealth = HumanWealthLvlSerializer(read_only=True)
    activity = HumanActivitySerializer(read_only=True)
    role = HumanRoleSerializer(read_only=True)

    class Meta:
        model = Human
        fields = ('organism', 'wealth', 'activity', 'role', 'first_name', 'last_name', 'url')


class ActionSerializer(HyperlinkedModelSerializer):
    class Meta:
        model = Action
        fields = ('action_name', 'cause')
