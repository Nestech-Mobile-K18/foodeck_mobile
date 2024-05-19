import 'package:template/pages/export.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScreen(
      {super.key,
      required this.title,
      this.icon,
      this.isAction = false,
      this.moreInfo});
  final String title;
  final IconButton? icon;
  final bool? isAction;
  final String? moreInfo;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style:
                TextStyle(fontSize: AppSize.s22, fontWeight: FontWeight.bold),
          ),
          if (isAction == true) icon!,
         if (moreInfo!=null) Text(moreInfo!, style: AppTextStyle.decriptionAppbar,)
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppSize.s8),
        child: Divider(
          thickness: AppSize.s8,
          height: AppSize.s0,
          color: ColorsGlobal.grey3,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppSize.s60);
}
