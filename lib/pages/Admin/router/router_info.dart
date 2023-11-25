import 'package:flutter/material.dart';
import 'package:jom_makan/pages/admin/views/course/list.dart';
import 'package:jom_makan/pages/admin/views/router_view.dart';
import 'package:jom_makan/pages/admin/views/school/list.dart';
import 'package:jom_makan/pages/admin/views/user/list.dart';

import 'package:go_router/go_router.dart';
import 'package:jom_makan/pages/admin/views/index.dart';
import 'package:jom_makan/pages/admin/views/login/login.dart';

typedef OnRouteView = Widget Function(
    BuildContext context, GoRouterState state);

class RouteInfo extends GoRoute {
  final String title;
  // 菜单Icon
  final IconData? icon;
  final List<RouteInfo> children;
  // 路由信息是否存在于菜单
  final bool menu;
  final bool view;
  // 标题是否固定在导航栏
  final bool affix;

  // 标题是否存在面包屑
  final bool breadcrumb;

  // 运行时动态参数，可存储
  final Map<String, dynamic> runtimePair = {};

  RouteInfo(
      {required String path,
      required String name,
      OnRouteView? onRouteView,
      required this.title,
      this.menu = true,
      this.affix = false,
      this.breadcrumb = true,
      this.view = true,
      this.children = const <RouteInfo>[],
      this.icon})
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
      title: '登录',
      onRouteView: (context, state) => LoginView())
];
// 管理后台路由 如首页、列表、等
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
        onRouteView: (context, state) => SchoolView(),
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
        onRouteView: (context, state) => CourseListPage(),
      ),
      RouteInfo(
        path: 'update',
        name: 'course_update',
        title: 'Monthly Sales Report',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'subject',
        name: 'course_subject',
        title: 'Yearly Sales Report',
        onRouteView: (context, state) => SchoolView(),
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
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'pay-config',
        name: 'transaction_pay_config',
        title: 'Payment Method',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'refund',
        name: 'transaction_refund',
        title: 'Refund',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'log',
        name: 'transaction_log',
        title: 'Transaction Details',
        onRouteView: (context, state) => SchoolView(),
      ),
    ],
  ),
  RouteInfo(
    path: '/data-center',
    name: 'data_center',
    title: 'History',
    children: [
      RouteInfo(
        path: 'question',
        name: 'data_center_question',
        title: '题库',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'video',
        name: 'data_center_video',
        title: '视频库',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'import-question',
        name: 'data_center_import_question',
        title: '题库导入',
        onRouteView: (context, state) => SchoolView(),
      ),
      RouteInfo(
        path: 'import-video',
        name: 'data_center_import_video',
        title: '视频导入',
        onRouteView: (context, state) => SchoolView(),
      ),
    ],
  )
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
