import 'package:template/source/export.dart';

class ProfileButtons {
  final String icon;
  final String info;
  final KindSetting kindSetting;

  ProfileButtons(this.icon, this.info, this.kindSetting);

  static List<ProfileButtons> profileButtons = [
    ProfileButtons(Assets.userCircle, 'Edit Account', KindSetting.account),
    ProfileButtons(Assets.mapPin, 'My locations', KindSetting.account),
    ProfileButtons(Assets.package, 'My Orders', KindSetting.account),
    ProfileButtons(
        Assets.creditCardIcon, 'Payment Methods', KindSetting.account),
    ProfileButtons(Assets.starBorder, 'My reviews', KindSetting.account),
    ProfileButtons(Assets.info, 'About us', KindSetting.general),
    ProfileButtons(Assets.database, 'Data usage', KindSetting.general),
  ];
}

enum KindSetting { account, general }
