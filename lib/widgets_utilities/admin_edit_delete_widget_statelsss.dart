import 'package:flutter/material.dart';



// class EditDeleteStalessWidget extends StatelessWidget {
//
//   const EditDeleteStalessWidget({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children:[
//
//           Container(
//             height: 150,
//             child: Material(
//               color: Colors.white,
//               elevation: 14.0,
//               borderRadius: BorderRadius.circular(10.0),
//               shadowColor: Colors.amber,
//
//               child: Row(
//
//                 children: [
//
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                         height: 150,
//                         width: MediaQuery.of(context).size.width*0.70,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//
//                           children: [
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Categoria : ',style:
//                                 TextStyle(fontStyle: FontStyle.italic,
//                                     color: Colors.black ,fontSize: 14),),
//
//                                 Text(selectedProduct['categoria']==null? 'No espficada':selectedProduct['categoria']['nombre_categoria'] ,style:
//                                 TextStyle(fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue,fontSize: 20),),
//                               ],
//                             ),
//
//
//
//
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('NOMBRE : ',style:
//                                 TextStyle(fontStyle: FontStyle.italic,
//                                     color: Colors.black ,fontSize: 14),),
//                                 Text(selectedProduct['nombre_producto']==null?'No espificado':selectedProduct['nombre_producto'],style:
//                                 TextStyle(fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue,fontSize: 20),),
//                               ],
//                             ),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('PRECIO : ',style:
//                                 TextStyle(fontStyle: FontStyle.italic,
//                                     color: Colors.black ,fontSize: 14),),
//
//                                 Text(  selectedProduct['precio_ahora']==null?'No espificada':'${selectedProduct['precio_ahora'] }\$ ',style:
//                                 TextStyle(fontWeight: FontWeight.bold,
//                                     color: Colors.green,fontSize: 22),),
//                               ],
//                             ),
//
//
//                             selectedProduct['precio_anterior'] ==0? Text('') :
//                             Row(
//
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//
//                               children: [
//                                 Text('PRECIO ANTERIOR : ',style:
//                                 TextStyle(fontStyle: FontStyle.italic,
//                                     color: Colors.black ,fontSize: 14),),
//                                 RichText(
//                                   text: TextSpan(
//                                     text:'${selectedProduct['precio_anterior']} \$',
//                                     style: new TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.red,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//
//
//                             selectedProduct['porciento_de_descuento']==null? Text(''): Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('DESCUENTO : ',style:
//                                 TextStyle(fontStyle: FontStyle.italic,
//                                     color: Colors.black ,fontSize: 14),),
//
//                                 Text (  '${ selectedProduct['porciento_de_descuento'] } % '  ,style:
//                                 TextStyle(fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue,fontSize: 20),),
//
//
//                               ],
//
//                             ),
//
//
//
//
//
//
//                           ],)
//
//                     ),
//                   ),
//
//
//
//                   Container(
//                     height: 100,
//                     width: MediaQuery.of(context).size.width*0.20,
//                     child:  selectedProduct['foto_producto'] ==null ?
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE,fit: BoxFit.fill)):
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.network('http://192.168.1.22/api_v_1/storage/app/public/notes/${selectedProduct['foto_producto']}',
//                           fit: BoxFit.fill),
//                     ),
//
//                   ),
//
//
//
//                 ],),
//
//
//             ),
//           ),
//           // SizedBox(height: 10,),
//
//           Container(
//             height: 60,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//
//                 //
//                 //  // IconButton(onPressed: (){
//                 //     Navigator.of(context).pushNamed(
//                 //        AdminEditProduct.id, arguments: [data,data2]
//                 // //     );},
//                 //
//
//
//
//                 IconButton(onPressed: ()
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context)=>AdminEditProduct(selectedproduct:selectedProduct==null?[]:selectedProduct,
//                       categoryList: categoryList==null?[]:categoryList ,),),
//                   );
//                 },
//
//
//
//
//
//                     icon: Icon(Icons.edit,size: 40.0,color: Colors.green,)),
//                 SizedBox(width:40.0,),
//                 IconButton(onPressed: (){
//
//                   showWarning(context , selectedProduct);
//
//                 },
//
//                     icon: Icon(Icons.delete_forever,size: 40.0,color: Colors.red,)),
//               ],
//             ),
//           ),
//
//         ]
//     )
//   }
// }
