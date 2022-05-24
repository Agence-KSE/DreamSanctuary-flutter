import 'dart:developer';

import 'package:dreamsanctuary/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dreamsanctuary/screens/home.dart';

class LoginUser {
  late String userName;
  late String password;
}

class Login extends StatefulWidget {
  final bool isLoggedIn = false;

  Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _formKey = GlobalKey();
  final _formResult = LoginUser();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background_login.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor:
                const Color.fromARGB(255, 228, 249, 245).withOpacity(0.7),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 150.0, vertical: 300.0),
                children: [
                  const Text(
                    'Dream Sanctuary',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                      labelText: 'Username',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    controller: TextEditingController(text: "testLogin"),
                    validator: (userName) {
                      if (userName!.isEmpty) {
                        return 'required';
                      } else if (userName.length < 3) {
                        return 'too short';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (userName) {
                      _formResult.userName = userName!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                      labelText: 'Password',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    controller: TextEditingController(text: "testLogin"),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'required';
                      } else if (password.length < 3) {
                        return 'too short';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (password) {
                      _formResult.password = password!;
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                    onPressed: _gotoRegister,
                    tooltip: 'Register',
                    child: const Icon(
                      Icons.add,
                      size: 36,
                      // color: Color.fromARGB(255, 54, 79, 107),
                    )),
                FloatingActionButton(
                    onPressed: _submitForm,
                    tooltip: 'Login',
                    child: const Icon(
                      Icons.check_circle,
                      size: 36,
                      // color: Color.fromARGB(255, 54, 79, 107),
                    )),
              ],
            )));
  }

  void _submitForm() {
    log("submit form");
    final FormState form = _formKey.currentState as FormState;
    if (form.validate()) {
      form.save();
      log('New user logged in!');
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: ((context) {
            return Home(
              username: _formResult.userName,
            );
          }),
        ),
      );
    }
  }

  void _gotoRegister() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return Register();
    })));
  }
}
