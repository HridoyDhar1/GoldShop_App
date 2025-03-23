import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldshop/feature/workerList/presentation/screen/work_list_details.dart';

class WorkingListScreen extends StatefulWidget {
  const WorkingListScreen({super.key, required this.workList});

  final List<Map<String, dynamic>> workList;
  static const String name = "working_list";

  @override
  State<WorkingListScreen> createState() => _WorkingListScreenState();
}

class _WorkingListScreenState extends State<WorkingListScreen> {
  String searchQuery = "";
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;

  void searchWorkerList(String query) async {
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

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('GiveWork')
        .where('workerName', isGreaterThanOrEqualTo: query)
        .where('workerName', isLessThanOrEqualTo: query + '\uf8ff')
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
      appBar: AppBar(title: const Text("Working List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Name",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: searchWorkerList,
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : searchResults.isNotEmpty
                ? _buildWorkerList(searchResults)
                : StreamBuilder(
              stream: FirebaseFirestore.instance.collection("GiveWork").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No worker found!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return _buildWorkerList(snapshot.data!.docs);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerList(List<QueryDocumentSnapshot> workerList) {
    return ListView.builder(
      itemCount: workerList.length,
      itemBuilder: (context, index) {
        var work = workerList[index];
        var workData = work.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkingDetailsScreen(
                    workerName: workData['workerName'],
                    address: workData['address'],
                    phoneNumber: workData['phoneNumber'],
                    date: workData['date'],
                    products: (workData['products'] as List<dynamic>)
                        .map((item) => Map<String, String>.from(item))
                        .toList(),
                    pay: workData['pay'],
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70,
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
                  Text("Name: ${workData['workerName']}", style: const TextStyle(fontSize: 15)),
                  Text("Money: ${workData['pay']}", style: const TextStyle(fontSize: 15)),
                  GestureDetector(
                    onTap: () => _deleteWorker(work.id, context),
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

  void _deleteWorker(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('GiveWork').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error deleting worker: $e")));
    }
  }
}