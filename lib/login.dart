import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 150.0, vertical: 150.0),
            children: [
              const Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                textInputAction: TextInputAction.next,
                autofocus: true,
                validator: (userName) {
                  if (userName!.isEmpty) {
                    return 'Username is required';
                  } else if (userName.length < 3) {
                    return 'Username is too short';
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
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                textInputAction: TextInputAction.next,
                autofocus: true,
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Password is required';
                  } else if (password.length < 3) {
                    return 'Password is too short';
                  } else {
                    return null;
                  }
                },
                onSaved: (userName) {
                  _formResult.userName = userName!;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _submitForm,
          tooltip: 'Login',
          child: const Icon(
            Icons.check_circle,
            size: 36,
          )),
    );
  }

  void _submitForm() {
    log("submit form");
    final FormState form = _formKey.currentState as FormState;
    if (form.validate()) {
      form.save();
      log('New user logged in!');
    }
  }
}
