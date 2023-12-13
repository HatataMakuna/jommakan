import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
//import 'package:responsive_framework/responsive_wrapper.dart';

import '../style/colors.dart';


abstract class AdminView extends StatefulWidget {
  final logger = Logger();

  AdminView({super.key});
}

class AdminStateView<T extends AdminView> extends State<T> {
  final logger = Logger();
  @override
  void initState() {
    super.initState();
  }

  // big screen
  Widget? buildForLarge(BuildContext context) => null;

  // medium screen
  Widget? buildForMedium(BuildContext context) => null;

  // small screen
  Widget? buildForSmall(BuildContext context) => null;

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 768;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 425 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors().get().backgroundColor,
      body: buildForSmall(context) ??
        buildForMedium(context) ??
        buildForLarge(context),
    );
  }

  /* @override
  Widget build(BuildContext _context) {
    String? name = ResponsiveWrapper.of(_context).activeBreakpoint.name;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (name == null) {
          return Scaffold(
            backgroundColor: AdminColors().get().backgroundColor,
            body: buildForLarge(context),
          );
        }
        switch (name) {
          case MOBILE:
            return Scaffold(
              backgroundColor: AdminColors().get().backgroundColor,
              body: buildForSmall(context) ?? buildForMedium(context) ?? buildForLarge(context),
            );
          case TABLET:
            return Scaffold(
              backgroundColor: AdminColors().get().backgroundColor,
              body: buildForMedium(context) ?? buildForLarge(context) ?? buildForSmall(context),
            );
          case DESKTOP:
            return Scaffold(
              backgroundColor: AdminColors().get().backgroundColor,
              body: buildForLarge(context),
            );
          default:
            return Scaffold(
              backgroundColor: AdminColors().get().backgroundColor,
              body: buildForSmall(context) ??
                  buildForMedium(context) ??
                  buildForLarge(context),
            );
        }
      },
    );
  } */
}
