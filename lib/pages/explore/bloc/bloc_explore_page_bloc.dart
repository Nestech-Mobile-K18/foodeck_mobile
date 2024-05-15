import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_explore_page_event.dart';
part 'bloc_explore_page_state.dart';

class ExplorePageBloc extends Bloc<ExplorePageEvent, ExplorePageState> {
  ExplorePageBloc() : super(ExplorePageInitial()) {
    on<ExplorePageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
