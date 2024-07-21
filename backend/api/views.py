from rest_framework.decorators import api_view
from rest_framework.response import Response

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

   
