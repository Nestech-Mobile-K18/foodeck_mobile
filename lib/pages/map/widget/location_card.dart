import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

/// A custom widget for displaying location information.
class LocationCard extends StatefulWidget {
  final int? itemCount;
  final String? nameOfPlace;
  final String? address;

  final Function(int)? onItemSelected;
  final Function(int)? onLongPress; // Update the callback type
  final List<Map<String, String?>>? locationData;
  final bool? isDeleting;

  const LocationCard({
    super.key,
    this.nameOfPlace,
    this.address,
    this.itemCount,
    this.onItemSelected,
    this.isDeleting,
    this.onLongPress, // Update the parameter type
    this.locationData,
  });

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final ValueNotifier<int> currentCard = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: PageView.builder(
          scrollBehavior: const ScrollBehavior(),
          onPageChanged: (value) {
            currentCard.value = value;
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(value);
            }
          },
          controller: pageController,
          clipBehavior: Clip.none,
          itemCount: widget.locationData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            if (widget.isDeleting == true && index == currentCard.value) {
              // Process deletion of data in this index
              // For example, if locationData is a List<Map<String, String>> you can use removeAt(index)
              if (widget.locationData != null) {
                setState(() {
                  widget.locationData!.removeAt(index);
                });
              }
              return Container(); // Returns an empty container to hide the deleted location
            } else {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          if (widget.onLongPress != null) {
                            widget.onLongPress!(index);
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 80,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Image.asset(
                                    MediaRes.location,
                                    color: ColorsGlobal.globalBlack,
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        title: widget.locationData?[index]
                                            ['type_address'],
                                        color: ColorsGlobal.globalBlack,
                                        size: 15,
                                      ),
                                      Flexible(
                                        child: CustomText(
                                          maxLine: 2,
                                          title: widget.locationData?[index]
                                              ['address'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          color: ColorsGlobal.globalBlack,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
