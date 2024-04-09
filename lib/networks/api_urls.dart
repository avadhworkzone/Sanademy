class ApiUrls {
  /// ----------------- BASE URL START -----------------------
  static const String baseURL = 'https://reqres.in';

  static Map<String, String> getHeaders() {
    final headers = {
      'headers': {'Authorization': 'Bearer ABCD'},
    };

    return headers['headers']!;
  }

  /// ----------------- BASE URL END -----------------------
  static const String logIn = '/api/login';
  static const String userList = '/api/users?page=2';
}
