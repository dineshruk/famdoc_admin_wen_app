import 'dart:html';

import 'package:famdoc_admin/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:firebase/firebase.dart' as fb;



class TimeCreateWidget extends StatefulWidget {
  @override
  _TimeCreateWidgetState createState() => _TimeCreateWidgetState();
}

class _TimeCreateWidgetState extends State<TimeCreateWidget> {
  FirebaseServices _services = FirebaseServices();
  var _fileNameTextController = TextEditingController();
  var _timeNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  String _url;
  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context,
        blur: 2,
        backgroundColor: Color(0xFF2E4053).withOpacity(.1),
        message: Text("This is the message"),
        title: Text("This is the title"));

    // You can set Message using this function
    progressDialog.setTitle(Text("Loading"));
    progressDialog.setMessage(Text("Please Wait, "));
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: _timeNameTextController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'No Time Given',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 28),
                        ),
                      ),
                    ),

                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                          width: 200,
                          height: 30,
                          child: TextField(
                            controller: _fileNameTextController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Uploaded Banner',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(left: 28),
                            ),
                          )),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        uploadStorage();
                      },
                      child: Text(
                        'Upload Time',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AbsorbPointer(
                      absorbing: _imageSelected,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          if (_timeNameTextController.text.isEmpty) {
                            return _services.showMyDialog(
                                context: context,
                                title: 'Add New Time',
                                message: 'New Time Not Given');
                          }
                          progressDialog.show();
                          _services
                              .uploadTimeImageToDb(_url, _timeNameTextController.text)
                              .then((downloadUrl) {
                            if (downloadUrl != null) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                  title: 'New Time',
                                  message: 'Saved New Time Successfully',
                                  context: context);
                            }
                          });
                          _timeNameTextController.clear();
                          _fileNameTextController.clear();
                        },
                        child: Text('Save New Time',
                            style: TextStyle(color: Colors.white)),
                        color: _imageSelected ? Colors.black12 : Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // ignore: deprecated_member_use
            Visibility(
              visible: _visible ? false : true,
              // ignore: deprecated_member_use
              child: FlatButton(
                child:
                    Text('Add New Time', style: TextStyle(color: Colors.white)),
                color: Colors.black54,
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    final dateTime = DateTime.now();
    final path = 'TimeImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path;
        });
        fb
            .storage()
            .refFromURL('gs://famdoc-app.appspot.com/')
            .child(path)
            .put(file);
      }
    });
  }
}
