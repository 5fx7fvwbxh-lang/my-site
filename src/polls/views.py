from django.http import HttpResponse


def index(request):
    """View function for the index page of the Polls app."""
    return HttpResponse("Hello, world. You're at the polls index.")
