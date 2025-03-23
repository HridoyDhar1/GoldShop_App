import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FinancialController extends GetxController {
  var addMoney = 0.0.obs;
  var totalSell = 0.0.obs;
  var totalMortgage = 0.0.obs;
  var otherCost = 0.0.obs;
  var totalBuy = 0.0.obs;
  var sendMoney = 0.0.obs;
  var mortgagePay = 0.0.obs;
  var finalMoney = 0.0.obs;

  @override
  void onInit() {
    fetchFinancialData();
    super.onInit();
  }

  void calculateFinalMoney() {
    finalMoney.value = (addMoney.value + totalSell.value) -
        (totalBuy.value + sendMoney.value + otherCost.value + totalMortgage.value );
  }

  void fetchFinancialData() {
    FirebaseFirestore.instance.collection("NewSell").snapshots().listen((snapshot) {
      totalSell.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()["pay"] as num? ?? 0.0));
      calculateFinalMoney();
    });

    FirebaseFirestore.instance.collection("AddProduct").snapshots().listen((snapshot) {
      addMoney.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()["money"] as num? ?? 0.0));
      calculateFinalMoney();
    });

    FirebaseFirestore.instance.collection("NewBuy").snapshots().listen((snapshot) {
      totalBuy.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()["pay"] as num? ?? 0.0));
      calculateFinalMoney();
    });

    FirebaseFirestore.instance.collection("NewMortgage").snapshots().listen((snapshot) {
      totalMortgage.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()["pay"] as num? ?? 0.0));
      calculateFinalMoney();
    });

    FirebaseFirestore.instance.collection("NewPay").snapshots().listen((snapshot) {
      sendMoney.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()["money"] as num? ?? 0.0));
      calculateFinalMoney();
    });

    FirebaseFirestore.instance.collection('OtherCost').snapshots().listen((snapshot) {
      otherCost.value = snapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()['money'] as num? ?? 0.0));
      calculateFinalMoney();
    });
  }
}
