import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/research_bar.dart';

AppBar HomeBar(BuildContext context, String? address) {
  return AppBar(
    flexibleSpace: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          MediaRes.homebar,
          fit: BoxFit.cover,
        )),
    toolbarHeight: 142,
    automaticallyImplyLeading: false,
    titleSpacing: 24,
    title: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              MediaRes.location,
              fit: BoxFit.fill,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 5,
            ),
            address == ""
                ? CircularProgressIndicator()
                : Flexible(
                    child: CustomText(
                      title: address,
                      size: 18,
                      softWrap: true,
                      maxLine: 2,
                      textAlign: TextAlign.center,
                      color: ColorsGlobal.globalWhite,
                    ),
                  )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
                constraints: const BoxConstraints(maxWidth: 328, maxHeight: 54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                hintText: 'Search...',
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                prefixIcon: const Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                )),
          ),
        )
      ],
    ),
  );
}
