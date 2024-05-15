import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopFood>(
        builder: (BuildContext context, TopFood value, Widget? child) {
      Future deleteBanner(index) async {
        try {
          await supabase.from('items').delete().match({
            'food': value.saveFood[index].foodOrder,
            'time_delivery': value.saveFood[index].time,
            'shop_name': value.saveFood[index].shopName,
            'place': value.saveFood[index].place,
            'vote': value.saveFood[index].vote
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: buttonShadowBlack,
                  content: Text('You just unliked this item'))));
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text(error.message)));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text('Error occurred, please retry')));
        }
      }

      return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomText(
                      content: 'Saved (${value.saveFood.length})',
                      fontSize: 20,
                      fontWeight: FontWeight.bold))),
          body: value.saveFood.isEmpty
              ? Center(child: Lottie.asset(Assets.shoppingCart))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 144),
                  child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: value.saveFood.length,
                          scrollDirection: Axis.vertical,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: BannerItems(
                                  foodImage: value.saveFood[index].foodOrder,
                                  deliveryTime: value.saveFood[index].time,
                                  shopName: value.saveFood[index].shopName,
                                  shopAddress: value.saveFood[index].place,
                                  rateStar: value.saveFood[index].vote,
                                  action: () {
                                    showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const SizedBox(),
                                      transitionBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return ScaleTransition(
                                          scale:
                                              Tween<double>(begin: 0.5, end: 1)
                                                  .animate(animation),
                                          child: FadeTransition(
                                            opacity: Tween<double>(
                                                    begin: 0.5, end: 1)
                                                .animate(animation),
                                            child: CupertinoAlertDialog(
                                              title: const CustomText(
                                                  content:
                                                      'Do you want to remove this item from saved list?'),
                                              actions: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            deleteBanner(index);
                                                            value.removeFromList(
                                                                value.saveFood[
                                                                    index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const CustomText(
                                                                  content:
                                                                      'Yes',
                                                                  color: Colors
                                                                      .red)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const CustomText(
                                                                  content: 'No',
                                                                  color: Colors
                                                                      .blue))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Lottie.asset(Assets.heartBreak)))))));
    });
  }
}
