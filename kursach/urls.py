"""kursach URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

from human_blood_flow.urls import router as human_blood_flow_router
from human_blood_flow.views import index as index_view

urlpatterns = [
    path('', index_view, name='index'),
    path('', include('rest_framework.urls', namespace='rest_framework')),
    path('api/', include(human_blood_flow_router.urls)),
    path('admin/', admin.site.urls)
]
