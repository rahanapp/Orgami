class SellerModel {
  String? sellerId;
  String name;
  String email;
  String pincode;
  String address;
  String mobileNumber;
  String farmName;
  List product;
  String status;
  String password;
  SellerModel(
      {required this.address,
      this.sellerId,
      required this.password,
      required this.email,
      required this.mobileNumber,
      required this.name,
      required this.pincode,
      required this.product,
      required this.status,
      required this.farmName});

  Map<String, dynamic> tojson(id) => {
        "sellerId": id,
        "status": status,
        "name": name,
        "email": email,
        "pincode": pincode,
        "address": address,
        "mobileNumber": mobileNumber,
        "farmName": farmName,
        "product": product,
        "password":password
      };
  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
      address: json["address"],
      status: json["status"],
      password: json["password"],
      sellerId: json["sellerId"],
      email: json["email"],
      mobileNumber: json["mobileNumber"],
      name: json["name"],
      farmName: json["farmName"],
      product: json["product"] as List<dynamic>,
      pincode: json["pincode"]);
}
