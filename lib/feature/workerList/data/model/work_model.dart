class WorkModel {
  final String workerName;
  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> products;

  final double pay;

  WorkModel({
    required this.workerName,
    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.products,

    required this.pay,
  });

  // Convert to JSON for saving
  Map<String, dynamic> toMap() {
    return {
      "workerName": workerName,
      "address": address,
      "phoneNumber": phoneNumber,
      "date": date,
      "products": products,

      "pay": pay,
    };
  }

  // Create an instance from JSON
  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      workerName: json["workerName"],
      address: json["address"],
      phoneNumber: json["phoneNumber"],
      date: json["date"],
      products: List<Map<String, String>>.from(json["products"]),

      pay: json["pay"],
    );
  }
}
