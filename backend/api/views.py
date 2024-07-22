from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serialisers import NoteSerialiser
from .models import Note


@api_view(["GET"])
def getRoutes(request):
    routes = [
        {
            "EndPoint":"ABC",
            "method":"METHOD"
        },
        {
            "EndPoint":"DEF",
            "method":"METHOD 2"
        }


    ]

    return Response(routes)





@api_view(["GET"])
def getNotes(request):

    notes = Note.objects.all()


    serialiser = NoteSerialiser(notes, many = True)

    return Response(serialiser.data)



@api_view(["GET"])
def getNote(request, pk):

    note = Note.objects.get(id=pk)


    serialiser = NoteSerialiser(note)

    return Response(serialiser.data)


@api_view(["POST"])
def createNote(request):

    data = request.data


    note = Note.objects.create(
        body = data["body"]
    )

    serialiser = NoteSerialiser(note, many = False)

    return Response(serialiser.data)


@api_view(["PUT"])
def updateNote(request, pk):

    data = request.data


    note = Note.objects.get(id=pk)

    serialiser = NoteSerialiser(note, data = request.data)

    if serialiser.is_valid():
        serialiser.save()

         

    return Response(serialiser.data)





@api_view(["DELETE"])
def deleteNote(request, pk):
    
    note = Note.objects.get(id=pk)
    Note.delete(note)

 
    return Response("NOTE WAS DELETED")






