from django.urls import path


from . import views


urlpatterns = [
    path("",views.getRoutes),
    path("all_notes/", views.getNotes),
    path("note/<str:pk>/", views.getNote),
    path("create_note/", views.createNote),
    path("update_note/<str:pk>/",views.updateNote),
    path("delete_note/<str:pk>/", views.deleteNote),

]