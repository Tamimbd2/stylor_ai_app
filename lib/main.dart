import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/controllers/user_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(UserController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Read saved locale
    final box = GetStorage();
    final String? lang = box.read('language_code');
    final String? country = box.read('country_code');
    
    Locale initialLocale;
    if (lang != null && country != null) {
      initialLocale = Locale(lang, country);
    } else {
      initialLocale = const Locale('en', 'US');
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812), // Figma / standard mobile size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Outfit App',
          debugShowCheckedModeBanner: false,

          // Localization Configuration
          translations: AppTranslations(),
          locale: initialLocale,
          fallbackLocale: const Locale('en', 'US'),

          theme: ThemeData(
            fontFamily: "Poppins",
            useMaterial3: true,
            // primarySwatch: Colors.blue,
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),

          /// 🔥 Start Screen (Splash)
          initialRoute: AppPages.INITIAL,

          /// 🔥 All routes
          getPages: AppPages.routes,

          /// 🔥 Unknown Route
          unknownRoute: GetPage(
            name: '/notfound',
            page: () => const NotFoundPage(),
          ),
        );
      },
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Text('404 - Page Not Found'),
      ),
    );
  }
}
