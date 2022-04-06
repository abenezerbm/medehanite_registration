import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medhanite_registration/functions/login_func.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _password = TextEditingController();
  TextEditingController _userName = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    enabledBorder: outLineInputBorder(context),
                    focusedBorder: outLineInputBorder(context),
                    hintText: "someone@example.com",
                    labelText: "Email"),
                controller: _userName,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: outLineInputBorder(context),
                    focusedBorder: outLineInputBorder(context),
                    hintText: "password",
                    labelText: "Password"),
                obscureText: true,
                controller: _password,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: min(200, size.width * 0.5),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: loading
                        ? null
                        : () async {
                            if (_password.text.trim().isEmpty ||
                                _userName.text.trim().isEmpty)
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Fields can't be empty"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            loading = true;
                            setState(() {});
                            try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Logging in..."),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              await login(_userName.text, _password.text);
                              Navigator.pushReplacementNamed(context, 'formScreen');
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed, try again"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            loading = false;
                            setState(() {});
                          },
                    child: Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Theme.of(context).primaryColor));
}
