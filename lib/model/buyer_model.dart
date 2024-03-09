class BuyerModel {
  String ?buyerId;
  String name;
  String email;
  String pincode;
  String address;
  String mobileNumber;
  BuyerModel(
      {required this.address,
       this.buyerId,
      required this.email,
      required this.mobileNumber,
      required this.name,
      required this.pincode});

  Map<String, dynamic> tojson(id) => {
        "buyerId": id,
        "name": name,
        "email": email,
        "pincode": pincode,
        "address": address,
        "mobileNumber": mobileNumber
      };
  factory BuyerModel.fromJson(Map<String, dynamic> json) => BuyerModel(
      address: json["address"],
      buyerId: json["buyerId"],
      email: json["email"],
      mobileNumber: json["mobileNumber"],
      name: json["name"],
      pincode: json["pincode"]);
}
