
class EmployeeModel {
  final String employeeFatherName;
  final String employeeName;
  final String email;
  final String address;
  final String phoneNumber;
  final String date;
  final List<Map<String, String>> employees;
  final String employeeMotherName;
  final String fatherPhoneNumber;
  final String motherPhoneNumber;
  final String employeeNidController;
  final String imageController;
  final String monthlyController;


  EmployeeModel( {
    required this.imageController,
    required this.employeeFatherName,
    required this.employeeName,
    required this.address,
    required this.email,
   required this.monthlyController,
    required this.phoneNumber,
    required this.date,
    required this.employees,
    required this.employeeMotherName,
    required this.fatherPhoneNumber,
    required this.motherPhoneNumber,
    required this.employeeNidController,
  });

  // Convert to JSON
  Map<String, dynamic> toMap() {
    return {
      "employeeFatherName": employeeFatherName,
      "employeeName": employeeName,
      "address": address,
      "phoneNumber": phoneNumber,
      "date": date,
      "employees": employees,
      "employeeMotherName": employeeMotherName,
      "fatherPhoneNumber": fatherPhoneNumber,
      "motherPhoneNumber": motherPhoneNumber,
      "employeeNidController": employeeNidController,
      "image":imageController,
      "email":email,
      "monthly":monthlyController
    };
  }

  // // Create an instance from JSON
  // factory EmployeeModel.fromJson(Map<String, dynamic> json) {
  //   return EmployeeModel(
  //     employeeFatherName: json["employeeFatherName"],
  //     employeeName: json["employeeName"],
  //     address: json["address"],
  //     phoneNumber: json["phoneNumber"],
  //     date: json["date"],
  //     employees: List<Map<String, String>>.from(json["employees"]),
  //     employeeMotherName: json["employeeMotherName"],
  //     fatherPhoneNumber: json["fatherPhoneNumber"],
  //     motherPhoneNumber: json["motherPhoneNumber"],
  //     employeeNidController: json["employeeNidController"], imageController: json["imageController"],
  //   );
  // }
}
