import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController idInput = TextEditingController();
  TextEditingController pwdInput = TextEditingController();
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColor.appBar, title: const Text("Log in")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColor.surface,
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                width: 240,
                height: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: MyColor.text)),
                    TextField(
                        controller: idInput,
                        decoration: const InputDecoration(
                          labelText: 'ID',
                        ),
                        style: TextStyle(color: MyColor.text)),
                    const SizedBox(height: 20),
                    TextField(
                        controller: pwdInput,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        style: TextStyle(color: MyColor.text)),
                    const SizedBox(height: 50),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                          onPressed: () {
                            String id = idInput.text;
                            String pwd = pwdInput.text;
                            print("$id, $pwd");
                            Engine().loginUser(id, pwd, () {}, () {
                              FlutterDialog("Lonin fail",
                                  "Please check your id and password");
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.buttonColor,
                          ),
                          child: Text("Login",
                              style: TextStyle(color: MyColor.textLight))),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            String id = idInput.text;
                            String pwd = pwdInput.text;
                            print("$id, $pwd");
                            Engine().registerUser(id, pwd);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.buttonColor,
                          ),
                          child: Text("register",
                              style: TextStyle(color: MyColor.textLight))),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void FlutterDialog(String title, String msg) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: [
                Text(title),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(msg),
              ],
            ),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
