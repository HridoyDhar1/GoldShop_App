
class OtherCostModel {

  final String name;


  final String money;


  OtherCostModel(   {
    required this.name,required this.money,

  });

  // Convert to JSON
  Map<String, dynamic> toMap() {
    return {
      "name": name,


      "money": money,
      // 'payingList':paying

    };
  }

  // Create an instance from JSON
  // factory OtherCostModel.fromJson(Map<String, dynamic> json) {
  //   return OtherCostModel(
  //     name: json["name"],
  //
  //     money: json["money"],
  //   paying:List<Map<String, String>>.from(json["payingList"]) ,
  //
  //
  //
  //
  //   );
  // }
}
