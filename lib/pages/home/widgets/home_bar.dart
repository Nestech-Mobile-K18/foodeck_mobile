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
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: ReSearchBar(
            colorSearch: ColorsGlobal.globalWhite,
            hintText: 'Search',
          ),
        )
      ],
    ),
  );
}
