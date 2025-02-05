import 'package:sanademy/utils/app_string.dart';

Map<String, String> ar = {
  // /// CREATE ACCOUNT SCREEN
  // AppStrings.enterYourName: 'ناوت چی یە؟',
  // AppStrings.titleTxt: 'أكاديمية سناء',
  // AppStrings.register: 'يسجل',
  // AppStrings.registerYourAccount: 'سجل حسابك وابدأ رحلتك التعليمية!',
  // AppStrings.dateFormat: 'سمم/ي ي/س س س س',
  // AppStrings.enterYourPhoneNumber: 'أدخل رقم هاتفك',
  // AppStrings.submit: 'يُقدِّم',
  //
  // /// OTP SCREEN
  // AppStrings.otpTxt: 'التحقق من OTP',
  // AppStrings.enterOtpTxt: 'الرجاء إدخال رمز التحقق المرسل إلى رقمك',
  // AppStrings.enterFourDigitOtp:
  //     'أدخل كلمة مرور لمرة واحدة (OTP) مكونة من 4 أرقام',
  // AppStrings.didNotGetOtp: 'لم تحصل على OTP؟',
  // AppStrings.resendOtp: 'إعادة إرسال كلمة المرور لمرة واحدة',
  // AppStrings.verify: 'يؤكد',
  // AppStrings.goBack: 'عُد',
  //
  // /// Login Screen
  // AppStrings.alreadyHaveAccount: 'هل لديك حساب؟',
  // AppStrings.signIn: "تسجيل الدخول",
  // AppStrings.notHaveAccount: "ليس لديك حساب؟",
  // AppStrings.signUp: "اشتراك",
  // AppStrings.changePhoneNumber: "غير رقم الهاتف",
  //
  // /// bottom bar
  // AppStrings.home: "بيت",
  // AppStrings.myProgress: "تقدمي",
  // AppStrings.myCertificate: "شهاداتي",
  // AppStrings.notification: "إشعارات",
  //
  // /// home screen
  // AppStrings.searchHere: "ابحث هنا",
  // AppStrings.categories: "فئات",
  // AppStrings.recommended: "مُستَحسَن",
  // AppStrings.viewAll: "عرض الكل",
  //
  // /// home recommended container
  // AppStrings.lectures: "محاضرات",
  // AppStrings.hours: "ساعات",
  // AppStrings.minutes: "دقائق",
  // AppStrings.noDataFound: 'لاتوجد بيانات',
  //
  // /// Description Screen
  // AppStrings.enrollNow: "تسجيل الآن",
  // AppStrings.description: "وصف",
  // AppStrings.requirements: "متطلبات",
  // AppStrings.whatWillYouLearn: "ما سوف تتعلم؟",
  // AppStrings.whoThisCourseIsFor: "لمن هذه الدورة؟",
  // AppStrings.getMoreCertificate: "احصل على المزيد من الشهادات",
  // AppStrings.downloadPDF: "تحميل PDF",
  // AppStrings.requestHartCopy: "طلب نسخة ورقية",
  // AppStrings.enrollSuccessfully: "تم التسجيل بنجاح!",
  // AppStrings.enrollSuccessfullyTxt: 'لقد قمت بالتسجيل بنجاح',
  // AppStrings.fundamentalTxt: '"أساسيات الرياضيات"',
  // AppStrings.instructor: 'مدرب',
  // AppStrings.yourExperience: 'سنوات من الخبرة:',
  // AppStrings.expertIn: 'خبير في:',
  // AppStrings.noOfStudents: 'خبير في:',
  // AppStrings.noOfCourses: 'عدد الدورات:',
  // AppStrings.courseContent: 'محتوى الدورة',
  // AppStrings.taskIncluded: 'المهام متضمنة',
  // AppStrings.certificates: 'الشهادات',
  //
  // /// payment option dialog
  // AppStrings.paymentOption: 'خيارات الدفع',
  // AppStrings.youCantPayThisPrice: 'لا يمكنك دفع هذا الثمن؟',
  // AppStrings.sendMsgOnWhatsApp: 'أرسل لنا رسالة على الواتساب',
  //
  // /// Menu Screen
  // AppStrings.currentBalance: 'الرصيد الحالي',
  // AppStrings.topUpYourBalance: 'قم بتعبئة رصيدك',
  // AppStrings.fastPay: 'الدفع السريع',
  // AppStrings.firstIraqiBank: 'البنك العراقي الأول',
  // AppStrings.mobileBalance: 'رصيد الجوال',
  // AppStrings.creditCard: 'بطاقة إئتمان',
  // AppStrings.contactUs: 'اتصل بنا',
  // AppStrings.aboutUs: 'معلومات عنا',
  // AppStrings.ourMission: 'مهمتنا',
  // AppStrings.ourVision: 'رؤيتنا',
  // AppStrings.logOut: 'تسجيل خروج',
  // AppStrings.deleteAccount: 'حذف الحساب',
  // AppStrings.logOutTxt: 'هل أنت متأكد أنك تريد تسجيل الخروج؟"',
  // AppStrings.deleteAccountTxt: 'هل أنت متأكد أنك تريد حذف الحساب؟',
  // AppStrings.yes: 'نعم',
  // AppStrings.no: 'لا',
  // AppStrings.reDirectOnWhatsAppMessage:
  //     'من فضلك اتصل بنا :\n+964 7509790444\n+964 7709790444\nمعرف المستخدم الخاص بي لأكاديمية سناء هو:',
  //
  // /// Contact Us Screen
  // AppStrings.getInTouch: 'ابقى على تواصل',
  // AppStrings.location: 'موقع',
  // AppStrings.phoneNumber: 'رقم التليفون',
  // AppStrings.emailAddress: 'عنوان البريد الإلكتروني',
  // AppStrings.writeUsDirectly: 'اكتب لنا مباشرة',
  // AppStrings.writeMessage: 'اكتب رسالة',
  // AppStrings.about: 'عن',
  //
  // /// Profile Screen
  // AppStrings.save: 'يحفظ',
  // AppStrings.profile: 'حساب تعريفي',
  // AppStrings.enterAddress: 'أدخل عنوانك',
  // AppStrings.connectWithFaceBook: 'تواصل مع الفيسبوك',
  // AppStrings.connectWithInstagram: 'تواصل مع إنستغرام',
  // AppStrings.pickProfilePicture: 'اختر صورة الملف الشخصي',
  // AppStrings.pickFromGallery: 'اختر من المعرض',
  // AppStrings.pickFromCamera: 'اختر من الكاميرا',
  //
  // /// my progress screen
  // AppStrings.progressIntroductionTxt:
  //     "في هذه الصفحة، يمكنك رؤية جميع الدورات التي قمت بالتسجيل فيها والتقدم الذي أحرزته في كل منها.",
  // AppStrings.complete: ' مكتمل',
  // AppStrings.remaining: ' متبقي',
  // AppStrings.noProgressAvailable: 'لا يوجد تقدم متاح',
  //
  // /// my certificate screen
  // AppStrings.certificate: 'شهاداتي',
  // AppStrings.certificateScreenTxt:
  //     "في هذه الصفحة، يمكنك رؤية جميع الشهادات الخاصة بك لإكمال كل دورة، أو اجتياز الاختبار في هذا المجال.",
  // AppStrings.pdfSuccessfullyDownload: 'تم تنزيل ملف pdf بنجاح',
  //
  // /// notification screen
  // AppStrings.notifications: 'إشعارات',
  // AppStrings.clearAll: "امسح الكل",
  //
  // /// exam Screen
  // AppStrings.exams: "الامتحانات",
  // AppStrings.examsScreenTxt:
  //     "في هذه الصفحة، يمكنك اختبار معرفتك في كل مجال، وربما الحصول على الشهادة.",
  // AppStrings.noExamAvailable: "لا توجد امتحانات متاحة",
  // AppStrings.pleaseCompleteYourExamTxt:
  //     "يرجى إكمال تقدمك بعد أن تتمكن من إجراء الاختبارات",
  //
  // /// questions screen
  // AppStrings.finishExam: "إنهاء الامتحان",
  // AppStrings.questions: "أسئلة",
  // AppStrings.of: "ل",
  // AppStrings.q: "س",
  // AppStrings.skip: "يتخطى",
  // AppStrings.next: "التالي",
  // AppStrings.writeHere: "اكتب هنا....",
  // AppStrings.pleaseEnterAnswer: "الرجاء إدخال الإجابة",
  // AppStrings.pleaseSelectAnyOption: "الرجاء تحديد أي خيار",
  //
  // /// congratulations screen
  // AppStrings.congratulations: "تهانينا!",
  // AppStrings.youHaveCompletedMathematicsMasteryTest:
  //     "لقد أكملت اختبار إتقان الرياضيات",
  // AppStrings.yourScore: "درجاتك",
  // AppStrings.yourTime: "وقتك",
  // AppStrings.yourAnswers: "أجوبتك",
  // AppStrings.viewSolution: "عرض الحل",
  // AppStrings.percentage: "نسبة مئوية",
  // AppStrings.result: "نتيجة",
  // AppStrings.continues: "يكمل",
  // AppStrings.pass: "يمر",
  //
  // /// solution screen
  // AppStrings.solution: "حلول",
  // AppStrings.yourAnswer: "إجابتك",
  // AppStrings.correctAnswer: "اجابة صحيحة",
  //
  // /// payment success dialog
  // AppStrings.thankYouTxt:
  //     'نشكرك على اهتمامك بالمشاركة في "اسم الدورة" بسعر هذه الدورة',
  // AppStrings.thankYouTxt2: 'يمكنك إجراء الدفع من خلال الخيارات أدناه',
  //
  // ///APP ERROR MESSAGE
  // AppStrings.emailIsRequired: "البريد الالكتروني مطلوب",
  // AppStrings.isRequired: '* مطلوب',
  // AppStrings.pleaseEnterOtp: 'الرجاء إدخال كلمة المرور',
  // AppStrings.pleaseEnterValidOtp: 'الرجاء إدخال كلمة مرور صالحة',
  // AppStrings.pleaseEnterSomeText: 'الرجاء إدخال بعض النص',
  // AppStrings.pleaseEnterMobileNumber: 'الرجاء إدخال رقم الجوال',
  // AppStrings.somethingWantWrong: 'هناك خطأ ما',
  //
  // ///k-dev Registration
  // AppStrings.name: 'اسم',
  // AppStrings.nameIsRequired: 'مطلوب اسم',
  // AppStrings.error: 'خطأ',
  // AppStrings.userCreatedSuccessfully: "تم إنشاء المستخدم بنجاح",
  // AppStrings.otpMismatch: "الرجاء إدخال كلمة مرور صالحة",
  //
  // ///---------------///
  // AppStrings.myBalance: 'رصيدي',
  // AppStrings.addBalance: 'إضافة الرصيد',
  // AppStrings.markAllRead: 'وضع علامة على الكل مقروءة',
  // AppStrings.testCertificate: 'الاختبارات والشهادات',
  // AppStrings.transactionHistory: 'تاريخ المعاملات',
  // AppStrings.inThisPageYourKnow:
  //     'في هذه الصفحة، يمكنك اختبار معرفتك في كل مجال، وربما الحصول على الشهادة.'

  /// CREATE ACCOUNT SCREEN
  AppStrings.enterYourName: "00",
  AppStrings.titleTxt: "ئەکادیمیای سنە",
  AppStrings.register: "تۆمارکردن",
  AppStrings.registerYourAccount:
      "ئەکاونتەکەت تۆمار بکە و دەست بە گەشتە پەروەردەییەکەت بکە!",
  AppStrings.dateFormat: "mm/dd/yyyy",
  AppStrings.yyyyMMdd: "yyyy/MM/dd",
  AppStrings.enterYourPhoneNumber: "ژمارەی تەلەفۆنەکەت بنووسە",
  AppStrings.submit: "پێشکەشکردن",

  /// OTP SCREEN
  AppStrings.otpTxt: "پشتڕاستکردنەوەی OTP",
  AppStrings.enterOtpTxt:
      "تکایە ئەو کۆدی پشتڕاستکردنەوە داخڵ بکە کە بۆ ژمارەکەت نێردراوە",
  AppStrings.enterFourDigitOtp: "OTP ی 4 ژمارەیی داخڵ بکە",
  AppStrings.didNotGetOtp: "OTP ی بەدەست نەهێنا؟",
  AppStrings.resendOtp: "دووبارە ناردنی OTP",
  AppStrings.verify: "سەلماندن",
  AppStrings.goBack: "بگەڕێوە دواوە",

  /// Login Screen
  AppStrings.alreadyHaveAccount: "پێشتر ئەکاونتت هەیە؟",
  AppStrings.signIn: "چوونەژوورەوە",
  AppStrings.notHaveAccount: "ئەکاونتت نییە؟",
  AppStrings.signUp: "ناوت تۆمار بکە",
  AppStrings.changePhoneNumber: "ژمارەی تەلەفۆن بگۆڕە",

  /// bottom bar
  AppStrings.home: "ماڵەوە",
  AppStrings.myProgress: "پێشکەوتنی من",
  AppStrings.myCertificate: "بڕوانامەکانم",
  AppStrings.notification: "ئاگادارکردنەوەکان",

  /// home screen
  AppStrings.searchHere: "لێرەدا بگەڕێ",
  AppStrings.categories: "پۆلەکان",
  AppStrings.recommended: "پێشنیاری کرد",
  AppStrings.viewAll: "بینینی هەموو",

  /// home recommended container
  AppStrings.lectures: "وتارەکان",
  AppStrings.hours: "کاتژمێر",
  AppStrings.minutes: "کۆنووس",
  AppStrings.noDataFound: 'هیچ داتایەک نەدۆزراوەتەوە',

  /// Description Screen
  AppStrings.enrollNow: "ئێستا ناوت تۆمار بکە",
  AppStrings.description: "وەسف",
  AppStrings.requirements: "پێداویستیەکان",
  AppStrings.whatWillYouLearn: "چی فێر دەبیت؟",
  AppStrings.whoThisCourseIsFor: "ئەم خولە بۆ کێیە؟",
  AppStrings.getMoreCertificate: "بڕوانامەی زیاتر بەدەست بهێنە",
  AppStrings.downloadPDF: "داگرتنی PDF",
  AppStrings.requestHartCopy: "داوای هارد کۆپی بکە",
  AppStrings.enrollSuccessfully: "ناوی تۆمار کرد بە سەرکەوتوویی!",
  AppStrings.enrollSuccessfullyTxt: 'تۆ بە سەرکەوتوویی ناوت تۆمار کردووە لە...',
  AppStrings.fundamentalTxt: '“بنەماکانی بیرکاری”',
  AppStrings.instructor: "ڕاهێنەر",
  AppStrings.yourExperience: "ئەزموونی ساڵانێک:",
  AppStrings.expertIn: "شارەزا لە:",
  AppStrings.noOfStudents: "ژمارەی خوێندکاران: ١.",
  AppStrings.noOfCourses: "نەخێر کۆرسەکان: ١.",
  AppStrings.courseContent: "ناوەڕۆکی کۆرسەکە",
  AppStrings.courseContentLectures: "وتارەکان",
  AppStrings.mins: "خولەک",
  AppStrings.ofText: "لە",
  AppStrings.taskIncluded: 'ئەرکەکانی لەگەڵدایە',
  AppStrings.certificates: 'بڕوانامە',

  /// payment option dialog
  AppStrings.paymentOption: "بژاردەی پارەدان",
  AppStrings.youCantPayThisPrice: "تۆ ناتوانی ئەم باجە بدەیت؟",
  AppStrings.sendMsgOnWhatsApp: "لە واتسئەپ نامەمان بۆ بنێرە",

  /// Menu Screen
  AppStrings.currentBalance: 'باڵانسی ئێستا',
  AppStrings.topUpYourBalance: 'باڵانسەکەت پڕ بکەرەوە',
  AppStrings.fastPay: 'فاست پەی',
  AppStrings.firstIraqiBank: 'بانکی یەکەمی عێراق',
  AppStrings.mobileBalance: 'باڵانسی مۆبایل',
  AppStrings.creditCard: 'کارتی بانکیی',
  AppStrings.contactUs: 'پەیوەندیمان پێوە بکەن',
  AppStrings.aboutUs: 'دەربارەی ئێمە',
  AppStrings.ourMission: 'ئەرکی ئێمە',
  AppStrings.ourVision: 'دیدگای ئێمە',
  AppStrings.logOut: 'دەرچوون',
  AppStrings.deleteAccount: 'سڕینەوەی ئەکاونت',
  AppStrings.logOutTxt: 'دڵنیای کە دەتەوێت دەربچیت؟"',
  AppStrings.deleteAccountTxt: 'دڵنیای کە دەتەوێت ئەکاونتەکە بسڕیتەوە؟',
  AppStrings.yes: 'بەڵێ',
  AppStrings.no: 'نەخێر',
  AppStrings.reDirectOnWhatsAppMessage:
      'Please Contact Us :\n+964 7509790444\n+964 7709790444\nMy user id for Sana Academy is:',

  /// Contact Us Screen
  AppStrings.getInTouch: 'پەیوەندی بکە',
  AppStrings.location: 'شوێن',
  AppStrings.phoneNumber: 'ژمارەی تەلەفۆن',
  AppStrings.emailAddress: 'ناونیشانی ئیمەیڵ',
  AppStrings.writeUsDirectly: 'ڕاستەوخۆ بۆمان بنووسە',
  AppStrings.writeMessage: 'پەیام بنووسە',
  AppStrings.about: 'دەربارەی',

  /// Profile Screen
  AppStrings.save: 'هەڵگرتن',
  AppStrings.profile: 'پرۆفایل',
  AppStrings.enterAddress: 'ناونیشانەکەت بنووسە',
  AppStrings.connectWithFaceBook: 'پەیوەندی بە فەیسبووکەوە بکە',
  AppStrings.connectWithInstagram: 'پەیوەندی لەگەڵ ئینستاگرام',
  AppStrings.pickProfilePicture: 'وێنەی پڕۆفایلی هەڵبژێرە',
  AppStrings.pickFromGallery: 'لە گەلەری هەڵبژێرە',
  AppStrings.pickFromCamera: 'لە کامێرا هەڵبژێرە',

  /// my progress screen
  AppStrings.progressIntroductionTxt:
      "لەم پەیجەدا دەتوانن هەموو کۆرسە ناونوسراوەکانتان ببینن و ئەو پێشکەوتنانەی کە لە هەر یەکێکیاندا بەدەستتان هێناوە.",
  AppStrings.complete: 'تەواو',
  AppStrings.remaining: 'ماوە',
  AppStrings.noProgressAvailable: 'هیچ پێشکەوتنێک لەبەردەستدا نییە',

  /// my certificate screen
  AppStrings.certificate: 'بڕوانامەکانم',
  AppStrings.certificateScreenTxt:
      "لەم پەیجەدا دەتوانیت سەرجەم بڕوانامەکانت ببینیت بۆ تەواوکردنی هەر کۆرسێک، یان دەرچوون لە تاقیکردنەوەکە لەو بوارەدا.",
  AppStrings.pdfSuccessfullyDownload: 'داگرتنی Pdf بە سەرکەوتوویی',

  /// notification screen
  AppStrings.notifications: 'ئاگادارکردنەوەکان',
  AppStrings.clearAll: "هەمووی پاک بکەرەوە",

  /// exam screen
  AppStrings.exams: "تاقیکردنەوەکان",
  AppStrings.examsScreenTxt:
      'لەم لاپەڕەیەدا دەتوانیت زانیاریەکانت لە هەر بوارێکدا تاقی بکەیتەوە، و ئەگەری هەیە بڕوانامەکە وەربگریت.',
  AppStrings.noExamAvailable: "هیچ تاقیکردنەوەیەک بەردەست نییە",
  AppStrings.pleaseCompleteYourExamTxt:
      'تکایە پێشکەوتنەکانتان تەواو بکەن دوای ئەوەی دەتوانن تاقیکردنەوەکان بکەن',

  /// questions screen
  AppStrings.finishExam: "تاقیکردنەوەی تەواوکردن",
  AppStrings.questions: "پرسیارەکان",
  AppStrings.ofText: "لە",
  AppStrings.q: "پ",
  AppStrings.skip: "بازدان",
  AppStrings.next: "داهاتوو",
  AppStrings.writeHere: "لێرە بنووسە....",
  AppStrings.pleaseEnterAnswer: "تکایە وەڵام دابنێ",
  AppStrings.pleaseSelectAnyOption: "تکایە هەر بژاردەیەک هەڵبژێرە",

  /// congratulation screen
  AppStrings.congratulations: "پیرۆزە!",
  AppStrings.youHaveCompletedMathematicsMasteryTest:
      "تاقیکردنەوەی ماستەری بیرکاریت تەواو کردووە",
  AppStrings.yourScore: "نمرەکەت",
  AppStrings.yourTime: "کاتت",
  AppStrings.yourAnswers: "وەڵامەکانتان",
  AppStrings.viewSolution: "بینینی چارەسەر",
  AppStrings.percentage: "لەسەدا",
  AppStrings.result: "ئەنجام",
  AppStrings.continues: "بەردەوام بوون",
  AppStrings.pass: "تێپەڕین",

  /// solution screen
  AppStrings.solution: "چارەسەرەکان",
  AppStrings.yourAnswer: "وەڵامی ئێوە",
  AppStrings.correctAnswer: "وەڵامی ڕاست",

  /// payment success dialog
  AppStrings.thankYouTxt:
      'سوپاس بۆ ئارەزووی بەشداریکردنتان لە “ناوی کۆرس” نرخی ئەم خولە بە...',
  AppStrings.thankYouTxt2:
      'دەتوانیت پارەکە لە ڕێگەی بژاردەکانی خوارەوە ئەنجام بدەیت',

  ///APP ERROR MESSAGE
  AppStrings.emailIsRequired: "ئیمەیڵ پێویستە",
  AppStrings.isRequired: '* داواکراو',
  AppStrings.pleaseEnterOtp: 'تکایە Otp داخڵ بکە',
  AppStrings.pleaseEnterValidOtp: 'تکایە Valid OTP دابنێ',
  AppStrings.pleaseEnterSomeText: "تکایە هەندێک دەق دابنێ",
  AppStrings.pleaseEnterMobileNumber: "تکایە ژمارەی مۆبایل داخڵ بکە",
  AppStrings.somethingWantWrong: "شتێک بە هەڵەدا چووە",

  ///Registration
  AppStrings.name: "ناو",
  AppStrings.nameIsRequired: "ناوی پێویستە",
  AppStrings.error: "هەڵە",
  AppStrings.userCreatedSuccessfully: "بەکارهێنەر بە سەرکەوتوویی دروستکراوە",
  AppStrings.otpMismatch: "تکایە Otp ی ڕەوا دابنێ",

  ///---------------///
  AppStrings.myBalance: 'باڵانسی من',
  AppStrings.addBalance: 'زیادکردنی باڵانس',
  AppStrings.markAllRead: 'مارک ئۆڵ خوێندنەوە',
  AppStrings.testCertificate: 'تاقیکردنەوە و بڕوانامە',
  AppStrings.transactionHistory: 'مێژووی مامەڵەکان',
  AppStrings.inThisPageYourKnow:
      'لەم لاپەڕەیەدا دەتوانیت زانیاریەکانت لە هەر بوارێکدا تاقی بکەیتەوە، و ئەگەری هەیە بڕوانامەکە وەربگریت.',

  AppStrings.languageSelection: 'کام زمانت پێ باشترە بۆ ئەپەکە؟',
  AppStrings.english: 'ئینگلیزی',
  AppStrings.kurdish: 'کوردی',
  AppStrings.welcomeBack: 'بەخێربێن گەڕانەوە',
  AppStrings.togetherWeLearn:
      'ببەیەکەوە؛ فێردەبین، شارەزادەبین و بەرەوپێشدەچین',
  AppStrings.myCourses: 'کۆرسەکانی من',
  AppStrings.sanaAcademyAboutUsDes:
      'ئەکادیمیای سنە دامەزراوەیەکی پەروەردەیی ئۆنلاین و بە شێوەی کەسی تایبەتە بە بەهێزکردنی گەنجان لە عێراق. ئێمە خولی گونجاو پێشکەش دەکەین و دەستڕاگەیشتن بە مامۆستای وانەبێژی سەرەکی، یارمەتی تاکەکان دەدەین لە داڕشتنی ژیانیان لە ڕێگەی پەروەردەیەکی کوالیتی. ئەرکی ئێمە ئەوەیە کە فێربوون ببێتە شتێکی دەستڕاگەیشتن و گۆڕانکاری بۆ کۆمەڵگا.',
  AppStrings.logIn: 'چوونەژوورەوە',
  AppStrings.enterYourPassword: 'وشەی نهێنی خۆت دابنێ',
  AppStrings.loginOrRegisterToEnrollThisCourse:
      'بۆ ناو تۆمارکردنی ئەم کۆرسە بچۆرە ژوورەوە یان ناوت تۆمار بکە',
  AppStrings.inputPhoneNumber: 'ژمارەی تەلەفۆن دابنێ',
  AppStrings.password: 'نهێنوشە',
  AppStrings.verifyYourPhone: 'مۆبایلەکەت پشتڕاست بکەرەوە',
  AppStrings.resendCode: 'کۆدی دووبارە ناردنەوە',
  AppStrings.verifyYourPhone: 'ژمارەی تەلەفۆن پشتڕاست بکەرەوە',
  AppStrings.otpHasBeenSetToYourPhone: 'OTP لەسەر مۆبایلەکەت دانراوە',
  AppStrings.onWhatsApp: 'لە واتسئەپ',
  AppStrings.reqHardCopy: 'داواکاری. هارد کۆپی',
  AppStrings.testsAndCertificates: 'تاقیکردنەوە و بڕوانامە',
  AppStrings.inThisPageYouCanSeeAllCertificates:
      'لەم پەیجەدا دەتوانیت سەرجەم بڕوانامەکانت ببینیت بۆ تەواوکردنی هەر کۆرسێک، یان دەرچوون لە تاقیکردنەوەکە لەو بوارەدا.',
  AppStrings.inThisPageYouCanTestYourKnowledge:
      'لەم لاپەڕەیەدا دەتوانیت زانیاریەکانت لە هەر بوارێکدا تاقی بکەیتەوە، و ئەگەری هەیە بڕوانامەکە وەربگریت.',

  AppStrings.profileCompletion: 'تەواوکردنی پڕۆفایلی :',
  AppStrings.fullNameEng: 'ناوی تەواو (ئینگلیزی)',
  AppStrings.fullNameKur: 'ناوی تەواوی (کوردی)',
  AppStrings.birthOfDate: 'بەرواری لەدایکبوون',
  AppStrings.gender: 'ڕەگەز',
  AppStrings.selectGender: 'ڕەگەز هەڵبژێرە',
  AppStrings.city: 'شار',
  AppStrings.province: 'پارێزگا',
  AppStrings.select: 'دەسنیاشنکردن',
  AppStrings.saveDetails: 'وردەکارییەکان پاشەکەوت بکە',
  AppStrings.enrollTheCourse: 'ناوت تۆمار بکە لە کۆرسەکە',
  AppStrings.internetConnectionNotAvailable: 'الاتصال بالإنترنت غير متوفر',
  AppStrings.retryingIn: 'إعادة المحاولة في',
  AppStrings.retryNow: 'أعد المحاولة الآن',
};
