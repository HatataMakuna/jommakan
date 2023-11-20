import 'package:jom_makan/pages/FoodDelivery/bindings/authen_binding.dart';
import 'package:jom_makan/pages/FoodDelivery/constants/colors.dart';
import 'package:jom_makan/pages/FoodDelivery/routes/links.dart';
import 'package:jom_makan/pages/FoodDelivery/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  AuthenBinding().dependencies();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations', //
        fallbackLocale: const Locale('en', 'US'),
        startLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: "SofiaPro",
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontWeight: FontWeight.w500),
            bodyText2: TextStyle(fontWeight: FontWeight.w500),
          ).apply(
            bodyColor: AppColors.dark100,
            displayColor: AppColors.dark100,
          ),
        ),
        initialBinding: AuthenBinding(),
        initialRoute: AppLinks.WELCOME,
        getPages: AppRoutes.pages,
      ),
    );
  }
}
