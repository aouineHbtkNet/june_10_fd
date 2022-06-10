// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
// import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
// import 'package:simo_v_7_0_1/modals/product_model.dart';
// import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
// import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
//
// class OrderWidgetSearchForAdmin extends StatefulWidget {
//   int index;
//   List<OrderModel> orderList;
//   BuildContext context;
//   OrderWidgetSearchForAdmin({Key? key ,
//     required this.index,
//     required this.context,
//     required this.orderList}) : super(key: key);
//
//   @override
//   State<OrderWidgetSearchForAdmin> createState() => _OrderWidgetSearchForAdminState();
// }
//
//
//
// class _OrderWidgetSearchForAdminState extends State<OrderWidgetSearchForAdmin> {
//   @override
//   Widget build(BuildContext context) {
//
//     return   Container(
//       height: MediaQuery.of(context).size.height*0.2,
//       child: Card(
//         elevation: 20,
//         child: Center(
//           child: InkWell(
//             onTap: (){Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:widget.orderList[widget.index]);},
//             child: Row(
//               children: [
//
//
//
//
//
//
//
//
//
//
//
//
//                     ],),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//   void showstuff(context, var myString) {
//     showDialog(context: context, builder: (context) {return AlertDialog(
//       content: myString==''? ClipRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),) :
//       ClipRect(child: Image.network('https://hbtknet.com/storage/notes/$myString'),),
//       actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('Ok')))],);});}
//
// }
//
