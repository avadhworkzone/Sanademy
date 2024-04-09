import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sanademy/commonWidget/loading_spinner.dart';
import 'package:sanademy/localization/translations.dart';
import 'package:sanademy/networks/services/connectivity_service.dart';
import 'package:sanademy/utils/app_class.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_theme.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/splashScreen/splash_screen.dart';

import 'view_model/auth_controller/sign_up_controller.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    connectivityViewModel.startMonitoring();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppTheme.designSize,
     builder: (context, child) {
       return GetMaterialApp(
         enableLog: true,
         debugShowCheckedModeBanner: false,
         theme: ThemeData(fontFamily: AppConstants.quicksand, useMaterial3: true,
             scaffoldBackgroundColor: AppColors.white, pageTransitionsTheme: const PageTransitionsTheme()),
         transitionDuration: const Duration(milliseconds: 100),
         translations: Translation(),
         locale: const Locale('en_US'),
         fallbackLocale: const Locale('en_US'),
         builder: (context, widget) => ColoredBox(
           color: AppColors.white,
           child: NotificationListener<OverscrollIndicatorNotification>(
             onNotification: (OverscrollIndicatorNotification overscroll) {
               overscroll.disallowIndicator();
               return true;
             },
             child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), child: getMainAppViewBuilder(context, widget)),
           ),
         ),
         home: Obx(
                 () => connectivityViewModel.isOnline!=null?connectivityViewModel.isOnline!.value?
         const SplashScreen():const Text('No Internet'):const SizedBox()),
       );
     },
    );
  }

  final connectivityViewModel = Get.put(ConnectivityViewModel());

  SignUpController signUpController = Get.put(SignUpController());
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
                  color: AppColors.white.withOpacity(0.3),
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