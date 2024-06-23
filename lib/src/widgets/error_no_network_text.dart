import 'package:template/src/pages/export.dart';

class ErrorNoNetworkText extends StatelessWidget {
  const ErrorNoNetworkText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.oops,
          style: textTheme.bodyLarge,
        ),
        Text(
          AppStrings.noInternetConnection,
          style: textTheme.bodyMedium,
        ),
        Text(
          AppStrings.checkYourInternet,
          style: textTheme.bodyMedium,
        ),
        Text(
          AppStrings.tryAgainLater,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
