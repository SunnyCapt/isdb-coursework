from rest_framework import routers

from human_blood_flow.views import HumanWealthLvlView, HumanActivityView, HumanRoleView, HumanView, OrganismStatusView, \
    OrganismView, SubstanceView, CirculatorySystemView, BiologicalSystemView, BloodCellView, ActionView

router = routers.DefaultRouter()

router.register(r'human_wealth_lvl', HumanWealthLvlView)
router.register(r'human_activity', HumanActivityView)
router.register(r'human_role', HumanRoleView)
router.register(r'human', HumanView)
router.register(r'organism_status', OrganismStatusView)
router.register(r'organism', OrganismView)
router.register(r'substance', SubstanceView)
router.register(r'circulatory_system', CirculatorySystemView)
router.register(r'biological_system', BiologicalSystemView)
router.register(r'blood_cell', BloodCellView)
router.register(r'action', ActionView)
