// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:viral/models/plans.dart';
// import 'package:viral/widget/colors.dart';
// import 'package:viral/widget/provider.dart';
// import 'package:viral/widget/title.dart';

// class Plans extends StatefulWidget {
//   final Plan plan;

//   Plans({Key key, this.plan}) : super(key: key);

//   @override
//   _PlansState createState() => _PlansState();
// }

// class _PlansState extends State<Plans> {
//   Stream<QuerySnapshot> getPlansStreamSnapshots(BuildContext context) async* {

//     final uid = await Provider.of(context).auth.getCurrentUID();
//     yield* Firestore.instance.collection('plans').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: <Widget>[
//             Container(
//               height: MediaQuery.of(context).size.height * 0.8,
//               child: StreamBuilder(
//                   stream: getPlansStreamSnapshots(context),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData)
//                       return Column(
//                         children: <Widget>[
//                           SizedBox(height: 300),
//                           SpinKitChasingDots(
//                             color: Theme.of(context).primaryColor,
//                             size: 50,
//                             duration: Duration(seconds: 5),
//                           ),
//                           SizedBox(height: 20),
//                           Text("Loading...")
//                         ],
//                       );
//                     return new ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemCount: snapshot.data.documents.length,
//                       itemBuilder: (BuildContext context, int index) =>
//                           buildPlanCard(
//                         context,
//                         snapshot.data.documents[index],
//                       ),
//                     );
//                   }),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.2)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildPlanCard(BuildContext context, DocumentSnapshot document) {

//     TextEditingController _nameController = TextEditingController();

//     _nameController.text = document['name'];
//     String _name = document['name'];

//     var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());
//     final height = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       child: Container(
//         height: 80,
//         decoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
//         child: InkWell(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                         text: 'Reach ' + document['reach'] + 'K People', size: 20),
//                     SizedBox(height: 5),
//                     Row(
//                       children: <Widget>[
//                         Icon(
//                           Icons.monetization_on,
//                           size: 15,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         SizedBox(width: 5),
//                         CustomText(
//                           text:
//                               '\N${(document['price'] == null) ? '' : document['price'].toString()}',
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 5),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {
// //            Navigator.push(
// //              context,
// //              MaterialPageRoute(
// //                builder: (context) => PlanReadPage(
// //                  plan: plans,
// //                ),
// //              ),
// //            );
//           },
//         ),
//       ),
//     );
//   }
// }
