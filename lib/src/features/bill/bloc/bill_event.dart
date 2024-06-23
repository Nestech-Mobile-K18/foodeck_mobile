part of 'bill_bloc.dart';

sealed class BillEvent {

}

class BillStarted extends BillEvent {
  final String id;

  BillStarted({required this.id});
}

class BillDetailStarted extends BillEvent {
  final int id;

  BillDetailStarted({required this.id});
}
