
class PayModel {

  final String name;

  final String phoneNumber;
  final String date;
  final List<Map<String, String>> paying;
  final String money;


  PayModel(   {
   required this.name,required this.phoneNumber,required this.date,required this.paying,required this.money,

  });

  // Convert to JSON
  Map<String, dynamic> toMap() {
    return {
      "name": name,

      "phoneNumber": phoneNumber,
      "date": date,
      "money": money,
      'payingList':paying

    };
  }

  // // Create an instance from JSON
  // factory PayModel.fromJson(Map<String, dynamic> json) {
  //   return PayModel(
  //     name: json["name"],
  //
  //     money: json["money"],
  //     phoneNumber: json["phoneNumber"],
  //     date: json["date"], paying:List<Map<String, String>>.from(json["payingList"]) ,
  //
  //
  //
  //
  //   );
  // }
}
