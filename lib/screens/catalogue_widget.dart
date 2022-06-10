
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';

class catalogue extends StatefulWidget {
   int index;
  List<ProductPaginated> product;
  BuildContext context;
   catalogue({Key? key ,
     required this.index,
     required this.context,
     required this.product}) : super(key: key);

  @override
  State<catalogue> createState() => _catalogueState();
}



class _catalogueState extends State<catalogue> {
  @override
  Widget build(BuildContext context) {

     return   Container(
       height: MediaQuery.of(context).size.height*0.2,
       child: Card(
         elevation: 20,
         child: Center(
           child: InkWell(
             onTap: (){Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:widget.product[widget.index]);},
             child: Row(
               children: [


                 Container(
                   width: MediaQuery.of(context).size.width*0.5,
                   child: (
                       widget.product[widget.index].foto_producto==null?
                       Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE,
                         fit: BoxFit.fill,)
                           :Image.network(
                         'https://hbtknet.com/storage/notes/${ widget.product[widget.index].foto_producto}',
                         fit: BoxFit.fill,
                       )),
                 ),


                 Container(

                   margin: EdgeInsets.only(left: 10),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [


                          widget.product[widget.index].porciento_de_descuento==null ||
                           widget.product[widget.index].porciento_de_descuento! <= 0
                           ?            SizedBox(height: 0,):
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Row(
                           children: [
                             Text(' ${widget.product[widget.index].porciento_de_descuento?.round()} \% ',
                               style: TextStyle(fontSize: 20,color: Colors.green ,),),
                             Text(' de desct.',style: TextStyle(fontSize: 20,color: Colors.green),),
                           ],
                         ),
                       ),







                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Row(
                           children: [
                             Text(
                               '${widget.product[widget.index].nombre_producto}',
                               style: TextStyle(fontSize: 18,color:Colors.black,),),
                           ],
                         ),
                       ),
                       SizedBox(height: 4,),
                       Padding(
                         padding: const EdgeInsets.all(2.0),
                         child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: Text('${ widget.product[widget.index].precio_ahora}\$',
                             style: TextStyle(
                               fontSize: 24,color:Colors.black,

                             ),
                           ),
                         ),
                       ),

                     ],),
                 ),












               ],
             ),
           ),
         ),
       ),
     );

  }
  void showstuff(context, var myString) {
    showDialog(context: context, builder: (context) {return AlertDialog(
      content: myString==''? ClipRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),) :
      ClipRect(child: Image.network('https://hbtknet.com/storage/notes/$myString'),),
      actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('Ok')))],);});}

}


// onTap: () {
//   Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:widget.product[widget.index]);},



// GestureDetector(
//   onTap: (){
//      showstuff(context,'${ widget.product[widget.index].foto_producto}' );
//
//   },
//   child: Container(
//
//      child:  widget.product[widget.index].foto_producto == null ?
//      CircleAvatar(
//    backgroundImage: AssetImage(Constants.ASSET_PLACE_HOLDER_IMAGE),
//     backgroundColor: Colors.transparent, radius: 30.0,)
//      :
//
//    Image.network(
//   'https://hbtknet.com/storage/notes/${ widget.product[widget.index].foto_producto}',fit: BoxFit.cover,),
// ),
// ),
//
// GestureDetector(
//   onTap: (){
//     Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:widget.product[widget.index]);
//
//
//  },
//   child: Container(
//     width: double.infinity,
//     color: Colors.blueGrey,
//     child: Column(
//
//     children: [
//       Text('${ widget.product[widget.index].nombre_producto}', style: TextStyle(
//           color: Colors.green, fontSize: 20),),
//
//       Text('${ widget.product[widget.index].precio_ahora}\$',
//         style: TextStyle(color: Colors.green, fontSize: 20),)
//     ],
//     ),
//   ),
// ),
















//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
// import 'package:simo_v_7_0_1/modals/product_model.dart';
// import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
//
// class catalogue extends StatefulWidget {
//   int index;
//   List<Product> product;
//   BuildContext context;
//   catalogue({Key? key ,
//     required this.index,
//     required this.context,
//     required this.product}) : super(key: key);
//
//   @override
//   State<catalogue> createState() => _catalogueState();
// }
//
// class Prodcut {}
//
// class _catalogueState extends State<catalogue> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//
//       elevation: 20,
//       child: ListTile(
//         onTap: () {
//           Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:widget.product[widget.index]);},
//
//         leading: TextButton(
//
//
//           onPressed: () { showstuff(context, widget.product[widget.index].foto_producto); },
//
//
//           child: Container(
//               child:  widget.product[widget.index].foto_producto == null ? CircleAvatar(
//                 backgroundImage: AssetImage(Constants.ASSET_PLACE_HOLDER_IMAGE),
//                 backgroundColor: Colors.transparent, radius: 30.0,)
//                   : CircleAvatar(radius: 30.0,
//                 backgroundImage: NetworkImage(
//                     'https://hbtknet.com/storage/notes/${ widget.product[widget.index].foto_producto}'),
//                 backgroundColor: Colors.transparent,)),),
//         title: Column(
//           children:
//           [Text('${ widget.product[widget.index].nombre_producto}', style: TextStyle(
//               color: Colors.green, fontSize: 20),),
//             Text('${ widget.product[widget.index].precio_ahora}\$',
//               style: TextStyle(color: Colors.green, fontSize: 20),),
//             widget.product[widget.index].porciento_de_descuento == null
//                 ? Text('') : Text(
//               '${widget.product[widget.index].porciento_de_descuento}\%', style: TextStyle(color: Colors.green, fontSize: 20),),
//
//           ],
//         ),
//
//         trailing: Icon(Icons.more_horiz),
//       ),
//     );
//   }
//   void showstuff(context, var myString) {
//     showDialog(context: context, builder: (context) {return AlertDialog(
//       content: myString == null ? ClipRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),) : ClipRect(child: Image.network('https://hbtknet.com/storage/notes/$myString'),),
//       actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('Ok')))],);});}
//
// }
//
//





//
//
//
//
// class catalogue extends StatefulWidget {
//   const ({Key? key}) : super(key: key);
//
//   @override
//   State<> createState() => _State();
// }
//
// class _State extends State<> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//
//     elevation: 20,
//     child: ListTile(
//     onTap: () {
//     Navigator.of(context).pushNamed(SelectedProductDetails.id, arguments:  productList[index]);},
//
//     leading: TextButton(



//     onPressed: () {showstuff(context,  productList[index].foto_producto);},







//     child: Container(
//     child:  productList[index].foto_producto == null ? CircleAvatar(
//     backgroundImage: AssetImage(Constants.ASSET_PLACE_HOLDER_IMAGE),
//     backgroundColor: Colors.transparent, radius: 30.0,)
//         : CircleAvatar(radius: 30.0,
//     backgroundImage: NetworkImage(
//     'https://hbtknet.com/storage/notes/${ productList[index].foto_producto}'),
// backgroundColor: Colors.transparent,)),),
// title: Column(
// children:
// [Text('${ productList[index].nombre_producto}', style: TextStyle(
// color: Colors.green, fontSize: 20),),
// Text('${ productList[index].precio_ahora}\$',
// style: TextStyle(color: Colors.green, fontSize: 20),),
// productList[index].porciento_de_descuento == null
// ? Text('') : Text(
// '${ productList[index].porciento_de_descuento}\%', style: TextStyle(color: Colors.green, fontSize: 20),),
//
// ],
// ),
//
// trailing: Icon(Icons.more_horiz),
// ),
// );}
//
// }
// }
