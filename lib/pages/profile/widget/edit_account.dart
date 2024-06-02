import 'package:template/source/export.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool showPass = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RegExp phoneRegex = RegExp(r'^[+]?\d{10,13}$');
  RegExp nameRegex = RegExp(
      r'^([^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+\s?[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]+?\S)$');
  String? _imageUrl;

  @override
  void initState() {
    _imageUrl = sharedPreferences.getString('avatar');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateProfile() async {
    try {
      late dynamic id;
      var response = await supabase.from('users').select('id');
      var records = response.toList() as List;
      for (var record in records) {
        var userId = record['id'];
        setState(() {
          id = userId;
        });
      }
      if (emailRegex.hasMatch(emailController.text) &&
          nameRegex.hasMatch(nameController.text) &&
          phoneRegex.hasMatch(phoneController.text) &&
          passRegex.hasMatch(passwordController.text)) {
        await supabase.auth.updateUser(UserAttributes(
          email: emailController.text.isEmpty
              ? sharedPreferences.getString('email')
              : emailController.text,
          password: passwordController.text.isEmpty
              ? sharedPreferences.getString('email')
              : passwordController.text,
        ));
        await supabase.from('users').update({
          'email': emailController.text.isEmpty
              ? sharedPreferences.getString('email')
              : emailController.text,
          'full_name': nameController.text.isEmpty
              ? sharedPreferences.getString('name')
              : nameController.text,
          'phone': phoneController.text.isEmpty
              ? sharedPreferences.getString('phone')
              : phoneController.text,
          'password': passwordController.text.isEmpty
              ? sharedPreferences.getString('password')
              : passwordController.text,
          'avatar_url': _imageUrl
        }).eq('id', id);
        setState(() {
          sharedPreferences.setString('avatar', _imageUrl!);
          sharedPreferences.setString(
              'name',
              nameController.text.isEmpty
                  ? sharedPreferences.getString('name')!
                  : nameController.text);
          sharedPreferences.setString(
              'email',
              emailController.text.isEmpty
                  ? sharedPreferences.getString('email')!
                  : emailController.text);
          sharedPreferences.setString(
              'phone',
              phoneController.text.isEmpty
                  ? sharedPreferences.getString('phone')!
                  : phoneController.text);
          sharedPreferences.setString(
              'password',
              passwordController.text.isEmpty
                  ? sharedPreferences.getString('password')!
                  : passwordController.text);
        });
        if (mounted) {
          CustomWidgets.customSnackBar(
              context, AppColor.globalPinkShadow, 'You just saved info');
        }
      } else {
        if (mounted) {
          CustomWidgets.customSnackBar(context, AppColor.buttonShadowBlack,
              'Please make sure everything is corrected');
        }
      }
    } on AuthException catch (error) {
      if (mounted) {
        CustomWidgets.customSnackBar(
            context, AppColor.buttonShadowBlack, error.message);
      }
    } catch (error) {
      if (mounted) {
        CustomWidgets.customSnackBar(context, AppColor.buttonShadowBlack,
            'Error occurred, please retry');
      }
    }
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
                content: 'Edit Account', fontWeight: FontWeight.bold)),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Badge(
                    padding: const EdgeInsets.all(11.85),
                    label: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColor.globalPink,
                    largeSize: 50,
                    alignment: Alignment.bottomRight,
                    child: Avatar(
                        imageUrl: _imageUrl,
                        onUpload: (imageUrl) async {
                          setState(() {
                            _imageUrl = imageUrl;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomFormFill(
                        boxShadow: nameRegex.hasMatch(nameController.text)
                            ? Colors.pink.shade100
                            : Colors.white,
                        textInputType: TextInputType.name,
                        labelText: 'Full Name',
                        hintText: sharedPreferences.getString('name') ?? '',
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
                      hintText: sharedPreferences.getString('email') ?? '',
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
                      hintText: sharedPreferences.getString('phone') ?? '',
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
                      hintText: sharedPreferences.getString('password'),
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
                        updateProfile();
                      },
                      text: const CustomText(
                          content: 'Save',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      color: AppColor.globalPink),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
