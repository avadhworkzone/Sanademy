import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanademy/commonWidget/loading_spinner.dart';
import 'package:sanademy/localization/translations.dart';
import 'package:sanademy/networks/services/connectivity_service.dart';
import 'package:sanademy/networks/services/firebase_api.dart';
import 'package:sanademy/utils/app_class.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_theme.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/general/no_internet_screen.dart';
import 'package:sanademy/view/splashScreen/splash_screen.dart';

import 'view_model/profile_screen_view_model.dart';
import 'view_model/sign_up_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBEnkadOiG18SEFFU7MEaHiNIEhmlmm0bg',
          appId: '1:823204851962:android:486d28ffa08340476a9943',
          messagingSenderId: '823204851962',
          projectId: 'sana-academy',
          storageBucket: 'sana-academy.appspot.com'));
  await FirebaseApi().initNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    connectivityViewModel.startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: ScreenUtilInit(
        designSize: AppTheme.designSize,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: GetMaterialApp(
              enableLog: true,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  // fontFamily: AppConstants.metropolis,
                  // useMaterial3: true,
                  // scaffoldBackgroundColor: AppColors.whitef7,
                  // scaffoldBackgroundColor: AppColors.white,
                  pageTransitionsTheme: const PageTransitionsTheme()),
              transitionDuration: const Duration(milliseconds: 100),
              translations: Translation(),
              locale: SharedPreferenceUtils.getLangCode() == 'ar'
                  ? const Locale('ar', 'SA')
                  : const Locale('en', 'US'),
              fallbackLocale: SharedPreferenceUtils.getLangCode() == 'ar'
                  ? const Locale('ar', 'SA')
                  : const Locale('en', 'US'),
              // locale:  Locale(myLan),
              // fallbackLocale:  Locale(myLan,),
              builder: (context, widget) => ColoredBox(
                color: AppColors.white,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: getMainAppViewBuilder(context, widget)),
                ),
              ),
              // home: Obx(() => connectivityViewModel.isOnline != null
              //     ? connectivityViewModel.isOnline!.value
              //         ? const SplashScreen()
              //         // ? const LanguageScreen()
              //         // ? const BottomBar()
              //         : const NoInterNetScreen()
              //     : const SizedBox()),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }

  final connectivityViewModel = Get.put(ConnectivityViewModel());
  final signUpViewModel = Get.put(SignUpViewModel());
}

/// Create main app view builder
Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
  return Stack(
    children: [
      Obx(() {
        return IgnorePointer(
          ignoring: AppClass().isShowLoading.isTrue,
          child: Stack(
            children: [
              widget ?? const Offstage(),
              if (AppClass().isShowLoading.isTrue)
                ColoredBox(
                  color: AppColors.red.withOpacity(0.6),
                  child: const Center(
                    child: LoadingSpinner(),
                  ),
                )
            ],
          ),
        );
      })
    ],
  );
}
