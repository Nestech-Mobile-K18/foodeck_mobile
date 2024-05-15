import 'package:rive/rive.dart';
import 'package:template/pages/home/bloc/home_page_bloc.dart';
import 'package:template/source/export.dart';

part 'home_page_extension_ui.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homePageBloc = HomePageBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      bloc: homePageBloc,
      listenWhen: (previous, current) => current is HomePageActionState,
      buildWhen: (previous, current) => current is! HomePageActionState,
      listener: (context, state) {
        if (state is HomePageNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.splashPage);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomePageSelectIndex0State:
            final selectIndex = state as HomePageSelectIndex0State;
            return BottomRoute(
                currentIndex: selectIndex.index, homePageBloc: homePageBloc);
          case HomePageSelectIndex1State:
            final selectIndex = state as HomePageSelectIndex1State;
            return BottomRoute(
                currentIndex: selectIndex.index, homePageBloc: homePageBloc);
          case HomePageSelectIndex2State:
            final selectIndex = state as HomePageSelectIndex2State;
            return BottomRoute(
                currentIndex: selectIndex.index, homePageBloc: homePageBloc);
          case HomePageSelectIndex3State:
            final selectIndex = state as HomePageSelectIndex3State;
            return BottomRoute(
                currentIndex: selectIndex.index, homePageBloc: homePageBloc);
        }
        return BottomRoute(currentIndex: 0, homePageBloc: homePageBloc);
      },
    );
  }
}
