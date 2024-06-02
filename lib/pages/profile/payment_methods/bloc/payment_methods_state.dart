part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

final class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}
