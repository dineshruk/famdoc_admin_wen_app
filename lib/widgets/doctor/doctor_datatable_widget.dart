import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_admin/services/firebase_services.dart';
import 'package:famdoc_admin/widgets/doctor/doctor_detail_box.dart';
import 'package:flutter/material.dart';

class DoctorDatatable extends StatefulWidget {
  @override
  _DoctorDatatableState createState() => _DoctorDatatableState();
}

class _DoctorDatatableState extends State<DoctorDatatable> {
  FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All Doctors', //0
    'Verified Doctors', //1
    'UnVerified Doctors', //2
    'Available Doctors', //3
    'UnAvailable Doctors', //4
    'Top Rated Doctors', //5
  ];

  bool active;
  bool avaiable;

  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        avaiable = true;
      });
    }
    if (val == 4) {
      setState(() {
        avaiable = false;
      });
    }
    if (val == 0) {
      setState(() {
        avaiable = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return C2ChoiceStyle(
                brightness: Brightness.dark,
                color: Colors.black54,
              );
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        Divider(
          thickness: 5,
        ),
        StreamBuilder(
          stream: _services.doctors
              .where('docAvaiable', isEqualTo: avaiable)
              .where('verified', isEqualTo: active)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong..');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Verified/UnVerified'),
                  ),
                  DataColumn(
                    label: Text('Available/UnAvailable'),
                  ),
                  DataColumn(
                    label: Text('DoctorName'),
                  ),
                  DataColumn(
                    label: Text('DoctorID'),
                  ),
                  DataColumn(
                    label: Text('Hospital'),
                  ),
                  DataColumn(
                    label: Text('Mobile'),
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Speciality'),
                  ),
                  DataColumn(
                    label: Text('Rating'),
                  ),
                  DataColumn(
                    label: Text('View Detail'),
                  ),
                ],
                rows: _doctorDetailsRows(
                  snapshot.data,
                  _services,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _doctorDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {
            services.updateDoctorStatus(
                id: document.data()['uid'],
                status: document.data()['verified']);
          },
          icon: document.data()['verified']
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
        )),
        DataCell(IconButton(
          onPressed: () {
            services.updateDoctorAvalability(
                id: document.data()['uid'],
                status: document.data()['docAvaiable']);
          },
          icon: document.data()['docAvaiable']
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
        )),
        DataCell(
          Text(document.data()['docName']),
        ),
        DataCell(
          Text(document.data()['docID']),
        ),
        DataCell(
          Text(document.data()['hospital']),
        ),
        DataCell(
          Text(document.data()['mobile']),
        ),
        DataCell(
          Text(document.data()['email']),
        ),
        DataCell(
          Text(document.data()['speciality']),
        ),
        DataCell(Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            Text('3.5'),
          ],
        )),
        DataCell(IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DoctorDetailBox(document.data()['uid']);
                });
          },
        )),
      ]);
    }).toList();
    return newList;
  }
}
