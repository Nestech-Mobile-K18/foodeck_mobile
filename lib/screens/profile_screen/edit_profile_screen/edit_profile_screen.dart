import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //
  TextEditingController nameController =
      TextEditingController(text: profileInfo[0].name);
  TextEditingController emailController =
      TextEditingController(text: profileInfo[0].email);
  TextEditingController phoneController =
      TextEditingController(text: profileInfo[0].phone);
  TextEditingController passwordController =
      TextEditingController(text: profileInfo[0].password);
  @override
  void initState() {
    super.initState();
    nameController;
    emailController;
    phoneController;
    passwordController;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //
  bool _obscureText = true;
  void _onTapObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //
  //
  RegExp nameRegex = RegExp(r'^[^!@#$%^&+`;/_~*(),.?":{}|<>0-9]{5,}$');
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool _isValidateName = true;
  bool _isValidateEmail = true;
  bool _isValidatePhone = true;
  bool _isValidatePassword = true;

  void _checkValid() {
    setState(() {
      setState(() {
        _isValidateName = nameRegex.hasMatch(nameController.text);
        _isValidateEmail = emailRegex.hasMatch(emailController.text);
        _isValidatePhone = phoneController.text.length == 10 ? true : false;
        _isValidatePassword =
            passwordController.text.length >= 6 ? true : false;
      });
    });
  }

  //
  final supabase = Supabase.instance.client;
  //
  Future<void> _checkExistEmail() async {
    final existEmail = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text);
    if (existEmail.isEmpty) {
      emailExist = false;
    } else {
      emailExist = true;
    }
  }

  bool? emailExist;
  //
  Future<void> _saveProfile() async {
    final existAccount = await Supabase.instance.client
        .from("user_account")
        .select("email")
        .eq("email", emailController.text);

    if (existAccount.isNotEmpty) {
      await supabase
          .from("user_account")
          .update({
            "updated_time": DateTime.now().toString(),
            "name": nameController.text.trim(),
            "phone": phoneController.text.trim(),
            "password": passwordController.text.trim(),
          })
          .eq("email", emailController.text)
          .select();

      //update profile
      final newProfile = ProfileInfo(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text);

      profileInfo.clear();
      profileInfo.add(newProfile);
      //Navigation to HomeScreen when it updated
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen(page: 3)));
      });
    } else {
      null;
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColor.white,
        child: SizedBox(
          height: 120,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do you want to update your profile?",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _saveProfile();
                    },
                    child: Text(
                      "Yes",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: Text(
          "Edit Account",
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColor.black,
          ),
        ),
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColor.grey6,
              height: 10,
              width: double.infinity,
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      AppImage.profile,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: AppColor.primary,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 16,
                      color: AppColor.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              controller: nameController,
              label: "Name",
              obscureText: false,
              errorText: _isValidateName == false ? "*Invalid name!" : "",
            ),
            CustomTextFormField(
              controller: emailController,
              label: "Email",
              obscureText: false,
              errorText: emailExist == false
                  ? "*Email not signed up. Try to create one"
                  : _isValidateEmail == false
                      ? "*Invalid email!"
                      : "",
            ),
            CustomTextFormField(
              controller: phoneController,
              label: "Phone No.",
              obscureText: false,
              errorText: _isValidatePhone == false
                  ? "*Phone No. contains at least 10 number characters!"
                  : "",
            ),
            CustomTextFormField(
              controller: passwordController,
              onTapObscureText: _onTapObscureText,
              label: "Password",
              obscureText: _obscureText,
              errorText: _isValidatePassword == false
                  ? "*Password contains at least 6 characters!"
                  : "",
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  _checkValid();
                  _checkExistEmail();
                  _isValidateName &&
                          _isValidateEmail &&
                          _isValidatePhone &&
                          _isValidatePassword == true
                      ? _showDialog()
                      : null;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  fixedSize: const Size(328, 62),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
