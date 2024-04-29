class ApiUrls {
  /// ----------------- BASE URL START -----------------------
  // static const String baseURL = 'https://reqres.in';
  static const String baseURL =
      'https://codeyesinfotech.com/sana_academy/public/api/';

  static Map<String, String> getHeaders() {
    final headers = {
      'headers': {'Authorization': 'Bearer ABCD'},
    };

    return headers['headers']!;
  }

  /// ----------------- BASE URL END -----------------------
  static const String logIn = 'login';
  static const String userList = 'api/users?page=2';
  static const String register = 'register';
}
