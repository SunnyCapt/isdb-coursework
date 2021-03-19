from time import time

from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.decorators.csrf import csrf_protect
from rest_framework.permissions import IsAuthenticated
from rest_framework.viewsets import ModelViewSet

from human_blood_flow.models import HumanWealthLvl, HumanActivity, HumanRole, Human, OrganismStatus, Organism, \
    Substance, CirculatorySystem, BiologicalSystem, BloodCell, Action
from human_blood_flow.serializers import HumanWealthLvlSerializer, HumanActivitySerializer, HumanRoleSerializer, \
    HumanSerializer, OrganismStatusSerializer, SubstanceSerializer, CirculatorySystemSerializer, \
    BiologicalSystemSerializer, BloodCellSerializer, ActionSerializer, OrganismSerializer
from .utils import do_something_with_human


@csrf_protect
def index(request, *args, **kwargs):
    if not request.user.is_authenticated:
        return redirect(reverse('rest_framework:login'))

    context = {'now': int(time())}
    return render(request, 'index.html', context)


class HumanWealthLvlView(ModelViewSet):
    queryset = HumanWealthLvl.objects.all()
    serializer_class = HumanWealthLvlSerializer
    permission_classes = [IsAuthenticated]


class HumanActivityView(ModelViewSet):
    queryset = HumanActivity.objects.all()
    serializer_class = HumanActivitySerializer
    permission_classes = [IsAuthenticated]


class HumanRoleView(ModelViewSet):
    queryset = HumanRole.objects.all()
    serializer_class = HumanRoleSerializer
    permission_classes = [IsAuthenticated]


class HumanView(ModelViewSet):
    queryset = Human.objects.all()
    serializer_class = HumanSerializer
    permission_classes = [IsAuthenticated]
    search_fields = ['first_name', 'last_name']

    def retrieve(self, *args, **kwargs):
        instance = self.get_object()
        do_something_with_human(instance)
        return super(HumanView, self).retrieve(*args, **kwargs)


class OrganismStatusView(ModelViewSet):
    queryset = OrganismStatus.objects.all()
    serializer_class = OrganismStatusSerializer
    permission_classes = [IsAuthenticated]


class OrganismView(ModelViewSet):
    queryset = Organism.objects.all()
    serializer_class = OrganismSerializer
    permission_classes = [IsAuthenticated]


class SubstanceView(ModelViewSet):
    queryset = Substance.objects.all()
    serializer_class = SubstanceSerializer
    permission_classes = [IsAuthenticated]


class CirculatorySystemView(ModelViewSet):
    queryset = CirculatorySystem.objects.all()
    serializer_class = CirculatorySystemSerializer
    permission_classes = [IsAuthenticated]


class BiologicalSystemView(ModelViewSet):
    queryset = BiologicalSystem.objects.all()
    serializer_class = BiologicalSystemSerializer
    permission_classes = [IsAuthenticated]


class BloodCellView(ModelViewSet):
    queryset = BloodCell.objects.all()
    serializer_class = BloodCellSerializer
    permission_classes = [IsAuthenticated]


class ActionView(ModelViewSet):
    queryset = Action.objects.all()
    serializer_class = ActionSerializer
    permission_classes = [IsAuthenticated]
