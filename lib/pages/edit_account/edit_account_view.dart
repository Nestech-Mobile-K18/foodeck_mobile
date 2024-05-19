import 'dart:io';

import 'package:template/pages/edit_account/model.dart';
import 'package:template/pages/export.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({Key? key}) : super(key: key);

  @override
  _EditAccountViewState createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodePassword;
  late FocusNode _focusNodeName;
  late FocusNode _focusNodePhone;
  File? _selectImage;

  late final AccountInfo _accountInfo;

  @override
  void initState() {
    //hard code data
    _accountInfo = accountInfo;
    _nameController.setText(_accountInfo.name);
    _mailController.setText(_accountInfo.email!);
    _phoneController.setText(_accountInfo.phone!);
    _passController.setText(_accountInfo.pass);

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
  @override
  Widget build(BuildContext context) {
    Widget avatar = const CircleAvatar(
      backgroundImage: NetworkImage('https://picsum.photos/id/64/4326/2884'),
    );

    if (_selectImage != null) {
      avatar = CircleAvatar(
        backgroundImage: FileImage(
          _selectImage!,
        ),
      );
    }
    return Scaffold(
      appBar: const AppBarScreen(
        title: AppStrings.editAccount,
      ),
      body: SingleChildScrollView(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is Empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              InputText(
                title: AppStrings.email,
                controller: _mailController,
                focusNode: _focusNodeEmail,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_focusNodeEmail);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is Empty';
                  }
                  return null;
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone is Empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: AppSize.s16,
              ),
              InputText(
                title: AppStrings.password,
                controller: _nameController,
                focusNode: _focusNodePassword,
                isPass: true,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_focusNodePassword);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is Empty';
                  } else if (value.length < 8 && value.isNotEmpty) {
                    return 'Password is too short';
                  }
                  return null;
                },
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
      ),
    );
  }
}
