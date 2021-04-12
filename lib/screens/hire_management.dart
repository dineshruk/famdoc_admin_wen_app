import 'package:famdoc_admin/services/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class HireManagement extends StatelessWidget {
  static const String id = 'hire-management';
  @override
  Widget build(BuildContext context) {
    SideBarwidget _sidebar = SideBarwidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FamDoc Admin'),
      ),
      sideBar: _sidebar.sideBarMenus(context, HireManagement.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Hired Doctors Management',
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
