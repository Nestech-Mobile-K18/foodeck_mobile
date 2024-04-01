import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class BannerItems extends StatefulWidget {
  const BannerItems({
    super.key,
    required this.foodImage,
    this.widthImage,
    required this.deliveryTime,
    required this.shopName,
    required this.shopAddress,
    required this.rateStar,
    this.paddingText,
    required this.action,
    required this.heartColor,
    this.icon,
    this.paddingImage,
  });
  final EdgeInsets? paddingText;
  final EdgeInsets? paddingImage;
  final String foodImage;
  final double? widthImage;
  final String deliveryTime;
  final String shopName;
  final String shopAddress;
  final String rateStar;
  final VoidCallback action;
  final bool heartColor;
  final Widget? icon;

  @override
  State<BannerItems> createState() => _BannerItemsState();
}

class _BannerItemsState extends State<BannerItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.paddingImage ?? EdgeInsets.zero,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(alignment: Alignment.topRight, children: [
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.foodImage,
                    ),
                    fit: BoxFit.cover,
                  )),
              width: widget.widthImage ?? MediaQuery.of(context).size.width,
              height: 160,
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  widget.deliveryTime,
                  style:
                      inter.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: widget.action,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 12),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: widget.icon ??
                      Icon(
                        widget.heartColor
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.heartColor ? globalPink : Colors.white,
                      ),
                ),
              ))
        ]),
        Padding(
          padding: widget.paddingText ?? EdgeInsets.zero,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
                text: TextSpan(
                    text: widget.shopName,
                    style: inter.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                  TextSpan(
                      text: widget.shopAddress,
                      style: inter.copyWith(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal))
                ])),
            TextButton.icon(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                onPressed: null,
                label: Text(widget.rateStar,
                    style: inter.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                icon: Image.asset(
                  star,
                  fit: BoxFit.cover,
                ))
          ]),
        )
      ]),
    );
  }
}
