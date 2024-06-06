import 'dart:async';
import 'package:template/pages/export.dart';

class LoginEmailView extends StatefulWidget {
  const LoginEmailView({Key? key}) : super(key: key);

  @override
  _LoginEmailViewState createState() => _LoginEmailViewState();
}

class _LoginEmailViewState extends State<LoginEmailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late final StreamSubscription<AuthState> _authSubscription;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;

  @override
  void initState() {
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
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
    _authSubscription.cancel();
    super.dispose();
  }

  Future<void> loginEmail() async {
    if (_formKey.currentState!.validate()) {
      // _formKey.currentState!.save();
      _formKey.currentState!.save();
      try {
        final mail = _mailController.text.trim();
        final pass = _passController.text.trim();
        await supabase.auth.signInWithPassword(email: mail, password: pass);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login success'), backgroundColor: Colors.green));
        }
      } on AuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error occured, please retry.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    }
  }

  Future<void> signupEmail() async {
    Navigator.of(context).pushNamed(RouteName.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login via Email',
            style: TextStyle(fontSize: 22.dp, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(8.dp),
            child: Divider(
              thickness: 8.dp,
              height: 0.dp,
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
                  padding: EdgeInsets.only(bottom: 16.dp),
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
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 40.dp),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
                Button(
                  label: 'Login',
                  width: 328.dp,
                  height: 62.dp,
                  colorBackgroud: ColorsGlobal.globalPink,
                  colorLabel: Colors.white,
                  onPressed: () => loginEmail(),
                ),
                Button(
                  label: 'Create an account instead',
                  colorLabel: ColorsGlobal.grey,
                  colorBorder: ColorsGlobal.grey,
                  colorBackgroud: Colors.white,
                  width: 328.dp,
                  height: 62.dp,
                  onPressed: () => signupEmail(),
                ),
              ],
            ),
          ),
        ));
  }
}
