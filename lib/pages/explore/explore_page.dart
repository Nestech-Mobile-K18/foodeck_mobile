import 'package:template/source/export.dart';

part 'explore_page_extension1.dart';
part 'explore_page_extension2.dart';
part 'explore_page_extension3.dart';
part 'explore_page_extension4.dart';
part 'explore_page_extension_ui.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final explorePageBloc = ExplorePageBloc();

  @override
  void initState() {
    explorePageBloc.add(ExplorePageInitialEvent());
    super.initState();
  }

  void toggleLike(ExplorePageLikeState state, BuildContext context) {
    if (!SavedListData.saveFood.contains(state.restaurantModel)) {
      CustomWidgets.customSnackBar(
          context, AppColor.buttonShadowBlack, 'You just unliked this item');
    } else {
      CustomWidgets.customSnackBar(
          context, AppColor.globalPinkShadow, 'You just liked this item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExplorePageBloc, ExplorePageState>(
      bloc: explorePageBloc,
      listenWhen: (previous, current) => current is ExplorePageActionState,
      buildWhen: (previous, current) => current is! ExplorePageActionState,
      listener: (context, state) {
        if (state is ExplorePageSearchNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.searchPage);
        } else if (state is ExplorePageNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.dealPage,
              arguments: DealsPage(restaurant: state.restaurantModel));
        } else if (state is ExplorePageCartNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.addCart);
        } else if (state is ExplorePageLikeState) {
          toggleLike(state, context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ExplorePageInitial:
            return const LoadingAnimationRive();
          case ExplorePageLoadingState:
            return const LoadingAnimationRive();
          case ExplorePageLoadingSuccessState:
            final successState = state as ExplorePageLoadingSuccessState;
            return ExploreBody(
                explorePageBloc: explorePageBloc, successState: successState);
        }
        return const SizedBox();
      },
    );
  }
}
