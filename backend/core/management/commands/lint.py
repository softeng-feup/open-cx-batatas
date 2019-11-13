"""
Custom management commands for the core app.
"""
import os
import sys
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    """
    Runs pylint on the project, with our apps.
    """
    help = 'Runs the linter on the project'

    def handle(self, *args, **kwargs): # pylint: disable=unused-argument
        code = os.system('pylint --load-plugins pylint_django core/ api_v1/ backend/')
        if os.WEXITSTATUS(code) != 0:
            sys.exit(1)
