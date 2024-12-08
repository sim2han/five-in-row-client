import 'package:fir_client/constants.dart';
import 'package:fir_client/engine.dart';
import 'package:fir_client/messageBox.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
                            //print("$id, $pwd");
                            Engine().loginUser(id, pwd, () {
                              flutterDialog(context, "Login success",
                                  "Nice to meet you again.");
                            }, () {
                              flutterDialog(context, "Login fail",
                                  "Please check your id or passwords");
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
                            //print("$id, $pwd");
                            Engine().registerUser(id, pwd, () {
                              flutterDialog(context, "Register Success",
                                  "Welcome new user!");
                            }, () {
                              flutterDialog(context, "Register Fail",
                                  "Please check your id.");
                            });
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
}
