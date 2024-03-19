import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 17, 0, 49),
                child: Image.asset('assets/images/Img.png')),
            GestureDetector(
              onTap: () {
                print('click to Login via Google');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: redColors,
                ),
                width: 328,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/GoogleLogo.png'),
                    SizedBox(height: 16),
                    Text(
                      'Login via Google',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter-Bold',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('click to Login via Facebook');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: blueColors,
                ),
                width: 328,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/FacebookLogo.png'),
                    SizedBox(height: 16),
                    Text(
                      'Login via Facebook',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter-Bold',
                          color: whiteColors,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('click to Login via Apple');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: blackColors,
                ),
                width: 328,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/AppleLogo.png'),
                    SizedBox(height: 16),
                    Text(
                      'Login via Apple',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter-Bold',
                          color: whiteColors,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('click to Login via Email');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: pinkColors,
                ),
                width: 328,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/GmailLogo.png'),
                    SizedBox(height: 16),
                    Text(
                      'Login via Email',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter-Bold',
                          color: whiteColors,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('click to Create an account');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: greyColors),
                  color: whiteColors,
                ),
                width: 328,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/GoogleLogo.png'),
                    SizedBox(height: 16),
                    Text(
                      'Create an account',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inter-Bold',
                          color: greyColors,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 66),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'By signing up, you are agreeing to our',
                    style: TextStyle(
                        color: greyColors,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter-Regular',
                        fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      print('Terms & Conditions');
                    },
                    child: Text(
                      ' Terms & \nConditions',
                      style: TextStyle(
                          color: pinkColors,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter-Regular',
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
