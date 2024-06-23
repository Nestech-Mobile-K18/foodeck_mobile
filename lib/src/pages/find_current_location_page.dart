import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/features/cal_move_time/bloc/cal_move_time_bloc.dart';
import 'package:template/src/features/location/bloc/location_bloc.dart';
import 'package:template/src/pages/error_page.dart';
import 'package:template/src/pages/export.dart';

class FindCurrentLocationPage extends StatefulWidget {
  const FindCurrentLocationPage({Key? key}) : super(key: key);

  @override
  _FindCurrentLocationPageState createState() =>
      _FindCurrentLocationPageState();
}

class _FindCurrentLocationPageState extends State<FindCurrentLocationPage> {
  @override
  void initState() {
    context.read<LocationBloc>().add(CurrentLocationStarted());
    // context.read<CalMoveTimeBloc>().add(CalMoveTimeStarted());
    super.initState();
  }

  Widget getCurrentLocationInProgress() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p80, horizontal: AppPadding.p24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppStrings.findingLocation, style: AppTextStyle.title),
                SizedBox(
                  height: AppSize.s12,
                ),
                Lottie.asset('assets/lottie/current_location.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is CurrentLocationInProgress) {
          return getCurrentLocationInProgress();
        } else if (state is CurrentLocationSuccess) {
          print(state);
          // if get current location success -> go home page
          return const HomePage();
        } else {
          return ErrorPage(onTryAgainPressed: () {
            context.read<LocationBloc>().add(CurrentLocationStarted());
          });
        }
      },
    );
  }
}
