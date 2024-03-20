import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';

class LoginButton {
  final String type;
  final String loginText;
  final Color backGroundColor;

  LoginButton(this.type, this.loginText, this.backGroundColor);
}

List<LoginButton> loginButton = [
  LoginButton(googleLogo, 'Login via Google', primaryRed),
  LoginButton(facebookLogo, 'Login via Facebook', primaryBlue),
  LoginButton(appleLogo, 'Login via Apple', Colors.black),
  LoginButton(emailLogo, 'Login via Email', lightPink),
  LoginButton('', 'Create an account', Colors.white)
];
