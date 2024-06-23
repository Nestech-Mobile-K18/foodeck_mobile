import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/features/auth/data/model.dart';
import 'package:template/src/pages/error_page.dart';
import 'package:template/src/pages/export.dart';
import 'package:template/src/utils/validate/validate_operations.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;
  late FocusNode _focusNodeName;
  late FocusNode _focusNodePhone;
  File? _selectImage;

  // late final AccountInfo _accountInfo;

  @override
  void initState() {
    _focusNodeEmail = FocusNode();
    _focusNodePassword = FocusNode();
    _focusNodeName = FocusNode();
    _focusNodePhone = FocusNode();
    super.initState();
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectImage = File(pickedImage.path);
    });
  }

  @override
  void dispose() {
    _mailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeName.dispose();
    _focusNodePhone.dispose();

    super.dispose();
  }

  Future<void> _handleEditAccount() async {}

  Widget editAccount(AccountInfo user) {
    print(user.typeAuthen);
    _nameController.setText(user.name);
    _mailController.setText(user.email!);
    _phoneController.setText(user.phone!);
    _passController.setText(user.password!);
    Widget avatar = CircleAvatar(
      backgroundImage: NetworkImage(user.avatar!),
    );

    if (_selectImage != null) {
      avatar = CircleAvatar(
        backgroundImage: FileImage(
          _selectImage!,
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p24, horizontal: AppPadding.p24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s100,
              width: AppSize.s100,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  avatar,
                  Positioned(
                      bottom: 0,
                      right: -AppSize.s25,
                      child: RawMaterialButton(
                        onPressed: _takePicture,
                        elevation: 2.0,
                        fillColor: ColorsGlobal.globalPink,
                        padding: EdgeInsets.all(AppPadding.p10),
                        shape: const CircleBorder(),
                        // ignore: prefer_const_constructors
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: ColorsGlobal.white,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s40,
            ),
            InputText(
              title: AppStrings.name,
              controller: _nameController,
              focusNode: _focusNodeName,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeName);
                });
              },
              validator: (value) => ValidateOperations.normalValidation(value),
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.email,
              controller: _mailController,
              focusNode: _focusNodeEmail,
              isReadOnly:
                  user.typeAuthen == 'email' || user.typeAuthen == 'google'
                      ? true
                      : false,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeEmail);
                });
              },
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.phoneNo,
              controller: _phoneController,
              focusNode: _focusNodePhone,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodePhone);
                });
              },
              validator: (value) => ValidateOperations.phoneValidation(value),
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.password,
              controller: _passController,
              focusNode: _focusNodePassword,
              isPass: true,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodePassword);
                });
              },
              validator: (value) =>
                  ValidateOperations.passwordValidation(value),
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            Button(
              label: AppStrings.save,
              width: double.infinity,
              height: AppSize.s62,
              colorBackgroud: ColorsGlobal.globalPink,
              colorLabel: ColorsGlobal.white,
              onPressed: () => _handleEditAccount(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarScreen(
          title: AppStrings.editAccount,
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              final AccountInfo user = state.userInfor!;
              return editAccount(user);
            }
            return ErrorPage(onTryAgainPressed: () {
              context.read<AuthenticationBloc>().add(AppStarted());
            });
          },
        ));
  }
}
