
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:js';
// import 'package:mynotes/views/register_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your Email'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Enter your Password'),
              ),
              TextButton(
              child: Text('Register'),
                          
                onPressed: () async{
    
                final email = _email.text;
                final password  = _password.text;
                try{
                  final UserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password
                    );
                    print(UserCredential);
                } on FirebaseAuthException catch (e) {
                  if(e.code == 'weak-password'){
                    print('Weak password');
                  } else if(e.code == 'email-already-in-use'){
                    print('Email is already in use');
                  } else if(e.code == 'invalid-email'){
                    print('Invalid Email');
                  };
                }
              },
              ),
              TextButton(onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login/',
               (route) => false
               );
              },
              child: const Text('Already registered? Login here!'))
            ],
          ),
    );
  }}