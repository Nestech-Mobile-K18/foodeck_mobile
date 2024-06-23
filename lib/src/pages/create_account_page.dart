import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/signup/bloc/signup_bloc.dart';
import 'package:template/src/pages/export.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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

    super.initState();
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeName.dispose();
    _focusNodePhone.dispose();
    super.dispose();
  }

  Future<void> signUpAccount() async {
    context.read<SignupBloc>().add(SignUpStarted(
          email: _mailController.text.trim(),
          name: _nameController.text.trim(),
          password: _passController.text.trim(),
          phone: _phoneController.text.trim(),
        ));
    // try {
    //   final AuthResponse res =
    //       await supabase.auth.signUp(email: email, password: password, data: {
    //     'name': _nameController.text.trim(),
    //     'phone':
    //   });
    //   if (res.user?.id != null) {
    //     // đăng kí thành công chuyển tới màn hình OTP
    //     // ignore: use_build_context_synchronously
    //     GoRouter.of(context).push(
    //       RouteName.otp,
    //       extra: {'email': email},
    //       // arguments: {'email': 'example@example.com'},
    //     );
    //   }
    // } on PostgrestException catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error.message),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Unexpected error occurred'),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // }
  }

  Widget signup() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppPadding.p24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.inputYourCredentials,
                style: AppTextStyle.title,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p24),
              child: InputText(
                title: AppStrings.name,
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
              padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
              child: InputText(
                title: AppStrings.email,
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
              padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
              child: InputText(
                title: AppStrings.phone,
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
              padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
              child: InputText(
                title: AppStrings.password,
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
              label: AppStrings.createAccount,
              width: AppSize.s328,
              height: AppSize.s62,
              colorBackgroud: ColorsGlobal.globalPink,
              colorLabel: ColorsGlobal.white,
              onPressed: () => signUpAccount(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarScreen(
          title: AppStrings.createAccount,
        ),
        body: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupInProgress) {
              const CircularProgressIndicator();
            } else if (state is VerifyInProgress) {
              GoRouter.of(context).push(
                RouteName.otp,
                extra: {'email': state.email},
                // arguments: {'email': 'example@example.com'},
              );
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign up fail.')),
              );
            }
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              return signup();
            },
          ),
        ));
  }
}
