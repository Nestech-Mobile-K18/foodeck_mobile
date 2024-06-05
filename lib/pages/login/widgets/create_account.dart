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

  Future signUpAndAddUsers() async {
    try {
      if (Validation.emailRegex.hasMatch(emailController.text) &&
          Validation.nameRegex.hasMatch(nameController.text) &&
          Validation.phoneRegex.hasMatch(phoneController.text) &&
          Validation.passRegex.hasMatch(passwordController.text)) {
        await supabase.auth.signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        await supabase.from('users').insert({
          'email': emailController.text.trim(),
          'full_name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        });
        if (mounted) {
          Navigator.pushNamed(context, AppRouter.otp,
              arguments: emailController.text.trim());
        }
      } else {
        ShowBearSnackBar.showBearSnackBar(context, 'Not Correct!');
      }
    } on AuthException catch (error) {
      if (mounted) {
        ShowBearSnackBar.showBearSnackBar(context, error.message);
      }
    } catch (error) {
      if (mounted) {
        ShowBearSnackBar.showBearSnackBar(context, 'Error!, please retry');
      }
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
        FocusManager.instance.primaryFocus?.unfocus();
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
                        boxShadow:
                            Validation.nameRegex.hasMatch(nameController.text)
                                ? Colors.pink.shade100
                                : Colors.white,
                        textInputType: TextInputType.name,
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        exampleText:
                            Validation.nameRegex.hasMatch(nameController.text)
                                ? null
                                : 'Example: John Doe',
                        labelColor:
                            Validation.nameRegex.hasMatch(nameController.text)
                                ? AppColor.globalPink
                                : nameController.text.isEmpty
                                    ? AppColor.globalPink
                                    : Colors.red,
                        borderColor: nameController.text.isNotEmpty
                            ? AppColor.globalPink
                            : Colors.grey,
                        inputColor:
                            Validation.nameRegex.hasMatch(nameController.text)
                                ? AppColor.globalPink
                                : Colors.red,
                        focusErrorBorderColor:
                            Validation.nameRegex.hasMatch(nameController.text)
                                ? AppColor.globalPink
                                : nameController.text.isEmpty
                                    ? AppColor.globalPink
                                    : Colors.red,
                        textEditingController: nameController,
                        function: (value) {
                          setState(() {
                            Validation.nameRegex.hasMatch(nameController.text);
                          });
                        },
                        errorText: Validation.nameRegex
                                .hasMatch(nameController.text)
                            ? null
                            : nameController.text.isEmpty
                                ? null
                                : '${nameController.text} is not a valid name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      boxShadow:
                          Validation.emailRegex.hasMatch(emailController.text)
                              ? Colors.pink.shade100
                              : Colors.white,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      hintText: 'johndoe123@gmail.com',
                      exampleText:
                          Validation.emailRegex.hasMatch(emailController.text)
                              ? null
                              : 'Example: johndoe123@gmail.com',
                      borderColor: emailController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      inputColor:
                          Validation.emailRegex.hasMatch(emailController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      labelColor:
                          Validation.emailRegex.hasMatch(emailController.text)
                              ? AppColor.globalPink
                              : emailController.text.isEmpty
                                  ? AppColor.globalPink
                                  : Colors.red,
                      focusErrorBorderColor:
                          Validation.emailRegex.hasMatch(emailController.text)
                              ? AppColor.globalPink
                              : emailController.text.isEmpty
                                  ? AppColor.globalPink
                                  : Colors.red,
                      textEditingController: emailController,
                      function: (value) {
                        setState(() {
                          Validation.emailRegex.hasMatch(emailController.text);
                        });
                      },
                      errorText: Validation.emailRegex
                              .hasMatch(emailController.text)
                          ? null
                          : emailController.text.isEmpty
                              ? null
                              : '${emailController.text} is not a valid email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomFormFill(
                      boxShadow:
                          Validation.phoneRegex.hasMatch(phoneController.text)
                              ? Colors.pink.shade100
                              : Colors.white,
                      textInputType: TextInputType.phone,
                      labelText: 'Phone No.',
                      hintText: '+92 3014124781',
                      exampleText:
                          Validation.phoneRegex.hasMatch(phoneController.text)
                              ? null
                              : 'Need correct number',
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(13)
                      ],
                      labelColor: phoneController.text.isEmpty
                          ? AppColor.globalPink
                          : Validation.phoneRegex.hasMatch(phoneController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      borderColor: phoneController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      inputColor:
                          Validation.phoneRegex.hasMatch(phoneController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      focusErrorBorderColor: phoneController.text.isEmpty
                          ? AppColor.globalPink
                          : Validation.phoneRegex.hasMatch(phoneController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      textEditingController: phoneController,
                      function: (value) {
                        setState(() {
                          Validation.phoneRegex.hasMatch(phoneController.text);
                        });
                      },
                      errorText: phoneController.text.isEmpty
                          ? null
                          : Validation.phoneRegex.hasMatch(phoneController.text)
                              ? null
                              : '${phoneController.text} is not a valid phone number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: CustomFormFill(
                      boxShadow:
                          Validation.passRegex.hasMatch(passwordController.text)
                              ? Colors.pink.shade100
                              : Colors.white,
                      labelText: 'Password',
                      exampleText:
                          Validation.passRegex.hasMatch(passwordController.text)
                              ? null
                              : 'Example: Johndoe123!',
                      labelColor:
                          Validation.passRegex.hasMatch(passwordController.text)
                              ? AppColor.globalPink
                              : passwordController.text.isEmpty
                                  ? AppColor.globalPink
                                  : Colors.red,
                      inputColor:
                          Validation.passRegex.hasMatch(passwordController.text)
                              ? AppColor.globalPink
                              : Colors.red,
                      borderColor: passwordController.text.isNotEmpty
                          ? AppColor.globalPink
                          : Colors.grey,
                      focusErrorBorderColor:
                          Validation.passRegex.hasMatch(passwordController.text)
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
                                color: Validation.passRegex
                                        .hasMatch(passwordController.text)
                                    ? AppColor.globalPink
                                    : Colors.red,
                              )),
                      obscureText: showPass ? false : true,
                      function: (value) {
                        setState(() {
                          Validation.passRegex
                              .hasMatch(passwordController.text);
                        });
                      },
                      errorText: Validation.passRegex
                              .hasMatch(passwordController.text)
                          ? null
                          : passwordController.text.isEmpty
                              ? null
                              : 'Need number, symbol, capital and small letter',
                      textEditingController: passwordController,
                    ),
                  ),
                  CustomButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
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
