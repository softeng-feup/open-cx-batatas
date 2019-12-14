"""
Validators that useful.
"""
from django.core.validators import RegexValidator
from django.utils.translation import ugettext_lazy as _

USERNAME_VALIDATOR = RegexValidator(
    regex='^[a-z0-9]+$',
    message=(_('Username only allows lowercase letters and numbers')),
    code='invalid_username'
)

def has_special_chars(string):
    """
    Returns True if the string has special characters.
    """
    special_chars = r'0123456789~@#$^()_+=[]{}|\,.?: -]$)(?!.*[<>\'"/;`%'
    for char in special_chars:
        if char in string:
            return True
    return False
