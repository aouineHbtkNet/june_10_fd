import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/get_order_details.dart';
import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
import 'package:simo_v_7_0_1/modals/order_detail_model.dart';
import 'package:simo_v_7_0_1/providers/provider_two.dart';
import 'package:simo_v_7_0_1/providers/shared_preferences_provider.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/pagar_ahora_enLinea.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/image_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/splash_screen_simple.dart';
import 'package:simo_v_7_0_1/widgets_utilities/statefulWidget_textFormField.dart';

import 'cart_screen.dart';


class UserOrdersDetailsScreen extends StatefulWidget {
  static const String id = '/userorderDetailsScreen';
  var selectedOrder;
  UserOrdersDetailsScreen({required this.selectedOrder});
  @override
  State<UserOrdersDetailsScreen> createState() => _UserOrdersDetailsScreenState();}
  class _UserOrdersDetailsScreenState extends State<UserOrdersDetailsScreen> {


  List  list=[];
  @override
  void initState() {
     int myid =widget.selectedOrder['id'];
    GetOrdersDetails().getOrderDetails(myid).then((value){
     setState(() {
       list=value;
       print(' list =====================$list');
     });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context)  {


    return   Scaffold(
          body: SafeArea(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: () async {
                        Navigator.of(context).pop();
                      },
                        icon: Icon(Icons.arrow_back ,),
                      ),
                    ],
                  ),
                ),

               list.isEmpty? SpinKitWave(color: Colors.green, size: 50.0,):
               Expanded(
                  child: ListView.builder(
                      itemCount:list.length,
                      itemBuilder: (BuildContext context,int index){
                      var  foto=list[index]['product']['foto_producto'];
                     var  name=list[index]['product']['nombre_producto'];
                      var  marca=list[index]['product']['marca'];
                      var content=list[index]['product']['contenido'];
                        var   price=list[index]['product']['precio_ahora'];
                        var  quantity=list[index]['qty'];
                        var   description=list[index]['product']['descripcion'];


                         print(' product ========================${foto}');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              elevation: 10,
                              color: Colors.white70,
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                children: [

                                  Text('${index+1}/${ list.length}',
                                    style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),

                                  Divider(thickness: 2,color: Colors.blueGrey,),

                                  SizedBox(height: 10,),

                                  Padding(padding: const EdgeInsets.all(14.0),
                                    child:  foto==null?Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          color: Colors.greenAccent
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('No  hay foto',style: TextStyle(fontSize: 16),),
                                        )):




                                    Container(
                                      height:200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(

                                          image: NetworkImage( 'https://hbtknet.com/storage/notes/$foto'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10,),




                                  name==null?Text(''):
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal, child: Row( children: [
                                    Text('Nombre: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                    Text('$name',style: TextStyle(fontSize: 24),),],),
                                  ),
                                  SizedBox(height: 10,),


                                  marca==null?Text(''):
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal, child: Row( children: [
                                    Text('Marca: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                    Text('$marca',style: TextStyle(fontSize: 24),),],),
                                  ),
                                  SizedBox(height: 10,),


                                  content==null?Text(''):
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal, child: Row( children: [
                                    Text('Contenido: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                    Text('$content',style: TextStyle(fontSize: 24),),],),
                                  ),
                                  SizedBox(height: 10,),


                                  price==null?Text(''):
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal, child: Row( children: [
                                    Text('Precio: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                    Text('$price\$',style: TextStyle(fontSize: 24),),],),
                                  ),
                                  SizedBox(height: 10,),

                                  quantity==null?Text(''):
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal, child: Row( children: [
                                    Text('Cantidad: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                    Text('$quantity',style: TextStyle(fontSize: 24),),],),
                                  ),
                                  SizedBox(height: 10,),

                                  description==null?Text(''):
                                  Text('Descripcion: ',style: TextStyle(fontSize: 18,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text('$description',style: TextStyle(fontSize: 24),),
                                  SizedBox(height: 10,),







                            ],),
                              )),
                        );



                      }),
                ),
              ],
            ),




      //        child: Column(children: [
      //
      //                PopUpMenuWidget(putArrow: true, callbackArrow: (){Navigator.of(context).pushNamedAndRemoveUntil(UserOrdersScreen.id,
      //             (Route<dynamic> route) => false);}, voidCallbackCart: (){Navigator.of(context).pushNamedAndRemoveUntil(UserCart.id,
      //             (Route<dynamic> route) => false);},),
      //
      //       Padding(
      //      padding: const EdgeInsets.all(6.0),
      //        child: UsedWidgets().orderDetailsScreenHeading(
      //
      //     sizeTitle:18 ,
      //     sizeData: 30,
      //     fontfamilyTitle:'Opendark',
      //     fontFamilyData:'Dancing' ,
      //     dateData:'${widget.selectedOrder['created_at']}',
      //     orderIdData: '${widget.selectedOrder['id']}',
      //     serialNumberdata:'${widget.selectedOrder['trucking_number']}',
      //     totalPriceData:'${widget.selectedOrder['grand_total']}',
      //     totalPriceBaseData: '${widget.selectedOrder['grand_total_base']}',
      //     totalPriceTaxesData:'${widget.selectedOrder['grand_total_taxes']}',
      //     totalPriceDescountData: '${widget.selectedOrder['grand_total_discount']}',
      //     // totalDelosProductos:  '${selectedProduct['id']}'
      //   ),
      // ),













         //  ],
       //   ),
    )





     );
  }
}
















// SafeArea(
//
//   child: Column(
//
//     children: [
//
//       PopUpMenuWidget(putArrow: true,
//         callbackArrow: (){
//           Navigator.of(context).pushNamedAndRemoveUntil(UserOrdersScreen.id,
//                   (Route<dynamic> route) => false);},
//         voidCallbackCart: (){
//           Navigator.of(context).pushNamedAndRemoveUntil(UserCart.id,
//                   (Route<dynamic> route) => false);
//         },),
//
//       Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: UsedWidgets().orderDetailsScreenHeading(
//
//           sizeTitle:18 ,
//           sizeData: 30,
//           fontfamilyTitle:'Opendark',
//           fontFamilyData:'Dancing' ,
//           dateData:'${selectedProduct['created_at']}',
//           orderIdData: '${selectedProduct['id']}',
//           serialNumberdata:'${selectedProduct['trucking_number']}',
//           totalPriceData:'${selectedProduct['grand_total']}',
//           totalPriceBaseData: '${selectedProduct['grand_total_base']}',
//           totalPriceTaxesData:'${selectedProduct['grand_total_taxes']}',
//           totalPriceDescountData: '${selectedProduct['grand_total_discount']}',
//           // totalDelosProductos:  '${selectedProduct['id']}'
//         ),
//       ),
//
//
//       Container(
//         decoration: BoxDecoration(
//
//             border: Border.all(color: Colors.blueGrey,width: 2),
//             borderRadius: BorderRadius.circular(4.0)
//         ),
//
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('La lista de los productos :',style: TextStyle(fontSize: 20),),
//         ),
//       ),
//
//
//
//       Expanded(
//
//         child: Container(
//          // color: Colors.amberAccent,
//           child: FutureBuilder(
//             future:GetOrdersDetails().getOrderDetails(order_id ) ,
//             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//
//               return  snapshot.hasData?ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Card(
//                 // color: Colors.greenAccent,
//                     child: Column(children: [

//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                          Text('Numero : ',style: TextStyle(fontSize: 18 ,fontFamily: 'Arkaya',color: Colors.blueGrey),),
//                          Text('${ index+1}',style: TextStyle(fontSize: 24,fontFamily: 'OpenLight'),),
//
//                        ],),
//                      ),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Divider(color: Colors.blue,thickness: 2,),
//                       ),
//
//
//
//                       ImagewidgetNoButton(
//                       networkImageUrl:snapshot.data[index].getProducts.fotoProducto,
//                     ),
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Nombre : ',
//                           data:' ${snapshot.data[index].getProducts.nombreProducto}'),
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Contenido : ',
//                           data:' ${snapshot.data[index].getProducts.contenido}'),
//
//
//
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Precio unitario : ',
//                           data:' ${snapshot.data[index].getProducts.precioAhora}'),
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Precio Base unitario : ',
//                           data:' ${snapshot.data[index].getProducts.precioSinImpuesto}'),
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Precio antes unitario  : ',
//                           data:' ${snapshot.data[index].getProducts.precioAnterior}'),
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Porciento de desuento unitario : ',
//                           data:' ${snapshot.data[index].getProducts.porcientoDeDescuento}'),
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: ' Valor de descuento  unitario : ',
//                           data:' ${snapshot.data[index].getProducts.valorDescuento}'),
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: ' cantidad : ',
//                           data:' ${snapshot.data[index].qty}'),
//
//
//
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'valor total  del precio  : ',
//                           data:' ${snapshot.data[index].productTotalPrice}'),
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'valor total  del precio base: ',
//                           data:' ${snapshot.data[index].productTotalBase}'),
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Valor total de los impuestos: ',
//                           data:' ${snapshot.data[index].productTotalTaxes}'),
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Valor total de los discuentos: ',
//                           data:' ${snapshot.data[index].productTotalDiscount}'),
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
//
//                       UsedWidgets().simpleTitleDataWidget(
//                           title: 'Descripcion : ',
//                           data:' ${snapshot.data[index].getProducts.descripcion}'),
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
//                   ],) ,),
//                 );
//
//
//
//
//
//               },);
//
//
//             },
//           ),
//         ),
//       ),
//     ],
//   ),
// )
