import 'package:flutter/material.dart';
import 'package:template/pages/food_menu/views/food_variations_view.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/research_bar.dart';
import '../vm/home_view_model.dart';

class HomeBar extends StatefulWidget implements PreferredSizeWidget {
  final String? address;

  const HomeBar({super.key, this.address});

  @override
  _HomeBarState createState() => _HomeBarState();

  @override
  Size get preferredSize => const Size.fromHeight(142.0);
}

class _HomeBarState extends State<HomeBar> {
  final HomeViewModel _viewModel = HomeViewModel();
  List<Map<String, dynamic>> _searchResults = [];
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchResults.clear();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchResults.clear();
        });
      },
      child: AppBar(
        flexibleSpace: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 210,
          child: Image.asset(
            MediaRes.homebar,
            fit: BoxFit.cover,
          ),
        ),
        toolbarHeight: 210,
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
                const SizedBox(width: 5),
                widget.address == ""
                    ? const CircularProgressIndicator()
                    : Flexible(
                  flex: 2,
                  child: CustomText(
                    title: widget.address!,
                    size: 18,
                    softWrap: true,
                    maxLine: 2,
                    textAlign: TextAlign.center,
                    color: ColorsGlobal.globalWhite,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReSearchBar(
                    colorSearch: ColorsGlobal.globalWhite,
                    onChanged: (value) {
                      _viewModel.searchFoodByName(value).then((result) {
                        setState(() {
                          _searchResults = result;
                        });
                      });
                    },
                    hintText: 'Search',
                  ),
                  if (_searchResults.isNotEmpty)
                    Container(
                      height: Responsive.screenHeight(context)*0.1,
                      decoration: BoxDecoration(
                        color: ColorsGlobal.globalWhite,
                        borderRadius: BorderRadius.circular(16)
                      ),

                      child: ListView(
                        children: _searchResults.map((result) {
                          return ListTile(
                            onTap: () async{
                              final push = await Navigator.of(context).push
                              (MaterialPageRoute
                                (builder: (context)=>FoodVariationsView
                                (bindingData: result,)));
                              if(push == true){
                                _searchResults.clear();
                              }
                            },
                            leading: ClipRRect(borderRadius: BorderRadius
                                .circular(16),child: Image.network(result['image_food']),),
                            title: Text(result['food_name']),
                            subtitle: Text('\$${result['price']}'),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
