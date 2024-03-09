class ProductModel {
  String id;
  String rate;
  String quantity;

  ProductModel({required this.id, required this.quantity, required this.rate});
  Map<String, dynamic> toJson() => {
        "id": id,
        "rate": rate,
        "quantity": quantity,
      };
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        quantity: json["quantity"],
        rate: json["rate"],
      );
}
