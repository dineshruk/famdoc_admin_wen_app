
import 'package:famdoc_admin/services/sidebar.dart';
import 'package:famdoc_admin/widgets/banner/banner_upload_widget.dart';
import 'package:famdoc_admin/widgets/banner/banner_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';



class BannerScreen extends StatelessWidget {
  static const String id = 'manage-banners';

 

  @override
  Widget build(BuildContext context) {
     SideBarwidget _sidebar = SideBarwidget();

 

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FamDoc Admin'),
      ),
      sideBar: _sidebar.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add/Delete Home Screen Images'),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  
  
  }
}
