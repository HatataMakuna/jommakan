// THIS FILE IS ONLY FOR EASE OF TESTING PURPOSE
import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Admin/admin_main.dart';
import 'package:jom_makan/pages/order/order_history.dart';
import 'package:jom_makan/pages/user/change_password.dart';
import 'package:jom_makan/stores/favorites_provider.dart';
import 'package:jom_makan/stores/seatlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:jom_makan/stores/user_provider.dart'; // Import the UserProvider class
import 'package:jom_makan/pages/main/main_page.dart';
import 'package:jom_makan/pages/user/create_account.dart';
import 'package:jom_makan/pages/user/forget_password.dart';
import 'package:jom_makan/pages/user/login.dart';
import 'package:jom_makan/pages/search/search.dart';
import 'package:jom_makan/pages/rider/rider_info.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ChangeNotifierProvider(create: (context) => SeatListProvider()),
    ],
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule the modification after the build phase has completed
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).setUserName('Testing');
      Provider.of<UserProvider>(context, listen: false).setUserID(1);
      Provider.of<UserProvider>(context, listen: false).setUserRole('User');
      Provider.of<UserProvider>(context, listen: false).setUserEmail('testing@tarc.edu.my');
      Provider.of<FavoritesProvider>(context, listen: false).fetchFavorites(1);
    });

    bool hasRequiredRole(BuildContext context, String requiredRole) {
      String? userRole = Provider.of<UserProvider>(context).userRole;
      return userRole == requiredRole;
    }

    return MaterialApp(
      initialRoute: '/',
      routes: {
        // user
        '/': (context) => const MainPage(), // Change this to which page you want the testing process to start with
        '/user/login': (context) => const LoginPage(),
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => const ForgetPasswordPage(),

        //'/user/edit-profile': (context) => EditProfile(userID: userID),
        '/user/change-password': (context) => const ChangePassword(),
        '/user/order-history': (context) => const OrderHistoryPage(),
        '/rider/rider-info': (context) => const RiderInfo(),
        '/home': (context) => const MainPage(),
        '/search': (context) => const SearchPage(),

        // admin
        '/admin': (context) => const AdminMainPage(),
      },
    );
  }
}
