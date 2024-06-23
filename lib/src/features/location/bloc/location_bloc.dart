import 'package:bloc/bloc.dart';
import 'package:template/src/pages/export.dart';
import 'package:template/src/services/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc(this._locationService) : super(LocationInitial()) {
    on<CurrentLocationStarted>(_onCurrentLocationStarted);
  }

  // get current location
  Future<void> _onCurrentLocationStarted(
      CurrentLocationStarted event, Emitter<LocationState> emit) async {
    emit(CurrentLocationInProgress());
    try {
      LocationData? response = await _locationService.getCurrentLocation();
      //get name location
      String? address =
          await _locationService.getAddress(response!.latitude!, response.longitude!);

      String? name =
          await _locationService.getLocationName(response.latitude!, response.longitude!);

      if (name == null || address == null || response == null) {
        emit(CurrentLocationFailure(currentLocation: null));
      } else {
        emit(CurrentLocationSuccess(
            currentLocation: response, address: address, locationName: name));
      }
    } catch (e) {
      emit(CurrentLocationFailure(currentLocation: null));
    }
  }
}
