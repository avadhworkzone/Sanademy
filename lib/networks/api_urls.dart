import 'package:sanademy/utils/shared_preference_utils.dart';

class ApiUrls {
  /// ----------------- BASE URL START -----------------------
  // static const String baseURL = 'https://reqres.in';
  static const String baseURL = 'http://sanademy.net/api/';
  // 'https://sa.kurdios.com/';
  // 'https://sanademy.net/sanacademy/';
  // 'https://codeyesinfotech.com/sana_academy/public/api/';

  static Map<String, String> getHeaders() {
    final headers = {
      'headers': {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPreferenceUtils.getToken()}'
      },
    };

    return headers['headers']!;
  }

  /// ----------------- BASE URL END -----------------------
  static const String logIn = 'login';
  static const String userList = 'api/users?page=2';
  static const String register = 'register';
  static const String getProfile = 'get_profile';
  static const String updateProfile = 'update_profile';
  static const String aboutUs = 'about_us';
  static const String getInTouch = 'get_in_touch';
  static const String home = 'home';
  static const String contact = 'contact';
  static const String getExams = 'get_exams';
  static const String courseDetail = 'course_detail';
  static const String courseEnroll = 'course_enroll';
  static const String getCourseByCategory = 'get_course_by_category';
  static const String getQuestions = 'get_questions';
  static const String examResult = 'exam_result';
  static const String saveQuestionsAnswers = 'save_questions_answers';
  static const String getCourseProgress = 'get_course_progress';
  static const String saveCourseProgress = 'save_course_progress';
  static const String getNotification = 'notifications';
  static const String getCertificate = 'get_certificates';
  static const String requestHardCopy = 'request_hard_copy';
  static const String deleteUser = 'delete_user';

  ///NEW APIS
  static const String homeScreen = 'home-page';
  static const String courses = 'courses';
}
