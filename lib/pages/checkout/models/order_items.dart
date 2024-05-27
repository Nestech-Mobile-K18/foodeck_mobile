class OrderItem {
  final String? idOrder;
  final String? orderName;
  final String? status;
  final Map<String, dynamic>? informationOrder;
  final DateTime? createAt;

  OrderItem(
      {this.idOrder,
      this.orderName,
      this.status,
      this.informationOrder,
      this.createAt});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        idOrder: json['id_order'],
        orderName: json['order_name'],
        status: json['status'],
        informationOrder: json['information_order'],
        createAt: json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_order': idOrder,
      'order_name': orderName,
      'status': status,
      'information_order': informationOrder,
      'created_at': createAt
    };
  }
}
