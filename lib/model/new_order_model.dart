class NewOrderModel {
  String? orderId;
  String buyerId;
  String sellerId;

  String product;
  String quantity;
  String rate;
  String ratePerQuantity;
  String buyerName;
  String orderStatus;
  String requestTime;
  String requestDate;

  NewOrderModel(
      {required this.buyerId,
      required this.orderStatus,
      required this.buyerName,
      required this.ratePerQuantity,
      required this.requestDate,
      required this.requestTime,
      this.orderId,
      required this.product,
      required this.quantity,
      required this.rate,
      required this.sellerId});

  Map<String, dynamic> toJson(id) => {
        "orderId": id,
        "requestDate":requestDate,
        "requestTime":requestTime,
        "buyerId": buyerId,
        "orderStatus": orderStatus,
        "sellerId": sellerId,
        "product": product,
        "quantity": quantity,
        "rate": rate,
        "buyerName": buyerName,
        "ratePerQuantity": ratePerQuantity
      };
  factory NewOrderModel.fromJson(Map<String, dynamic> json) => NewOrderModel(
      buyerId: json["buyerId"],
      requestDate: json["requestDate"],
      requestTime: json["requestTime"],
      buyerName: json["buyerName"],
      orderStatus: json["orderStatus"],
      orderId: json["orderId"],
      product: json["product"],
      quantity: json["quantity"],
      rate: json["rate"],
      ratePerQuantity: json["ratePerQuantity"],
      sellerId: json["sellerId"]);
}
