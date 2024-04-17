import 'package:flutter/material.dart';

import '../../../resources/const.dart';

/// A custom widget for displaying search results.
class ResultSearchCard extends StatefulWidget {
  final String? nameOfPlace;
  final String? address;
  final VoidCallback? onTap;

  const ResultSearchCard({
    super.key,
    this.nameOfPlace,
    this.address,
    this.onTap,
  });

  @override
  State<ResultSearchCard> createState() => _ResultSearchCardState();
}

class _ResultSearchCardState extends State<ResultSearchCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
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
          const Divider(
            color: ColorsGlobal.dividerGrey,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
