import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_makan/pages/Admin/router/router_info.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  AdminRouter();
  runApp(const AdminMainPage());
}

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // User leaves the admin portal, change back to portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
              labelColor: Colors.black26,
              labelStyle: const TextStyle(color: Colors.black26, fontSize: 14),
            ));

    return MaterialApp.router(
      theme: themeData,
      title: 'Flutter Admin',
      routerConfig: AdminRouter().goRouter,
      builder: (routerContext, child) {
        return ResponsiveWrapper.builder(
          child,
          maxWidth: 2460,
          minWidth: 280,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(280, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(912, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5)),
        );
      },
    );
  }
}
