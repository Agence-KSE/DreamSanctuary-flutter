import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormUser {
  String username;
  String password;
  String email;
}

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey _formKey = GlobalKey();
  final Register _formResult = FormUser();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage("images/background_login.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 228, 249, 245).withOpacity(0.7),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 300.0),
                children: [
                  const Text(
                    'Dream Sanctuary',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                      labelText: 'Email',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    controller: TextEditingController(text: "test@ds.com"),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'required';
                      } else if (email.length < 5) {
                        return 'too short';
                      } else if (!email.toString().contains("@")) {
                        return 'isn\'t an email address';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (email) {
                      _formResult.email = email!;
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
                    controller: TextEditingController(text: "testds"),
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
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text("Login"),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => {},
                tooltip: 'Register',
                child: const Icon(
                  Icons.add,
                  size: 36,
                  color: Color.fromARGB(255, 54, 79, 107),
                ))));
  }
}
