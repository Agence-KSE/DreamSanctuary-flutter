import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormRegisterUser {
  late String username;
  late String password;
  late String email;
}

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey _formKeyRegister = GlobalKey();
  final FormRegisterUser _formResult = FormRegisterUser();
  late String tempPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage("images/background_login.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 228, 249, 245).withOpacity(0.7),
            body: Form(
              key: _formKeyRegister,
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
                        tempPassword = password;
                        return null;
                      }
                    },
                    onSaved: (password) {
                      _formResult.password = password!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                      labelText: 'Repeat password',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    controller: TextEditingController(text: "testds"),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (password) {
                      print("temp : " + tempPassword);
                      if (password != tempPassword) {
                        return 'passwords are not identical';
                      }
                      return null;
                    },
                    onSaved: (password) {
                      _formResult.password = password!;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Register"),
                  )
                ],
              ),
            )));
  }

  Future<void> _submitForm() async {
    UserCredential userCredential;
    final FormState form = _formKeyRegister.currentState as FormState;
    print("registering user...");
    print("test");
    if (form.validate()) {
      // form.save();
      try {
        print('try login ' + _formResult.email + ' : ' + _formResult.password);
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _formResult.email, password: _formResult.password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user. ' + e.message.toString());
        }
      }
    }
  }
}
