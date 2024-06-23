part of 'bill_bloc.dart';

sealed class BillState {}

class BillInitial extends BillState {
  final String id;
  final int idRestaurant;
  final String idCustomer;
  final double total;
  final double? vat;
  final double? fee;
  final int payment;
  final String? note;
  final int deliveryAddress;
  final String? voucher;
  final String? status;
  final String? paymentType;

  BillInitial(
      { this.id='',
       this.idRestaurant=0,
       this.idCustomer='',
       this.total=0,
       this.vat=0,
       this.fee=0,
       this.payment=0,
       this.note='',
       this.deliveryAddress=0,
       this.voucher='',
       this.status='',
       this.paymentType=''});
}


class BillInProgress extends BillState {
  final bool loading;

  BillInProgress({this.loading = true});
}

class BillSuccess extends BillState {
  final String id;
  // final int idRestaurant;
  // final String idCustomer;
  // final double total;
  // final double? vat;
  // final double? fee;
  // final int payment;
  // final String? note;
  // final int deliveryAddress;
  // final String? voucher;
  // final String? status;
  // final String? paymentType;

  BillSuccess({
    required this.id,
    
  });
}

class BillFailure extends BillState {
  final int id;
 

  BillFailure({
    this.id = 0,
    
  });
}

class BillReset extends BillInitial {}
