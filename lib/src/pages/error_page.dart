import 'package:template/src/pages/export.dart';
import 'package:template/src/widgets/error_text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.onTryAgainPressed,
  });

  final Function() onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppPadding.p18),
            child: Image.asset(
              'assets/images/icon.png',
              width: double.infinity,
              height: AppSize.s150,
            ),
          ),
          const ErrorText(),
          SizedBox(height: AppSize.s15),
          ElevatedButton(
            onPressed: onTryAgainPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsGlobal.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s30),
              ),
            ),
            child: Text(
              AppStrings.tryAgain,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
