import 'package:flutter/cupertino.dart';
import 'package:template/pages/export.dart';

class SearchItemBar extends StatelessWidget {
  const SearchItemBar(
      {Key? key, required this.controller, required this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.dp,
      height: 54.dp,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.dp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.dp,
            vertical: 8.dp,
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: ColorsGlobal.grey2,
              ),
              Expanded(
                child: CupertinoTextField(
                  controller: controller,

                  focusNode: focusNode,
                  placeholder: 'Search...',
                  // style: Styles.searchText,
                  cursorColor: Colors.white,
                   style: TextStyle(color:Colors.grey.shade500),
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: controller.clear,
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: ColorsGlobal.grey2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
