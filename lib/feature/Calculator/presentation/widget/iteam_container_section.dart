// import 'package:flutter/material.dart';
//
//
//
// class IteamContainerSection extends StatefulWidget {
//   const IteamContainerSection({
//     super.key,
//     required this.voriPrice,
//     required this.vori,
//     required this.totalVoriPrice,
//     required this.controller
//   });
//   var totalAnaPrice;
// var ana;
//   double? perAnaPrice;
//
//   double? perRothiPrice;
//
//   double? perPointPrice;
//   var totalRothiPrice;
//
//   var totalPointPrice;
//   final dynamic voriPrice;
//   final dynamic vori;
//   final int totalVoriPrice;
// final TextEditingController controller;
//   @override
//   State<IteamContainerSection> createState() => _IteamContainerSectionState();
// }
//
// class _IteamContainerSectionState extends State<IteamContainerSection> {
//
//
//   var mujuri;
//
//   var ana;
//
//   var rothi;
//
//   var point;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final _perVoriController = TextEditingController();
//     final _mujuriController = TextEditingController();
//     final _voriController = TextEditingController();
//     final _anaController = TextEditingController();
//     final _rothiController = TextEditingController();
//     final _pointController = TextEditingController();
//     return
//       Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               "Vori",
//               style: TextStyle(fontSize: 20, color: Colors.black87),
//             ),
//             const SizedBox(width: 30),
//             Flexible(
//               child:  Container(
//                 width: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               )
//             ),
//             const SizedBox(width: 20),
//             Text("${widget.voriPrice} X ${widget.vori} = ${widget.totalVoriPrice} Taka",style: TextStyle(fontSize: 15),)
//           ],
//         ),   const SizedBox(height: 20,),
//         Row(
//           children: [
//             Text(
//               "Ana",
//               style: TextStyle(fontSize: 20, color: Colors.black87),
//             ),
//             const SizedBox(width: 30),
//             Flexible(
//               child:  Container(
//                 width: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
// controller: ,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               )
//             ),
//             const SizedBox(width: 20),
//             Text("$perAnaPrice X $ana = $totalAnaPrice Taka",style: TextStyle(fontSize: 15),)
//           ],
//         ),   const SizedBox(height: 20,),
//         Row(
//           children: [
//             Text(
//               "Rothi",
//               style: TextStyle(fontSize: 20, color: Colors.black87),
//             ),
//             const SizedBox(width: 20),
//             Flexible(
//               child:  Container(
//                 width: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               )
//             ),
//             const SizedBox(width: 20),
//             Text("$perRothiPrice X $rothi = $totalRothiPrice Taka",style: TextStyle(fontSize: 15),)
//           ],
//         ),
//         const SizedBox(height: 20,),
//         Row(
//           children: [
//             Text(
//               "Point",
//               style: TextStyle(fontSize: 20, color: Colors.black87),
//             ),
//             const SizedBox(width: 20),
//             Flexible(
//               child:  Container(
//                 width: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               )
//             ),
//             const SizedBox(width: 20),
//             Text("$perPointPrice X $point = $totalPointPrice Taka",style: TextStyle(fontSize: 15),)
//           ],
//         ),
//       ],
//     );
//   }
// }
//
