import 'package:template/source/export.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showPass = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RegExp phoneRegex = RegExp(r'^[+]?\d{10,13}$');
  RegExp nameRegex = RegExp(
      r'^([^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s?[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+?\S)$');

  Future signUpAndAddUsers() async {
    try {
      if (emailRegex.hasMatch(emailController.text) &&
          nameRegex.hasMatch(nameController.text) &&
          phoneRegex.hasMatch(phoneController.text) &&
          passRegex.hasMatch(passwordController.text)) {
        await supabase.auth.signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        await supabase.from('users').insert({
          'email': emailController.text.trim(),
          'full_name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        });
        Navigator.pushNamed(context, AppRouter.otp,
            arguments: emailController.text.trim());
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
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
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
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Create an account', fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomFormFill(
                        boxShadow: nameRegex.hasMatch(nameController.text)
                            ? Colors.pink.shade100
                            : Colors.white,
                        textInputType: TextInputType.name,
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        exampleText: nameRegex.hasMatch(nameController.text)
                            ? null
                            : 'Example: John Doe',
                        labelColor: nameRegex.hasMatch(nameController.text)
                            ? AppColor.globalPink
                            : nameController.text.isEmpty
                                ? AppColor.globalPink
                                : Colors.red,
                        borderColor: nameController.text.isNotEmpty
                            ? AppColor.globalPink
                            : Colors.grey,
                        inputColor: nameRegex.hasMatch(nameController.text)
                            ? AppColor.globalPink
                            : Colors.red,
                        focusErrorBorderColor:
                            nameRegex.hasMatch(nameController.text)
                                ? AppColor.globalPink
                                : nameController.text.isEmpty
                                    ? AppColor.globalPink
                                    : Colors.red,
                        textEditingController: nameController,
                        function: (value) {
                          setState(() {
                            nameRegex.hasMatch(nameController.text);
                          });
                        },
                        errorText: nameRegex.hasMatch(nameController.text)
                            ? null
                            : nameController.text.isEmpty
                                ? null
                                : '${nameController.text} is not a valid name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      boxShadow: emailRegex.hasMatch(emailController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'johndoe123@gmail.com',
                      exampleText: emailRegex.hasMatch(emailController.text)
                          ? null
                          : 'Example: johndoe123@gmail.com',
                      borderColor: emailController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      inputColor: emailRegex.hasMatch(emailController.text)
                          ? AppColor.globalPink
                          : Colors.red,
                      labelColor: emailRegex.hasMatch(emailController.text)
                          ? AppColor.globalPink
                          : emailController.text.isEmpty
                              ? AppColor.globalPink
                              : Colors.red,
                      focusErrorBorderColor:
                          emailRegex.hasMatch(emailController.text)
                              ? AppColor.globalPink
                              : emailController.text.isEmpty
                                  ? AppColor.globalPink
                                  : Colors.red,
                      textEditingController: emailController,
                      function: (value) {
                        setState(() {
                          emailRegex.hasMatch(emailController.text);
                        });
                      },
                      errorText: emailRegex.hasMatch(emailController.text)
                          ? null
                          : emailController.text.isEmpty
                              ? null
                              : '${emailController.text} is not a valid email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      boxShadow: phoneRegex.hasMatch(phoneController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      textInputType: TextInputType.phone,
                      labelText: 'Phone No.',
                      hintText: '+92 3014124781',
                      exampleText: phoneRegex.hasMatch(phoneController.text)
                          ? null
                          : 'Need correct number',
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(13)
                      ],
                      labelColor: phoneController.text.isEmpty
                          ? AppColor.globalPink
                          : phoneRegex.hasMatch(phoneController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      borderColor: phoneController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      inputColor: phoneRegex.hasMatch(phoneController.text)
                          ? AppColor.globalPink
                          : Colors.red,
                      focusErrorBorderColor: phoneController.text.isEmpty
                          ? AppColor.globalPink
                          : phoneRegex.hasMatch(phoneController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      textEditingController: phoneController,
                      function: (value) {
                        setState(() {
                          phoneRegex.hasMatch(phoneController.text);
                        });
                      },
                      errorText: phoneController.text.isEmpty
                          ? null
                          : phoneRegex.hasMatch(phoneController.text)
                              ? null
                              : '${phoneController.text} is not a valid phone number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: CustomFormFill(
                      boxShadow: passRegex.hasMatch(passwordController.text)
                          ? Colors.pink.shade100
                          : Colors.white,
                      labelText: 'Password',
                      exampleText: passRegex.hasMatch(passwordController.text)
                          ? null
                          : 'Example: Johndoe123!',
                      labelColor: passRegex.hasMatch(passwordController.text)
                          ? AppColor.globalPink
                          : passwordController.text.isEmpty
                              ? AppColor.globalPink
                              : Colors.red,
                      inputColor: passRegex.hasMatch(passwordController.text)
                          ? AppColor.globalPink
                          : Colors.red,
                      borderColor: passwordController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      focusErrorBorderColor:
                          passRegex.hasMatch(passwordController.text)
                              ? AppColor.globalPink
                              : passwordController.text.isEmpty
                                  ? AppColor.globalPink
                                  : Colors.red,
                      icons: passwordController.text.isEmpty
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:
                                    passRegex.hasMatch(passwordController.text)
                                        ? AppColor.globalPink
                                        : Colors.red,
                              )),
                      obscureText: showPass ? false : true,
                      function: (value) {
                        setState(() {
                          passRegex.hasMatch(passwordController.text);
                        });
                      },
                      errorText: passRegex.hasMatch(passwordController.text)
                          ? null
                          : passwordController.text.isEmpty
                              ? null
                              : 'Need number, symbol, capital and small letter',
                      textEditingController: passwordController,
                    ),
                  ),
                  CustomButton(
                      onPressed: () {
                        unFocus;
                        signUpAndAddUsers();
                      },
                      text: const CustomText(
                          content: 'Create an account',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      color: AppColor.globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: widget.onPressed,
                      text: const CustomText(
                          content: 'Login instead',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      color: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
