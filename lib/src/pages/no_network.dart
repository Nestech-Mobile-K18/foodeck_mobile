import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/features/network/bloc/network_bloc.dart';
import 'package:template/src/pages/export.dart';
import 'package:template/src/widgets/error_no_network_text.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({ Key? key }) : super(key: key);

  @override
  _NoNetworkState createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
class NoNetworkPage extends StatelessWidget {
  const NoNetworkPage({
    super.key,
  });


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
            child: Lottie.asset('assets/lottie/no_network.json'),
          ),
          const ErrorNoNetworkText(),
          SizedBox(height: AppSize.s15),
          ElevatedButton(
            onPressed:()=>  context.read<NetworkBloc>().add(NetworkObserve()),
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
