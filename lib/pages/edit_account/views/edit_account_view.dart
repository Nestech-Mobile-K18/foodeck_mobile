import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/pages/edit_account/models/edit_profile_model.dart';
import 'package:template/pages/edit_account/widgets/choose_avatar.dart';
import 'package:template/pages/edit_account/widgets/field_edit.dart';
import 'package:template/resources/const.dart';
import 'package:template/services/table_supbase.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/method_button.dart';

import '../../../widgets/cross_bar.dart';
import '../vm/edit_account_view_model.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({Key? key}) : super(key: key);

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? phoneController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final EditAccountViewModel _viewModel = EditAccountViewModel();
  XFile? _selectedImageFile;
  @override
  void initState() {
    super.initState();
    // Gọi hàm responseProfile và gắn giá trị vào các controller khi nhận được kết quả
    _viewModel.responseProfile().then((response) {
      if (response != null) {
        setState(() {
          nameController?.text = response[TableSupabase.nameColumn] ?? '';
          emailController?.text = response[TableSupabase.emailColumn] ?? '';
          phoneController?.text = response[TableSupabase.phoneColumn] ?? '';
          passwordController?.text =
              response[TableSupabase.passwordColumn] ?? '';
          // Kiểm tra xem cột avatar có giá trị không
          if (response['avatar'] != null) {
            // Tạo một XFile mới từ đường dẫn chuỗi
            _selectedImageFile = XFile(response['avatar']);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsGlobal.globalWhite,
      appBar: AppBar(
        title: const CustomText(
          title: StringExtensions.editAccount,
          color: ColorsGlobal.globalBlack,
          size: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              CrossBar(height: 10),
              ChooseAvatar(
                imgFile: _selectedImageFile,
                chooseAvatar: () async {
                  final imageFile =
                      await _viewModel.requestStoragePermission(context);
                  if (imageFile != null) {
                    setState(() {
                      _selectedImageFile = imageFile;
                    });
                  }
                },
              ),
              FieldEdit(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: MethodButton(
                    onTap: () async {
                      String? avatarPath = _selectedImageFile?.path;
                      EditProfileModel model = EditProfileModel(
                          avatarPath: avatarPath,
                          name: nameController?.text,
                          email: emailController?.text,
                          phone: phoneController?.text,
                          password: passwordController?.text);
                      _viewModel.auththenUpdate(model, context);
                    },
                    color: ColorsGlobal.globalPink,
                    title: StringExtensions.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
