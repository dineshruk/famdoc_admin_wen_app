import 'package:famdoc_admin/services/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AdminUsersScreen extends StatelessWidget {
  static const String id = 'admin-user';
  @override
  Widget build(BuildContext context) {
    SideBarwidget _sidebar = SideBarwidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FamDoc Admin'),
      ),
      sideBar: _sidebar.sideBarMenus(context, AdminUsersScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Admin User Management',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
