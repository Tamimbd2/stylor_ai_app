import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          locale: const Locale('en', 'US'),
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
