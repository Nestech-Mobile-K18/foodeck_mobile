import 'package:template/pages/export.dart';

class AppBarRestaurant extends StatelessWidget {
  const AppBarRestaurant({
    super.key,
    required this.title,
    required this.address,
    required this.isFavourite,
    required this.imageRestaurant,
  });
  final String title;
  final String address;
  final bool isFavourite;
  final String imageRestaurant;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsGlobal.globalPink,
      toolbarHeight: AppSize.s100,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: ColorsGlobal.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(
            horizontal: AppPadding.p40, vertical: AppPadding.p12),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: AppSize.s20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: AppSize.s5,
            ),
            Text(
              address,
              style: TextStyle(
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        background: Image.asset(
          imageRestaurant,
          fit: BoxFit.cover,
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.305,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: ColorsGlobal.white,
          ),
          tooltip: AppStrings.like,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            color: ColorsGlobal.white,
          ),
          tooltip: AppStrings.share,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert_outlined,
            color: ColorsGlobal.white,
          ),
          tooltip: AppStrings.moreAction,
          onPressed: () {},
        ),
      ],
    );
  }
}
