import 'dart:async';
import 'package:template/pages/export.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
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
            .pushReplacementNamed(RouteName.home);
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
          data: {
            'name': _nameController.text.trim(),
            'phone': _phoneController.text.trim(),
          });

      if (res.user?.id != null) {
        // đăng kí thành công chuyển tới màn hình OTP
        Navigator.of(context, rootNavigator: true).pushReplacementNamed(
            RouteName.otp,
            arguments: _mailController.text.trim());
      }
    } on PostgrestException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarScreen(title: 'Create an account',),
        
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.dp, 24.dp, 24.dp, 24.dp),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Input your credentials',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.dp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.dp, bottom: 16.dp),
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
                  padding: EdgeInsets.only(top: 16.dp, bottom: 16.dp),
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
                  padding: EdgeInsets.only(top: 16.dp, bottom: 16.dp),
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
                  padding: EdgeInsets.only(top: 16.dp, bottom: 16.dp),
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
                  width: 328.dp,
                  height: 62.dp,
                  colorBackgroud: ColorsGlobal.globalPink,
                  colorLabel: Colors.white,
                  onPressed: () => signUpAccount(),
                ),
              ],
            ),
          ),
        ));
  }
}
