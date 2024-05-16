import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

part 'bear_snack_bar_extension.dart';

class ShowBearSnackBar {
  static Future showBearSnackBar(BuildContext context, String content) async {
    await Future(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: BearSnackBar(content: content),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0)));
  }
}
