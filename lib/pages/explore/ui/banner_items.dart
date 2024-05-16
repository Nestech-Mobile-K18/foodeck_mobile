import 'package:template/source/export.dart';

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
    this.action,
    this.heartColor,
    this.icon,
    this.paddingImage,
    this.onTap,
    this.iconShape,
    this.heartIcon,
    this.badge,
    this.voteStar,
  });

  final EdgeInsets? paddingText;
  final EdgeInsets? paddingImage;
  final String foodImage;
  final double? widthImage;
  final String deliveryTime;
  final String shopName;
  final String shopAddress;
  final String rateStar;
  final VoidCallback? action;
  final Color? heartColor;
  final IconData? iconShape;
  final Widget? icon;
  final VoidCallback? onTap;
  final Widget? heartIcon;
  final Widget? badge;
  final Widget? voteStar;

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
          GestureDetector(
            onTap: widget.onTap,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
          ),
          widget.badge ??
              Positioned(
                  left: 12,
                  bottom: 12,
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: CustomText(
                              content: widget.deliveryTime,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)))),
          widget.heartIcon ??
              GestureDetector(
                  onTap: widget.action,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12, top: 12),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: widget.icon ??
                          Icon(
                            widget.iconShape,
                            color: widget.heartColor,
                          ),
                    ),
                  ))
        ]),
        Padding(
          padding: widget.paddingText ?? const EdgeInsets.only(top: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(content: widget.shopName, fontWeight: FontWeight.bold),
              CustomText(
                  content: widget.shopAddress, fontSize: 15, color: Colors.grey)
            ]),
            widget.voteStar ??
                TextButton.icon(
                    style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                    onPressed: null,
                    label: CustomText(
                        content: widget.rateStar,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    icon: Image.asset(
                      Assets.star,
                      fit: BoxFit.cover,
                    ))
          ]),
        )
      ]),
    );
  }
}
