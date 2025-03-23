// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/mortgage_model.dart';
//
// class MortgageRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Stream<List<MortgageModel>> getMortgageList() {
//     return _firestore.collection("NewMortgage").snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => MortgageModel.fromMap(doc.id, doc.data())).toList();
//     });
//   }
//
//   Future<List<MortgageModel>> searchMortgages(String query) async {
//     QuerySnapshot snapshot = await _firestore
//         .collection("NewMortgage")
//         .where("customerName", isGreaterThanOrEqualTo: query)
//         .where("customerName", isLessThanOrEqualTo: query + '\uf8ff')
//         .get();
//
//     return snapshot.docs.map((doc) => MortgageModel.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
//   }
//
//   Future<void> deleteMortgage(String docId) async {
//     await _firestore.collection('NewMortgage').doc(docId).delete();
//   }
// }
