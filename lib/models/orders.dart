class Order {
  String orderId;
  String refId;
  String name;
  String contact;
  List<OrderItem> orders;
  int amount;

  Order({
    required this.orderId,
    required this.refId,
    required this.name,
    required this.contact,
    required this.orders,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'refId': refId,
      'name': name,
      'contact': contact,
      'orders': orders.map((orderItem) => orderItem.toJson()).toList(),
      'amount': amount,
    };
  }
}

class OrderItem {
  String itemName;
  int quantity;

  OrderItem({
    required this.itemName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }
}
