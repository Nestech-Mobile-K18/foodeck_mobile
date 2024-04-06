import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/routes.dart';
import 'package:template/widgets/button.dart';
import 'package:template/widgets/input_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late final StreamSubscription<AuthState> _authSubscription;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;
  late FocusNode _focusNodeName;
  late FocusNode _focusNodePhone;

  @override
  void initState() {
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
    _focusNodeName = FocusNode();
    _focusNodePhone = FocusNode();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeName.dispose();
    _focusNodePhone.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  Future<void> signUpAccount() async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: _mailController.text.trim(),
          password: _passController.text.trim(),
          // phone: _phoneController.text!.trim(),
          data: {
            'name': _nameController.text.trim(),
            'phone': _phoneController.text.trim(),
            // 'gender': gender!.trim(),
          });

      if (res.user?.id != null) {
        // đăng kí thành công chuyển tới màn hình OTP
         Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(RouteName.otp, arguments: _mailController.text.trim());
        // const SnackBar(
        //   content: Text('Successfully updated profile!'),
        // );
      }
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.toString()),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } 
  }

  Future<void> loginInstead() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create an account',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8),
            child: Divider(
              thickness: 8,
              height: 0,
              color: Colors.grey.shade100,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Input your credentials',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InputText(
                    title: 'Name',
                    controller: _nameController,
                    focusNode: _focusNodeName,
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(_focusNodeName);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name Is Empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InputText(
                    title: 'Email',
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _focusNodeEmail,
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(_focusNodeEmail);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InputText(
                    title: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    focusNode: _focusNodePhone,
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(_focusNodePhone);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is Empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InputText(
                    title: 'Password',
                    controller: _passController,
                    isPass: true,
                    focusNode: _focusNodePassword,
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(_focusNodePassword);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pasword is Empty';
                      } else if (value.length < 8 && value.isNotEmpty) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                ),
                Button(
                  label: 'Create an account',
                  width: 328,
                  height: 62,
                  colorBackgroud: ColorsGlobal.globalPink,
                  colorLabel: Colors.white,
                  onPressed: () => signUpAccount(),
                ),
                Button(
                  label: 'Create an account instead',
                  colorLabel: ColorsGlobal.grey,
                  colorBorder: ColorsGlobal.grey,
                  colorBackgroud: Colors.white,
                  width: 328,
                  height: 62,
                  onPressed: () => loginInstead(),
                ),
              ],
            ),
          ),
        ));
  }
}
