import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/loading_animation.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  void check(int index) {
    setState(() {
      switch (index) {
        case 0:
          deleteBanner(index);
          break;
        case 1:
          deleteBanner(index);
          break;
        case 2:
          deleteBanner(index);
          break;
        case 3:
          deleteBanner(index);
          break;
        case 4:
          deleteBanner(index);
          break;
        case 5:
          deleteBanner(index);
          break;
        case 6:
          deleteBanner(index);
          break;
        case 7:
          deleteBanner(index);
          break;
      }
    });
  }

  Future deleteBanner(index) async {
    try {
      await supabase.from('banners').delete().match({
        'food': list[index].a,
        'time': list[index].b,
        'shop_name': list[index].c,
        'place': list[index].d,
        'vote': list[index].e
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: StreamBuilder(
              stream: data,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Saved (0)',
                      style: inter.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold));
                }
                return Text('Saved (${snapshot.data!.length})',
                    style: inter.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold));
              },
            ),
          )),
      body: StreamBuilder(
        stream: data,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: WaveDots(size: 36, color: Colors.white));
          }
          final banners = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 144),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: banners.length,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(alignment: Alignment.topRight, children: [
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          banners[index]['food'],
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                  width: MediaQuery.of(context).size.width,
                                  height: 160,
                                ),
                              ),
                              Positioned(
                                left: 12,
                                bottom: 12,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      banners[index]['time'],
                                      style: inter.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (!snapshot.hasData) {
                                      deleteBanner(index);
                                    }
                                    deleteBanner(index);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: globalPink,
                                  ))
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: banners[index]['shop_name'],
                                        style: inter.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: banners[index]['place'],
                                          style: inter.copyWith(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal))
                                    ])),
                                TextButton.icon(
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: null,
                                  label: Text(banners[index]['vote'],
                                      style: inter.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  icon: const Icon(
                                    Icons.star,
                                    color: voteYellow,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
            ),
          );
        },
      ),
    );
  }
}
