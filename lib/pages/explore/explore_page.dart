import 'package:flutter/material.dart';
import 'package:template/pages/explore/widget/bottom_list_shopping.dart';
import 'package:template/pages/explore/widget/list_slide_banner.dart';
import 'package:template/pages/explore/widget/middle_slide_list.dart';
import 'package:template/pages/explore/widget/top_list_shopping.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                homeBar,
                fit: BoxFit.cover,
              )),
          toolbarHeight: 142,
          automaticallyImplyLeading: false,
          titleTextStyle: inter.copyWith(fontSize: 17, color: Colors.white70),
          titleSpacing: 24,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(mapPin),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text('Block B Phase 2 Johar Town, Lahore')
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                      style:
                          inter.copyWith(fontSize: 17, color: Colors.grey[400]),
                      decoration: InputDecoration(
                          constraints: const BoxConstraints(
                              maxWidth: 328, maxHeight: 54),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
                          hintText: 'Search...',
                          hintStyle: inter.copyWith(
                              fontSize: 17, color: Colors.grey[400]),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
                              child: Image.asset(
                                search,
                                color: Colors.grey,
                              )))))
            ],
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: TopListShopping(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: ListSlideBanner(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: MiddleSlideList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: BottomListShopping(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:my_app/pages/product1.dart';
//
// class CustomSearchDelegate extends SearchDelegate {
//   List<String> searchTerms = [
//     'Black Simple Lamp',
//     'Coffee Chair',
//     'Minimal Stand',
//     'Simple Desk',
//   ];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           if (query.isEmpty) {
//             close(context, null);
//           } else {
//             query = '';
//             showSuggestions(context);
//           }
//         },
//         icon: Icon(Icons.clear),
//       )
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: Icon(Icons.arrow_back));
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var items in searchTerms) {
//       if (items.toLowerCase().contains(query.toUpperCase())) {
//         matchQuery.add(items);
//       }
//     }
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//       itemCount: matchQuery.length,
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = query.isEmpty
//         ? searchTerms
//         : searchTerms.where((searchTerm) {
//       final searchTermLower = searchTerm.toLowerCase();
//       final queryLower = query.toLowerCase();
//
//       return searchTermLower.startsWith(queryLower);
//     }).toList();
//     return buildSuggestionsSuccess(suggestions);
//   }
//
//   Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
//     itemBuilder: (context, index) {
//       var result = suggestions[index];
//       final queryText = result.substring(0, query.length);
//       final remainingText = result.substring(query.length);
//       return ListTile(
//         onTap: () {
//           if (query.contains(result)) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Product1()));
//           } else {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Product1()));
//           }
//         },
//         // title: Text(result),
//         title: RichText(
//             text: TextSpan(
//                 text: queryText,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//                 children: [
//                   TextSpan(
//                       text: remainingText,
//                       style: TextStyle(fontSize: 18, color: Colors.grey))
//                 ])),
//       );
//     },
//     itemCount: suggestions.length,
//   );
// }
