import 'package:flutter/material.dart';

class LoginViaEmailView extends StatefulWidget {
  const LoginViaEmailView({Key? key}) : super(key: key);

  @override
  State<LoginViaEmailView> createState() => _LoginViaEmailViewState();
}

class _LoginViaEmailViewState extends State<LoginViaEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login via Email'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
