import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_admin/widgets/TimeCategory/subtime_widget.dart';
import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final DocumentSnapshot document;
  TimeCard(this.document);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SubCategoryWidget(document['name']);
            });
      },
      child: SizedBox(
        height: 130,
        width: 130,
        child: Card(
          color: Colors.lightBlue[50].withOpacity(0.8),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Image.network(document['image']),
                  ),
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        document['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
