class SalesNotification {
  final DateTime dateTime;
  final String itemName;
  final int quantity;

  SalesNotification({
    required this.dateTime,
    required this.itemName,
    required this.quantity,
  });

  factory SalesNotification.fromJson(Map<String, dynamic> json){
    return SalesNotification(
      dateTime: DateTime.parse(json['dateTime']), 
      itemName: json['itemDescription'], 
      quantity: json['quantity'],);
  }
}