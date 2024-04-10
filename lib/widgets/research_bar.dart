import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';

class ReSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          Icon(Icons.search, color: ColorsGlobal.textGrey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ...',
                hintStyle: TextStyle(color: ColorsGlobal.textGrey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
