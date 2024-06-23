part of 'bill_detail_bloc.dart';

sealed class BillDetailState {}

class BillDetailInitial extends BillDetailState {
  final int id;

  BillDetailInitial({this.id = 0});
  // final String idBill;
  // final int idFood;
  // final int quanity;
  // final double total;
}

class BillDetailInProgress extends BillDetailState {
  final bool loading;

  BillDetailInProgress({this.loading = true});
}

class BillDetailSuccess extends BillDetailState {
  final int id;
  // final String name;
  // final double rate;

  BillDetailSuccess({
    required this.id,
  });
}

class BillDetailFailure extends BillDetailState {
  final int id;

  BillDetailFailure({
    this.id = 0,
  });
}

class BillDetailReset extends BillDetailInitial {}
