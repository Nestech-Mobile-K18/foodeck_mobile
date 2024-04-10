import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';

class SearchCard extends StatefulWidget {
  final String? nameOfPlace;
  final String? address;
  const SearchCard({
    super.key,
    this.nameOfPlace,
    this.address,
  });

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            MediaRes.myLocation,
            color: ColorsGlobal.globalBlack,
            width: 25,
            height: 25,
          ),
          title: Text(widget.nameOfPlace!),
          subtitle: Text(widget.address!),
        ),
        Divider(
          color: ColorsGlobal.dividerGrey,
          thickness: 2,
        )
      ],
    );
  }
}
