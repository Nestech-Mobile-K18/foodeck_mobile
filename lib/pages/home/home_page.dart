import 'package:template/source/export.dart';

part 'home_page_extension_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomePageBloc>().add(HomePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomePageLoadingState:
            return const LoadingAnimationRive();
          case HomePageSelectIndex0State:
            final selectIndex = state as HomePageSelectIndex0State;
            return BottomRoute(currentIndex: selectIndex.index);
          case HomePageSelectIndex1State:
            final selectIndex = state as HomePageSelectIndex1State;
            return BottomRoute(currentIndex: selectIndex.index);
          case HomePageSelectIndex2State:
            final selectIndex = state as HomePageSelectIndex2State;
            return BottomRoute(currentIndex: selectIndex.index);
          case HomePageSelectIndex3State:
            final selectIndex = state as HomePageSelectIndex3State;
            return BottomRoute(currentIndex: selectIndex.index);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
