import 'package:flutter/material.dart';
import 'package:template/main.dart';

import '../../../values/colors.dart';
import '../../../values/text_styles.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(
            borderSide: BorderSide(width: 8, color: dividerGrey)),
        title: Text('Edit Account',
            style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                supabase.auth.signOut();
              },
              child: Text('data'))
        ],
      ),
    );
  }
}
