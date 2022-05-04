import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/home.dart';

class LoginUser {
  late String userName;
  late String password;
}

class Login extends StatefulWidget {
  bool isLoggedIn = false;

  Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _formKey = GlobalKey();
  final _formResult = LoginUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome!')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background_login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor:
              const Color.fromARGB(255, 228, 249, 245).withOpacity(0.7),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 150.0, vertical: 150.0),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _submitForm,
          tooltip: 'Login',
          child: const Icon(
            Icons.check_circle,
            size: 36,
            // color: Color.fromARGB(255, 54, 79, 107),
          )),
    );
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
              userName: _formResult.userName,
            );
          }),
        ),
      );
    }
  }
}
