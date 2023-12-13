import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_makan/pages/Admin/views/index.dart';
import 'package:jom_makan/pages/Admin/views/inventory/list.dart';
import 'package:jom_makan/pages/Admin/views/inventory/list2.dart';
import 'package:jom_makan/pages/Admin/views/login/login.dart';
import 'package:jom_makan/pages/Admin/views/logout.dart';
import 'package:jom_makan/pages/Admin/views/payment/payment_list.dart';
import 'package:jom_makan/pages/Admin/views/payment/payment_list2.dart';
import 'package:jom_makan/pages/Admin/views/payment/payment_list3.dart';
import 'package:jom_makan/pages/Admin/views/promotion/list.dart';
import 'package:jom_makan/pages/Admin/views/report/daily.dart';
import 'package:jom_makan/pages/Admin/views/report/monthly.dart';
import 'package:jom_makan/pages/Admin/views/report/yearly.dart';
import 'package:jom_makan/pages/Admin/views/stall/renew_stall.dart';

void main() {
  runApp(const MaterialApp(home: AdminPortal()));
}

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<StatefulWidget> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  int _currentIndex = 0;
  bool _isExpanded = false;

  final List<Widget> _pages = [
    IndexView(), LoginView(), UserList(), SchoolView(), StockView(),
    DailySales(), MonthlySales(), YearlySales(), PaymentView(),
    PaymentSearch(), PaymentDate(), RenewStallView(), const LogoutView(),
  ];

  final List<String> _destinations = [
    'Admin Home', 'Admin Login', 'Promotion List', 'Current Stock', 'Stock Check',
    'Daily Sales Report', 'Monthly Sales Report', 'Yearly Sales Report', 'Payment Details',
    'Payment Method', 'Transaction Details', 'Transaction Details', 'Renew Stall', 'Logout'
  ];

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
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
    return Scaffold(
      appBar: AppBar(
        // title
        title: Text(_destinations[_currentIndex]),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ),
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      extended: _isExpanded,
                      selectedIndex: _currentIndex,
                      groupAlignment: -1.0,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.none,
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Index'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.login),
                          label: Text('Admin Login'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.card_giftcard),
                          label: Text('Promotion List'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.article),
                          label: Text('Current Stock'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.check_box),
                          label: Text('Stock Check'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.assessment),
                          label: Text('Daily Sales Report'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.calendar_today),
                          label: Text('Monthly Sales Report'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.calendar_view_day),
                          label: Text('Yearly Sales Report'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.payment),
                          label: Text('Payment Details'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.payment),
                          label: Text('Payment Method'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.paid),
                          label: Text('Transaction Details'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.store),
                          label: Text('Renew Stall'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.logout),
                          label: Text('Logout'),
                        ),
                        // Permission - with transmission - subpage: Admin Login
                        // other menu items ...
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages.elementAt(_currentIndex),
          ),
        ],
      ),
    );
  }
}