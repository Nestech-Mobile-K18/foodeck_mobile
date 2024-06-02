import 'package:template/source/export.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(homePageInitialEvent);
    on<HomePageSelectIndexEvent>(homePageSelectIndexEvent);
  }

  FutureOr<void> homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(const HomePageSelectIndex0State(index: 0));
  }

  FutureOr<void> homePageSelectIndexEvent(
      HomePageSelectIndexEvent event, Emitter<HomePageState> emit) {
    RiveUtils.changeSMITriggerState(
        RiveUtils.bottomModel[event.index].statusTrigger!);
    if (event.index == 0) {
      emit(HomePageSelectIndex0State(index: event.index));
    } else if (event.index == 1) {
      emit(HomePageSelectIndex1State(index: event.index));
    } else if (event.index == 2) {
      emit(HomePageSelectIndex2State(index: event.index));
    } else if (event.index == 3) {
      emit(HomePageSelectIndex3State(index: event.index));
    }
  }
}
