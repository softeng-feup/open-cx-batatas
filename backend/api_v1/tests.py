"""
Tests for api_v1.
"""
from django.test import TestCase
from django.urls import reverse
from django.contrib.auth import authenticate, password_validation
from django.core.exceptions import ValidationError
from rest_framework.test import APIClient
from rest_framework import status
from rest_framework.authtoken.models import Token

class TestCreateAccountEndpoint(TestCase):
    """
    Tests for the create account endpoint.
    """
    def setUp(self):
        self.user1 = {
            'email': 'johndoe@example.com',
            'first_name': 'john',
            'last_name': 'doe',
            'username': 'johndoe',
            'password': 'thatSUPERsafePASSWORD123'
        }

    def test_successful_creation(self):
        """
        Tests if creating a new account works.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = authenticate(username=self.user1['email'], password=self.user1['password'])
        self.assertNotEqual(user, None)
        key_owner = Token.objects.get(key=response.json()['token']).user
        self.assertEqual(user, key_owner)

    def test_only_post_method(self):
        """
        Tests if the endpoint only allows
        POST requests.
        """
        client = APIClient()
        response = client.get(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        response = client.put(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        response = client.patch(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        response = client.delete(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        response = client.head(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)

    def test_missing_arguments(self):
        """
        Tests if warnings are given, if the
        arguments are missing.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), {}, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.json()['email'], ['This field is required.'])
        self.assertEqual(response.json()['first_name'], ['This field is required.'])
        self.assertEqual(response.json()['last_name'], ['This field is required.'])
        self.assertEqual(response.json()['username'], ['This field is required.'])
        self.assertEqual(response.json()['password'], ['This field is required.'])
        user = authenticate(username=self.user1['email'], password=self.user1['password'])
        self.assertEqual(user, None)

    def test_password_validation(self):
        """
        Tests if password validation is implemented.
        """
        client = APIClient()
        info = self.user1
        info['password'] = "1"
        response = client.post(reverse('create-account'), info, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        try:
            password_validation.validate_password(info['password'])
        except ValidationError as error:
            self.assertEqual(response.json()['password'], error.messages)

    def test_password_hashed(self):
        """
        Tests if the password was hashed.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = authenticate(username=self.user1['email'], password=self.user1['password'])
        self.assertNotEqual(user, None)
        self.assertFalse(user.check_password('123'))
        self.assertFalse(user.check_password(user.password)) # test with stored value
        self.assertTrue(user.check_password(self.user1['password']))

    def test_email_unique(self):
        """
        Tests if email is considered unique.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.json()['email'], ['user with this email address already exists.'])

    def test_username_unique(self):
        """
        Tests if username is considered unique.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.json()['username'], ['user with this username already exists.'])

    def test_first_name_titled(self):
        """
        Tests if first_name was titled.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = authenticate(username=self.user1['email'], password=self.user1['password'])
        self.assertNotEqual(user, None)
        user_first_name = Token.objects.get(key=response.json()['token']).user.first_name
        self.assertEqual(user_first_name, self.user1['first_name'].title())

    def test_last_name_titled(self):
        """
        Tests if last_name was titled.
        """
        client = APIClient()
        response = client.post(reverse('create-account'), self.user1, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = authenticate(username=self.user1['email'], password=self.user1['password'])
        self.assertNotEqual(user, None)
        user_last_name = Token.objects.get(key=response.json()['token']).user.last_name
        self.assertEqual(user_last_name, self.user1['last_name'].title())
