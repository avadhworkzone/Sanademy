import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sanademy/view/homeScreen/home_screen.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async {
  print('title--${message.notification?.title}');
  print('body--${message.notification?.body}');
}
Future<void> handleMessage(RemoteMessage? message) async {
  if(message == null) return;
  Get.to(const HomeScreen());
}

Future<void> initPushNotification()async {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
}
class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print('fCMToken***$fCMToken');
    initPushNotification();
  }
}