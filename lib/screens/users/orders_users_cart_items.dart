import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/admins/get_orders_list_of_products.dart';
import 'package:simo_v_7_0_1/modals/items_in_cart_for_admin.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/cart_response_list.dart';



class OrderDetailsForUsers extends StatefulWidget {
  static const String id = '/OrderDetailsForUsers';
  OrderModel orderModel;
  OrderDetailsForUsers({required this.orderModel});

  @override
  State<OrderDetailsForUsers> createState() => _OrderDetailsForUsersState();}
class _OrderDetailsForUsersState extends State<OrderDetailsForUsers> {

  Widget showOrderAttrbutes({ String? title, String? data}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [Text(title ??'',style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
          SizedBox(width: 4.0,),
          Text(' : ${data ??''}',style: TextStyle(fontSize: 20),),

        ],),
      ),
    );}

  bool isLoading =false;
  OrderModel orderModel = OrderModel();

  CartResponse cartResponse =CartResponse();

  @override
  void initState() {
    setState(() {isLoading=true;});
    orderModel = widget.orderModel;
    GetOrderListOfProducts().getOrderItemsUsers(widget.orderModel.id).then((value) {
      setState(() {cartResponse= value;isLoading=false;});
    });

    print('orderModel id   ===============>${orderModel.id}');
    super.initState();
  }

  //SpinKitWave(color: Colors.green, size: 50.0,):
  @override
  Widget build(BuildContext context) {

    print('signature -------------------orders_users_carts');




    return Scaffold(
        body: SafeArea(
          child: Column(


            children: [
              Row(children: [IconButton(onPressed: () async {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.green,),),],),
              Divider(thickness: 2,),


              showOrderAttrbutes(title: 'Num del pedido', data:'${orderModel.id}'),
              showOrderAttrbutes(title: 'Total a pagar ', data:'${orderModel.grand_delivery_fees_in}\$'),

              orderModel.delivery_fee=='0.000'? SizedBox(height: 0,width: 0,) :

              showOrderAttrbutes(title: 'Costo de envio', data:'${orderModel.delivery_fee}\$'),
              orderModel.delivery_fee=='0.000'? SizedBox(height: 0,width: 0,) :
              showOrderAttrbutes(title: ' sub Total', data:'${orderModel.grand_total}\$'),











              SizedBox(height: 20,),
              isLoading==true? SpinKitWave(color: Colors.blueGrey, size: 50.0,):
              Expanded(
                child: ListView.builder(
                    itemCount:cartResponse.listOfCartItemsInfo.length ,
                    itemBuilder:(context,index){
                      int indexPlusOne =index+1;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [

                            Expanded(
                              child: Card(

                                child: Column(children: [
                                  Text('    ${indexPlusOne} / ${cartResponse.listOfCartItemsInfo.length}  ', style: TextStyle(fontSize: 20),),
                                  Container(height: 200,
                                    decoration: BoxDecoration(image: DecorationImage(
                                      image: NetworkImage( 'https://hbtknet.com/storage/notes/${cartResponse.listOfCartItemsInfo[index].product?.foto_producto}'),
                                      fit: BoxFit.cover,)
                                      ,),
                                  ),

                                  showOrderAttrbutes(title: 'Nombre', data:'${cartResponse.listOfCartItemsInfo[index].product?.nombre_producto}'),
                                  showOrderAttrbutes(title: 'Cantidad', data:'${cartResponse.listOfCartItemsInfo[index].qty}'),
                                  showOrderAttrbutes(title: 'Marca', data:'${cartResponse.listOfCartItemsInfo[index].product?.marca}'),
                                  showOrderAttrbutes(title: 'Precio', data:'${cartResponse.listOfCartItemsInfo[index].product?.precio_ahora}\$'),
                                ],),),
                              ),
                          ],


                        ),
                      );} ),

              )


            ],),
        ));
  }
}



//
// SingleChildScrollView(scrollDirection: Axis.horizontal, child:
// Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
// Padding(padding: const EdgeInsets.only(top: 4),
// child: Text('    ${indexPlusOne} / ${cartResponse.listOfCartItemsInfo.length}  ', style: TextStyle(fontSize: 20),),),
// showOrderAttrbutes(title: 'Cantidad', data:'${cartResponse.listOfCartItemsInfo[index].qty}'),
//
// ],),),
//
//Padding(padding: const EdgeInsets.all(14.0),
// child:  cartResponse.listOfCartItemsInfo[index].product?.foto_producto==null?
// Container(
// decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)),
// color: Colors.greenAccent), child: Padding(padding: const EdgeInsets.all(8.0),
// child: Text('No  hay foto',style: TextStyle(fontSize: 16),),)):
// Container(height:200, decoration: BoxDecoration(image: DecorationImage(
// image: NetworkImage( 'https://hbtknet.com/storage/notes/${cartResponse.listOfCartItemsInfo[index].product?.foto_producto}'),
// fit: BoxFit.cover,),),),),

// SingleChildScrollView(scrollDirection: Axis.horizontal, child:
// Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
// showOrderAttrbutes(title: 'Nombre', data:'${cartResponse.listOfCartItemsInfo[index].product?.nombre_producto}'),
// showOrderAttrbutes(title: 'Marca', data:'${cartResponse.listOfCartItemsInfo[index].product?.marca}'),
//
// ],),),
//
// SingleChildScrollView(scrollDirection: Axis.horizontal, child:
// Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
// showOrderAttrbutes(title: 'Precio', data:'${cartResponse.listOfCartItemsInfo[index].product?.precio_ahora}'),
// showOrderAttrbutes(title: 'Contenido', data:'${cartResponse.listOfCartItemsInfo[index].product?.contenido}'),
// ],),),
// cartResponse.listOfCartItemsInfo[index].product?.porciento_de_descuento==null?SizedBox(height: 0.0,):
// showOrderAttrbutes(title: 'Decuento', data:'${cartResponse.listOfCartItemsInfo[index].product?.porciento_de_descuento} \%'),
// showOrderAttrbutes(title: 'Descripción', data:'${cartResponse.listOfCartItemsInfo[index].product?.descripcion}'),
// Divider(thickness: 4,)
