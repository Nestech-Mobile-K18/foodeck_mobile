import 'package:bloc/bloc.dart';
import 'package:template/src/features/signup/data/model.dart';
import 'package:template/src/services/signup_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpService _signupService;

  SignupBloc(this._signupService) : super(SignupInitial()) {
    on<SignUpStarted>(_onSignUpEmailStarted);
    on<VerifyStarted>(_onVerifyEmailStarted);
  }

  //sign up with email
  Future<void> _onSignUpEmailStarted(
      SignUpStarted event, Emitter<SignupState> emit) async {
    emit(SignupInProgress());
    try {
      SignUpRequest request = SignUpRequest(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: event.phone);

      String? response = await _signupService.signup(request);
      if (response != null) {
        emit(VerifyInProgress(
          email: event.email,
        ));
      } else {
        emit(SignupFailure());
      }
    } catch (e) {
      emit(SignupFailure());
    }
  }

  Future<void> _onVerifyEmailStarted(
      VerifyStarted event, Emitter<SignupState> emit) async {
    emit(VerifyInProgress(email: event.email));
    try {
      VerifyRequest request =
          VerifyRequest(email: event.email, token: event.token);

      await _signupService.verify(request);

      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure());
    }
  }
}
