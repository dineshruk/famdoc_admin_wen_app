import 'package:famdoc_admin/services/sidebar.dart';
import 'package:famdoc_admin/widgets/TimeCategory/time_list_widget.dart';
import 'package:famdoc_admin/widgets/TimeCategory/time_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DoctorManagement extends StatelessWidget {
  static const String id = 'doctor-management';
  @override
  Widget build(BuildContext context) {
    SideBarwidget _sidebar = SideBarwidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FamDoc Admin'),
      ),
      sideBar: _sidebar.sideBarMenus(context, DoctorManagement.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Add Time Category',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Time Category'),
              Divider(
                thickness: 5,
              ),
              TimeCreateWidget(),
              Divider(
                thickness: 5,
              ),
              TimeListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
