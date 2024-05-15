import 'package:template/source/export.dart';

class CustomSliverBar extends StatelessWidget {
  const CustomSliverBar({
    super.key,
    required this.desktopFood,
  });

  final DesktopFood desktopFood;

  // phân loại tabs theo danh sách enum
  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 45,
      backgroundColor: Colors.white,
      expandedHeight: 130,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
          title: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorColor: globalPink,
              dividerColor: Colors.grey[200],
              labelColor: globalPink,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelStyle: AppText.inter
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: _buildCategoryTabs()),
          expandedTitleScale: 1,
          titlePadding: EdgeInsets.zero,
          background: Padding(
            padding: const EdgeInsets.only(bottom: 57, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.star_border),
                        CustomText(content: desktopFood.vote)
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.access_time_outlined),
                        CustomText(content: desktopFood.time)
                      ],
                    ),
                    const Column(
                      children: [
                        Icon(Icons.location_on_outlined),
                        CustomText(content: '1.4km')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
