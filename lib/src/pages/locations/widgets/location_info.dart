import 'package:template/src/pages/export.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo(
      {Key? key, required this.address, required this.locationName})
      : super(key: key);
  final String address;
  final String locationName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorsGlobal.white,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.location_on_outlined)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTextStyle.label),
                Text(address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTextStyle.labelGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
