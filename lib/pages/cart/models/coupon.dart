import 'dart:ffi';

class Coupon {
  final String? id;
  final String? code;
  final bool? status;
  final int? value;
  final List<String>? listUserActived;
  Coupon({this.id, this.code, this.status,this.value,this.listUserActived});


  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      status: json['status'],
      value: json['value'],
        listUserActived: json['list_user_actived'] != null ? List<String>.from(json['list_user_actived']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'status': status,
      'value': value,
      'listUserActived': listUserActived,
    };
  }
}