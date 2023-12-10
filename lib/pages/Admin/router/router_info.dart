import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Admin/views/payment/paymentList.dart';
import 'package:jom_makan/pages/Admin/views/payment/paymentList2.dart';
import 'package:jom_makan/pages/Admin/views/payment/paymentList3.dart';
import 'package:jom_makan/pages/Admin/views/report/daily.dart';
import 'package:jom_makan/pages/Admin/views/report/monthly.dart';
import 'package:jom_makan/pages/Admin/views/report/yearly.dart';
import 'package:jom_makan/pages/Admin/views/router_view.dart';
import 'package:jom_makan/pages/Admin/views/inventory/list.dart';
import 'package:jom_makan/pages/Admin/views/inventory/list2.dart';
import 'package:jom_makan/pages/Admin/views/stall/renewStall.dart';
import 'package:jom_makan/pages/Admin/views/promotion/list.dart';

import 'package:go_router/go_router.dart';
import 'package:jom_makan/pages/Admin/views/index.dart';
import 'package:jom_makan/pages/Admin/views/login/login.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

typedef OnRouteView = Widget Function(BuildContext context, GoRouterState state);

class RouteInfo extends GoRoute {
  final String title;
  
  final IconData? icon;
  final List<RouteInfo> children;
  final bool menu;
  final bool view;
  final bool affix;

  final bool breadcrumb;

  final Map<String, dynamic> runtimePair = {};

  RouteInfo({
    required String path, required String name, OnRouteView? onRouteView,
    required this.title, this.menu = true, this.affix = false, this.breadcrumb = true,
    this.view = true, this.children = const <RouteInfo>[], this.icon
  })
      : super(
            path: path,
            name: name,
            pageBuilder: (context, state) {
              late Widget child;
              if (onRouteView != null) {
                child = onRouteView(context, state);
              } else {
                child = _builder(context, state);
              }
              return NoTransitionPage(child: child);
            },
            routes: children);

  bool isChildren() => routes.isNotEmpty;

  T? getPair<T>(String key) {
    if (!runtimePair.containsKey(key)) {
      return null;
    }
    try {
      return runtimePair[key];
    } catch (e) {
      return null;
    }
  }

  putPair(String key, dynamic data, {bool replace = false}) {
    if (runtimePair.containsKey(key)) {
      if (!replace) {
        return;
      }
    }
    runtimePair[key] = data;
  }
}

Widget _builder(
  BuildContext context,
  GoRouterState state,
) {
  return Container();
}

final fixedRoute = [
  RouteInfo(
      path: '/login',
      name: 'login',
      title: 'Login',
      onRouteView: (context, state) => LoginView())
];

// Manage menu routes such as home page, list etc.
final menuRoute = [
  RouteInfo(
      path: '/index',
      name: 'index',
      title: 'Welcome TAR UMT Admin',
      menu: true,
      onRouteView: (context, state) => IndexView(key: state.pageKey,)),
  RouteInfo(
    path: '/permission',
    name: 'permission',
    title: 'Permission',
    children: [
      RouteInfo(
          path: 'role',
          name: 'permission_role',
          title: 'Admin Login',
          onRouteView: (context, state) => LoginView(key: state.pageKey)),
    ],
  ),
  RouteInfo(
    path: '/user',
    name: 'User',
    title: 'Promotion',
    children: [
      RouteInfo(
        path: 'list',
        name: 'user_list',
        title: 'Promotion List',
        onRouteView: (context, state) => UserList(key: state.pageKey),
      ),
    ],
  ),
  RouteInfo(
    path: '/school',
    name: 'School',
    title: 'Inventory System',
    children: [
      RouteInfo(
        path: 'list',
        name: 'school_list',
        title: 'Current Stock',
        onRouteView: (context, state) => SchoolView(key: state.pageKey),
      ),
      RouteInfo(
        path: 'major',
        name: 'school_major',
        title: 'Stock Check',
        onRouteView: (context, state) => StockView(key: state.pageKey),
      )
    ],
  ),
  RouteInfo(
    path: '/course',
    name: 'course',
    title: 'Sales Report',
    children: [
      RouteInfo(
        path: 'list',
        name: 'course_list',
        title: 'Daily Sales Report',
        onRouteView: (context, state) => DailySales(),
      ),
      RouteInfo(
        path: 'update',
        name: 'course_update',
        title: 'Monthly Sales Report',
        onRouteView: (context, state) => MonthlySales(),
      ),
      RouteInfo(
        path: 'subject',
        name: 'course_subject',
        title: 'Yearly Sales Report',
        onRouteView: (context, state) => YearlySales(),
      ),
    ],
  ),
  RouteInfo(
    path: '/transaction',
    name: 'transaction',
    title: 'Transaction / Payment',
    children: [
      RouteInfo(
        path: 'order',
        name: 'transaction_order',
        title: 'Payment Details',
        onRouteView: (context, state) => PaymentView(),
      ),
      RouteInfo(
        path: 'pay-config',
        name: 'transaction_pay_config',
        title: 'Payment Method',
        onRouteView: (context, state) => PaymentSearch(),
      ),
      RouteInfo(
        path: 'log',
        name: 'transaction_log',
        title: 'Transaction Details',
        onRouteView: (context, state) => PaymentDate(),
      ),
    ],
  ),
  RouteInfo(
    path: '/data-center',
    name: 'data_center',
    title: 'Admin Renew System',
    children: [
      RouteInfo(
        path: 'question',
        name: 'data_center_question',
        title: 'Renew Stall',
        onRouteView: (context, state) => RenewStallView(),
      ),
    ],
  ),
  RouteInfo(
    path: '/log-out',
    name: 'Log Out',
    title: 'Log Out',
    onRouteView: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Add your logout logic here
        Provider.of<UserProvider>(context, listen: false).logout();

        // Use pushReplacementNamed to replace the current route with a new one
        Navigator.of(context).pushReplacementNamed('/user/login');
      });

      // Return an empty container or widget as the view for the '/log-out' route
      return Container();
    },
  ),
];

class AdminRouter {
  static final AdminRouter _instance = AdminRouter._internal();
  RouteInfo? currentRoute;
  Map<String, RouteInfo> tips = {};
  List<RouteInfo> parents = [];
  late GoRouter goRouter;

  AdminRouter._internal() {
    goRouter = GoRouter(
      routes: [
        ShellRoute(
          routes: menuRoute,
          builder: (context, state, child) {
            return RouterView(
              child,
              key: state.pageKey,
            );
          },
        ),
        // ...fixedRoute
      ],
      initialLocation: '/index',
      debugLogDiagnostics: true,
    );
  }

  void setNewNav(List<RouteInfo> names) {
    if (names.isEmpty) {
      return;
    }
    parents = names;
    currentRoute = parents.last;
    tips[currentRoute!.name!] = currentRoute!;
  }

  bool isChild(RouteInfo routeInfo) {
    for (var i = 0; i < parents.length; i++) {
      var value = parents[i];
      if (value.name == routeInfo.name) {
        return true;
      }
    }
    return false;
  }

  factory AdminRouter() {
    return _instance;
  }
}

extension AdminString on String {
  bool eq(dynamic d) {
    if (d == null) {
      return false;
    }
    return toString() == d.toString();
  }
}