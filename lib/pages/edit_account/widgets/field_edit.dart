import 'package:flutter/material.dart';
import 'package:template/widgets/custom_textfield.dart';

import '../../../resources/const.dart';

import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_textfield.dart';

class FieldEdit extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;

  const FieldEdit({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<FieldEdit> createState() => _FieldEditState();
}

class _FieldEditState extends State<FieldEdit> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: widget.nameController,
          textInputType: TextInputType.name,
          title: StringExtensions.name,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.emailController,
          readOnly: true,
          textInputType: TextInputType.emailAddress,
          title: StringExtensions.email,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.phoneController,
          textInputType: TextInputType.phone,
          title: StringExtensions.phone,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          title: StringExtensions.password,
          textInputType: TextInputType.visiblePassword,
          obscureText: obscureText,
          iconSuffit: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
