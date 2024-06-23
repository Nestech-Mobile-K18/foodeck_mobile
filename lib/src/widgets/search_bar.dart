import 'package:flutter/cupertino.dart';
import 'package:template/src/pages/export.dart';

class SearchItemBar extends StatelessWidget {
  const SearchItemBar(
      {Key? key,
      required this.controller,
      required this.focusNode,
      this.width,
      this.height, this.onChanged})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final double? width;
  final double? height;
 final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsGlobal.white,
          borderRadius: BorderRadius.circular(AppRadius.r16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p4,
            vertical: AppPadding.p8,
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
                  onChanged: onChanged,
                  focusNode: focusNode,
                  placeholder: AppStrings.search,
                  // style: Styles.searchText,
                  cursorColor: ColorsGlobal.white,
                  style: const TextStyle(color: ColorsGlobal.grey2),
                  decoration: const BoxDecoration(color: ColorsGlobal.white),
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
