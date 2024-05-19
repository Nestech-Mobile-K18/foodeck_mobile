import 'package:template/pages/export.dart';

class NotificationVew extends StatefulWidget {
  const NotificationVew({Key? key}) : super(key: key);

  @override
  _NotificationVewState createState() => _NotificationVewState();
}

class _NotificationVewState extends State<NotificationVew> {
  late final List<Notifiacation> _notifications;
  @override
  void initState() {
    _notifications = notifications;
    super.initState();
  }

  String calculate(DateTime time) {
    Duration difference = DateTime.now().difference(time);
    return difference.inDays > 0
        ? difference.inDays.toString()
        : difference.inHours > 0
            ? difference.inHours.toString()
            : difference.inMinutes > 0
                ? difference.inMinutes.toString()
                : difference.inSeconds.toString();
  }

  String unitTime(DateTime time) {
    Duration difference = DateTime.now().difference(time);
    return difference.inDays > 0
        ? 'd'
        : difference.inHours > 0
            ? 'h'
            : difference.inMinutes > 0
                ? 'm'
                : 's';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p24, vertical: AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.notifications,
            style: AppTextStyle.title,
          ),
          SizedBox(
            height: AppSize.s12,
          ),
          ListView.separated(
            physics:
                const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
            itemCount: _notifications.length,
            shrinkWrap: true,

            itemBuilder: (context, index) {
              return ListTile(
                  leading: _notifications[index].isRead == false
                      ? Icon(
                          Icons.circle_rounded,
                          size: AppSize.s6,
                          color: ColorsGlobal.globalPink,
                        )
                      : null,
                  trailing: Text(
                    "${calculate(_notifications[index].time)}${unitTime(_notifications[index].time)}",
                    style: AppTextStyle.value,
                  ),
                  title: Text(_notifications[index].content,
                      style: AppTextStyle.label));
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ],
      ),
    ));
  }
}
