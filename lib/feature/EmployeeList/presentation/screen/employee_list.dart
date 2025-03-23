import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/feature/EmployeeList/presentation/screen/employee_details.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key, required this.employeeList});

  final List<Map<String, dynamic>> employeeList;
  static const String name = "employee_list";

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late List<Map<String, dynamic>> localemployeeList;
  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    localemployeeList = List.from(widget.employeeList);
  }

  // Search function for filtering the list
  void searchEmployeeList(String query) async {
    setState(() {
      searchQuery = query.toLowerCase();
      isSearching = true;
    });

    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    // Query Firestore to find matches based on employee name
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('NewEmployee')
        .where('employeeName', isGreaterThanOrEqualTo: query)
        .where('employeeName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults = snapshot.docs;
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Employee List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by  Name",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchEmployeeList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildEmployeeList(searchResults)
                : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('NewEmployee')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No employee found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return _buildEmployeeList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build the list of employees, either filtered or all
  Widget _buildEmployeeList(List<QueryDocumentSnapshot> employeeList) {
    return ListView.builder(
      itemCount: employeeList.length,
      itemBuilder: (context, index) {
        var employee = employeeList[index];
        var employeeData = employee.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetailsScreen(
                    nameController: employeeData['employeeName'] ?? "",
                    birthdayController: employeeData['date'] ?? "",
                    phoneController: employeeData['phoneNumber'] ?? "",
                    emailController: employeeData['email'],
                    phoneNumberController: employeeData['phoneNumber'] ?? "",
                    nidController: employeeData['employeeNidController'] ?? "",
                    fatherNameController: employeeData['employeeFatherName'] ?? "",
                    motherNameController: employeeData['employeeMotherName'] ?? "",
                    fatherPhoneNumberController: employeeData['fatherPhoneNumber'] ?? "",
                    motherPhoneNumberController: employeeData['motherPhoneNumber'] ?? "",
                    addressController: employeeData['address'] ?? "",
                    imageController: employeeData['image'] ?? "",
                    monthlyController: employeeData['monthly'] ?? "",
                  ),
                ),
              );
            },
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffF7FAFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${index + 1}.", style: const TextStyle(fontSize: 15)),
                  Text("Name: ${employeeData['employeeName']}", style: const TextStyle(fontSize: 15)),
                  Text("Date: ${employeeData['date']}", style: const TextStyle(fontSize: 15)),
                  GestureDetector(
                    onTap: () => _deleteEmployee(employee.id, context),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🔥 Firestore Delete Function
  void _deleteEmployee(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('NewEmployee').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Employee deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting employee: $e")),
      );
    }
  }
}
