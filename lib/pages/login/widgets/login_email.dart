import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool showPass = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Artboard? riveBearArtBoard;
  SMITrigger? success;
  SMITrigger? fail;
  SMIBool? isCheck;
  SMIBool? isHandsUp;
  SMINumber? number;

  @override
  void initState() {
    rootBundle.load('assets/rives/animated_login_character_.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artBoard, 'Login Machine');
        if (controller != null) {
          artBoard.addController(controller);
          success = controller.findSMI('trigSuccess');
          fail = controller.findSMI('trigFail');
          isCheck = controller.findSMI('isChecking');
          isHandsUp = controller.findSMI('isHandsUp');
          number = controller.findSMI('numLook');
        }
        setState(() => riveBearArtBoard = artBoard);
      },
    );
    super.initState();
  }

  Future login() async {
    setState(() {
      isCheck!.value = false;
      isHandsUp!.value = false;
    });
    if (Validation.emailRegex.hasMatch(emailController.text) &&
        Validation.passRegex.hasMatch(passwordController.text)) {
      Future.delayed(const Duration(milliseconds: 1600), () {
        setState(() {
          success!.value = true;
        });
      });
      Future.delayed(const Duration(milliseconds: 2200), () {
        try {
          supabase.auth.signInWithPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
        } on AuthException catch (error) {
          setState(() {
            isCheck!.value = false;
            isHandsUp!.value = false;
            fail!.value = true;
          });
          ShowBearSnackBar.showBearSnackBar(context, error.message);
        } catch (error) {
          setState(() {
            fail!.value = true;
          });
          ShowBearSnackBar.showBearSnackBar(context, 'Error!, please retry');
        }
      });
    } else {
      Future.delayed(
          const Duration(milliseconds: 1600),
          () => setState(() {
                fail!.value = true;
              }));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheck!.value = false;
          isHandsUp!.value = false;
        });
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Login via Email', fontWeight: FontWeight.bold)),
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
                  riveBearArtBoard == null
                      ? const SizedBox()
                      : SizedBox(
                          height: 255,
                          child: Rive(
                            artboard: riveBearArtBoard!,
                            fit: BoxFit.cover,
                          )),
                  CustomFormFill(
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
                    onTap: () {
                      setState(() {
                        isCheck!.value = true;
                        isHandsUp!.value = false;
                      });
                    },
                    function: (value) {
                      setState(() {
                        number!.value = value.length.toDouble();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                      onTap: () {
                        setState(() {
                          isHandsUp!.value = true;
                        });
                      },
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
                  Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 10),
                      child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pushNamed(
                                context, AppRouter.forgotPassword);
                          },
                          child: const CustomText(
                              content: 'Forgot Password?',
                              fontSize: 13,
                              textDecoration: TextDecoration.underline))),
                  CustomButton(
                      onPressed: () {
                        login();
                      },
                      text: const CustomText(
                          content: 'Login',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      color: AppColor.globalPink),
                  CustomButton(
                      borderSide: const BorderSide(color: Colors.grey),
                      onPressed: widget.onPressed,
                      text: const CustomText(
                          content: 'Create an account instead',
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
