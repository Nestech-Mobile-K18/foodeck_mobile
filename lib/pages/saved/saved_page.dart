import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/text_styles.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
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
            return Center(
                child: Lottie.network(
                    'https://lottie.host/c8590a03-ef81-4c20-94eb-cca6c731a0ff/plYvp8aTL1.json'));
          }
          final banners = snapshot.data!;
          Future deleteBanner(index) async {
            try {
              await supabase.from('banners').delete().match({
                'food': banners[index]['food'],
                'time': banners[index]['time'],
                'shop_name': banners[index]['shop_name'],
                'place': banners[index]['place'],
                'vote': banners[index]['vote']
              });
            } on AuthException catch (error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.message)));
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error occurred, please retry')));
            }
          }

          return snapshot.data!.isEmpty
              ? Center(
                  child: Lottie.network(
                      'https://lottie.host/c8590a03-ef81-4c20-94eb-cca6c731a0ff/plYvp8aTL1.json'))
              : Padding(
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
                              child: BannerItems(
                                  foodImage: banners[index]['food'],
                                  deliveryTime: banners[index]['time'],
                                  shopName: banners[index]['shop_name'],
                                  shopAddress: banners[index]['place'],
                                  rateStar: banners[index]['vote'],
                                  action: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        alignment: Alignment.center,
                                        title: Text(
                                          'Bạn có muốn xóa tất cả sản phẩm cùng tên này ra khỏi danh sách?',
                                          style: inter,
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      deleteBanner(index).then(
                                                          (value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    child: Text('Có',
                                                        style: inter.copyWith(
                                                            color:
                                                                Colors.red))),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Không',
                                                        style: inter.copyWith(
                                                            color:
                                                                Colors.blue)))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  heartColor: false,
                                  icon: Lottie.network(
                                      'https://lottie.host/78d14af8-9bff-4958-a221-398c3dcb295f/vTYXHtUqlb.json'))))));
        },
      ),
    );
  }
}
