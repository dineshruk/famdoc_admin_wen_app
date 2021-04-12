import 'package:famdoc_admin/screens/HomeScreen.dart';
import 'package:famdoc_admin/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

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

    //Future.delayed(Duration(seconds: 5));

    //Progress Dialog already show? don't worry, you can change the message :D
    progressDialog.setTitle(Text("Wait"));
    progressDialog.setMessage(Text("Checking your credential"));

    //Future.delayed(Duration(seconds: 5));

    _login({username, password}) async {
      progressDialog.show();
      _services.getAdminCredential(username).then((value) async {
        if (value.exists) {
          if (value.data()['username'] == username) {
            if (value.data()['password'] == password) {
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              } catch (e) {
                progressDialog.dismiss();
               _services.showMyDialog(
                 context: context,
                  title: 'Login',
                  message: '${e.toString()}',
                );
              }
              return;
            }
            progressDialog.dismiss();
            _services.showMyDialog(
              context: context,
              title: 'Invalid Password',
              message: 'Password you entered is not valid.Please try again',
            );
            return;
          }
          progressDialog.dismiss();
         _services.showMyDialog(
           context: context,
            title: 'Incorrect Username',
            message: 'Username you entered is not valid.Please try again.',
          );
        }
        progressDialog.dismiss();
        _services.showMyDialog(
          context: context,
          title: 'Incorrect Username',
          message: 'Username you entered is not valid.Please try again.',
        );
      });
    }

    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('connection Failed'),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF2E4053), Colors.white],
                      stops: [1.0, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment(0.0, 0.0)),
                ),
                child: Center(
                  child: Container(
                    width: 350,
                    height: 470,
                    child: Card(
                      elevation: 7,
                      shape: Border.all(color: Colors.black12, width: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Image.asset('images/logo.png'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _usernameTextController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter User Name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Username',
                                            prefixIcon: Icon(Icons.person),
                                            hintText: 'User Name',
                                            contentPadding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueGrey)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: _passwordTextController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter Password';
                                          }
                                          if (value.length < 6) {
                                            return 'Minimum 6 Characters';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: 'Password',
                                            helperText: 'Minimum 6 Characters',
                                            prefixIcon:
                                                Icon(Icons.vpn_key_outlined),
                                            hintText: 'Password',
                                            contentPadding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueGrey)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _login(
                                                username:
                                                    _usernameTextController
                                                        .text,
                                                password:
                                                    _passwordTextController
                                                        .text,
                                              );
                                            }
                                          },
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            'Login',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ));
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> showMyDialog({title, message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text('Please try Again..'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
