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
  @override
  void initState() {
    context.read<ExplorePageBloc>().add(ExplorePageInitialEvent());
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
      listenWhen: (previous, current) => current is ExplorePageActionState,
      buildWhen: (previous, current) => current is! ExplorePageActionState,
      listener: (context, state) {
        if (state is ExplorePageSearchNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.searchPage);
        } else if (state is ExplorePageNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.restaurantPage,
              arguments: RestaurantPage(restaurant: state.restaurantModel));
        } else if (state is ExplorePageCartNavigateActionState) {
          Navigator.pushNamed(context, AppRouter.restaurantCart);
        } else if (state is ExplorePageLikeState) {
          toggleLike(state, context);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ExplorePageLoadingState:
            return const LoadingAnimationRive();
          case ExplorePageLoadingSuccessState:
            final successState = state as ExplorePageLoadingSuccessState;
            return ExploreBody(successState: successState);
          default:
            return const LoadingAnimationRive();
        }
      },
    );
  }
}
