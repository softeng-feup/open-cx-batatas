class Constants {
  static const String Edit = 'Edit';
  static const String Logout = 'Logout';

  static const List<String> settingsOptions = <String>[Edit, Logout];
}

const String API_URL = 'http://diogo98s.pythonanywhere.com/api/v1/';

enum MapPageState {LOADING, NO_LOCATION_PERM, READY}

const String locationMissingStr = 'To use the bluetooth positioning system, please enable the location permission';

