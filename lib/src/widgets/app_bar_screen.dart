import 'package:go_router/go_router.dart';
import 'package:template/src/pages/export.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScreen(
      {super.key,
      required this.title,
      this.icon,
      this.isAction = false,
      this.moreInfo,
      this.isLeading = true});
  final String title;
  final IconButton? icon;
  final bool? isAction;
  final String? moreInfo;
  final bool isLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isLeading
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => GoRouter.of(context).pop(),
            )
          : null,
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
          if (moreInfo != null)
            Text(
              moreInfo!,
              style: AppTextStyle.decriptionAppbar,
            )
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
