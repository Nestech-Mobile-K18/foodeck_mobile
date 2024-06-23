part of 'bill_detail_bloc.dart';

sealed class BillDetailEvent {

}

class BillDetailStarted extends BillDetailEvent {
  final int id;

  BillDetailStarted({required this.id});
}
