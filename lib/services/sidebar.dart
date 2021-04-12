import 'package:famdoc_admin/screens/HomeScreen.dart';
import 'package:famdoc_admin/screens/admin_users.dart';
import 'package:famdoc_admin/screens/time_category.dart';
import 'package:famdoc_admin/screens/doctor_screen.dart';
import 'package:famdoc_admin/screens/hire_management.dart';
import 'package:famdoc_admin/screens/login_screen.dart';
import 'package:famdoc_admin/screens/manage_banners.dart';
import 'package:famdoc_admin/screens/notification_screen.dart';
import 'package:famdoc_admin/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarwidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo,
        ),
        MenuItem(
            title: 'View Doctors',
            route: DoctorScreen.id,
            icon: Icons.person_search),
        MenuItem(
            title: 'Create Time',
            route: DoctorManagement.id,
            icon: CupertinoIcons.time_solid),
        MenuItem(
            title: 'Hire Management',
            route: HireManagement.id,
            icon: Icons.house_siding_rounded),
        MenuItem(
            title: 'Send Notification',
            route: NotificationScreen.id,
            icon: Icons.notifications),
        MenuItem(
          title: 'Admin Users',
          route: AdminUsersScreen.id,
          icon: Icons.admin_panel_settings,
        ),
        MenuItem(
          title: 'Settings',
          route: SettingsScreen.id,
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Exit',
          route: LoginScreen.id,
          icon: Icons.exit_to_app,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route);
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            'MENU',
            style: TextStyle(
                letterSpacing: 3,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      footer: Container(
        height: 90,
        width: double.infinity,
        color: Colors.white,
        child: Center(child: Image.asset('images/logo.png')),
      ),
    );
  }
}
