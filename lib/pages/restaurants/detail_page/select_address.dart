import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<SelectAddress> createState() => _SelectAddressState();

  static _SelectAddressState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SelectAddressState>();
}

class _SelectAddressState extends State<SelectAddress> {
  String address = '';
  String address1 = '';

  void setAddress(index) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        responses[index]['latitude'], responses[index]['longitude']);
    Placemark place = placeMarks[0];
    setState(() {
      // Convert latitude and longitude to address
      address = '${place.street}, ${place.subAdministrativeArea}';
      address1 = '${place.administrativeArea}, ${place.country}';
      sharedPreferences.setString('address', address);
      sharedPreferences.setString('address1', address1);
      sharedPreferences.setDouble(
          'latitudeAddress', responses[index]['latitude']);
      sharedPreferences.setDouble(
          'longitudeAddress', responses[index]['longitude']);
    });
  }

  // Define setters to be used by children widgets
  set responsesState(List response) {
    setState(() {
      responses = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: widget.textEditingController.text.isEmpty ? 350 : 800,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: LocationField(
                  textEditingController: widget.textEditingController)),
          widget.textEditingController.text.isEmpty
              ? const SizedBox()
              : Divider(
                  thickness: 8,
                  color: Colors.grey[200],
                ),
          Flexible(
            child: widget.textEditingController.text.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: responses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                moveCamera(index).then(
                                  (value) => Future.delayed(
                                      const Duration(milliseconds: 1500),
                                      () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                              title: const CustomText(
                                                  content:
                                                      'Do you want to save this location?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      widget
                                                          .textEditingController
                                                          .clear();
                                                      setAddress(index);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const CustomText(
                                                        content: 'Save',
                                                        color: AppColor
                                                            .globalPink)),
                                                TextButton(
                                                    onPressed: () {
                                                      widget
                                                          .textEditingController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const CustomText(
                                                        content: 'No'))
                                              ],
                                            ),
                                          )),
                                );
                              },
                              leading: const Icon(Icons.location_on_outlined),
                              title: CustomText(
                                  content: responses[index]['name'],
                                  fontWeight: FontWeight.bold),
                              subtitle: CustomText(
                                  content: responses[index]['address'])),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
