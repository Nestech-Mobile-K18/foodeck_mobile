import 'package:template/source/export.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future login() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      if (emailRegex.hasMatch(emailController.text)) {
        await supabase.auth
            .signInWithOtp(email: emailController.text, shouldCreateUser: false)
            .then((value) => Navigator.pushNamed(context, AppRouter.otp,
                arguments: emailController.text.trim()));
      } else {
        ShowBearSnackBar.showBearSnackBar(context, 'Not Correct!');
      }
    } on AuthException catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, error.message);
    } catch (error) {
      ShowBearSnackBar.showBearSnackBar(context, 'Error!, please retry');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          unFocus;
        },
        child: Scaffold(
            appBar: AppBar(
                shape: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 8, color: dividerGrey)),
                title: const CustomText(
                    content: 'Forgot Password', fontWeight: FontWeight.bold)),
            body: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  content: 'Input your credentials',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 20),
                                child: CustomFormFill(
                                    boxShadow: emailRegex
                                            .hasMatch(emailController.text)
                                        ? Colors.pink.shade100
                                        : Colors.white,
                                    textInputType: TextInputType.emailAddress,
                                    labelText: 'Email',
                                    hintText: 'johndoe123@gmail.com',
                                    exampleText: emailRegex
                                            .hasMatch(emailController.text)
                                        ? null
                                        : 'Example: johndoe123@gmail.com',
                                    labelColor: emailRegex
                                            .hasMatch(emailController.text)
                                        ? globalPink
                                        : emailController.text.isEmpty
                                            ? globalPink
                                            : Colors.red,
                                    borderColor: emailController.text.isNotEmpty
                                        ? globalPink
                                        : Colors.grey,
                                    inputColor: emailRegex
                                            .hasMatch(emailController.text)
                                        ? globalPink
                                        : Colors.red,
                                    focusErrorBorderColor: emailRegex
                                            .hasMatch(emailController.text)
                                        ? globalPink
                                        : emailController.text.isEmpty
                                            ? globalPink
                                            : Colors.red,
                                    textEditingController: emailController,
                                    function: (value) {
                                      setState(() {
                                        emailRegex
                                            .hasMatch(emailController.text);
                                      });
                                    },
                                    errorText: emailRegex
                                            .hasMatch(emailController.text)
                                        ? null
                                        : emailController.text.isEmpty
                                            ? null
                                            : '${emailController.text} is not a valid email'),
                              ),
                              CustomButton(
                                  onPressed: () {
                                    login();
                                  },
                                  text: const CustomText(
                                      content: 'Login',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  color: globalPink)
                            ]))))));
  }
}
