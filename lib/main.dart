import 'package:famdoc_admin/screens/HomeScreen.dart';
import 'package:famdoc_admin/screens/admin_users.dart';
import 'package:famdoc_admin/screens/time_category.dart';
import 'package:famdoc_admin/screens/doctor_screen.dart';
import 'package:famdoc_admin/screens/hire_management.dart';
import 'package:famdoc_admin/screens/login_screen.dart';
import 'package:famdoc_admin/screens/manage_banners.dart';
import 'package:famdoc_admin/screens/notification_screen.dart';
import 'package:famdoc_admin/screens/settings_screen.dart';
import 'package:famdoc_admin/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FamDoc Admin Dashboard',
        theme: ThemeData(
          primaryColor: Color(0xFF2E4053),
        ),
        home: SplashScreen(),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          BannerScreen.id: (context) => BannerScreen(),
          DoctorManagement.id: (context) => DoctorManagement(),
          HireManagement.id: (context) => HireManagement(),
          NotificationScreen.id: (context) => NotificationScreen(),
          AdminUsersScreen.id: (context) => AdminUsersScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          DoctorScreen.id: (context) => DoctorScreen(),
        });
  }
}
