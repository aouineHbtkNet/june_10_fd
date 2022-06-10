import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/apis/payement_preference.dart';
import 'package:simo_v_7_0_1/apis/placeOrder.dart';
import 'package:simo_v_7_0_1/modals/mercadoPago_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/order_fill_in_form.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/screens/webpage_mercadopago.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:simo_v_7_0_1/widgets_utilities/spalsh_screen_widget.dart';

import 'cart_screen.dart';

class ChannelPage extends StatefulWidget {
  static const String id = '/ChannelPage';
  MercadoPagoModelPlaceOrder mercadoPagoModel ;
  ChannelPage({required this. mercadoPagoModel});

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {


  void showstuff(context, String  myString) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
               child: Column(
            children: [
              SizedBox(height: 10,),
              Divider(thickness: 2,color: Colors.blue,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(myString,style: TextStyle(fontSize: 18),),
              ),
              Divider(thickness: 2,color: Colors.blue,),
              SizedBox(height: 10,),
            ],
          ),
        ), actions: [
        ElevatedButton(onPressed: () async {
          Navigator.of(context).pop();},
            child: Center(child: Text('Ok'))),
      ],);});}


  static final channelForListenResponseName= 'mercadoPagoResponse';
  final methodChannelresponse= MethodChannel(channelForListenResponseName);
  static final channelForPayementName = 'channelForPayement';
  final methodChannelPayement = MethodChannel(channelForPayementName);
  bool isLoading =false;
  String responseFromandoridstring= 'Listening....';


  var payementID ='';
  var payementStatus ='';
  var payementStatusDetails ='';
  var payementError ='';

  UserModel? userModel;



  @override
  void initState() {

    GetUserOrAdminInfo().getUserInfo().then((value) {setState(() {userModel = value;});});
    methodChannelresponse.setMethodCallHandler((MethodCall call)async{
     switch(call.method){
      case'kol':
        payementID=call.arguments[0];
        payementStatus=call.arguments[1];
        payementStatusDetails=call.arguments[2];
       return mercadopgoOk(payementID , payementStatus,payementStatusDetails);
     case'paymenterror':
       payementError=call.arguments[0];
       return mercadoPagoError(payementError);
   }});
    super.initState();}

  void  mercadopgoOk(idPago,satatus,statusdetails){PyamentApprovedMethod();}

  void  mercadoPagoError(error){
    setState(() {isLoading=false;});
    showstuff(context, 'El proceso de pago ha sido cancelado.Puede volver a intentarlo \n o puede elegir otras formas de pago.');
    print ('payement error  ==============${error}');setState(() {payementError;});

  }

void PyamentApprovedMethod() async{
  print ('===============payement status  ==============${payementStatus}');
  // setState(() { isLoading=false;payementID ;payementStatus ;payementStatusDetails ;});
  setState(() { isLoading=false;});

   // if (payementStatus=='approved'&&payementStatusDetails=='accredited'&&payementID.length!=null){
   if (payementID.isNotEmpty&&payementStatus=='approved'&&payementStatusDetails=='accredited' ){


    print ('*********************************** the payement is successfull *************************************************');
    print ('*******payemnt status :::::::::::${payementStatus} *************************************************');
    print ('*******payemnt id  :::::::::::${payementID} *************************************************');
    print ('*******payemnt details  :::::::::::${payementStatusDetails} *************************************************');


    await  PlaceOrder().placeOrder(
        cartModeList: widget.mercadoPagoModel.listOfCartModel,
        status: widget.mercadoPagoModel.valueSataus,
        manera_entrega: widget.mercadoPagoModel.manera_entrega,


        manera_pago: 'En la linea',
        // manera_pago: 'En la linea,Apropado, ${payementID}',
        manera_pago_details: 'Apropado, ${payementID}',
      //  delivery_fee: 0,
      //  grand_delivery_fees_in:0,
        grand_total:widget.mercadoPagoModel.grandTotalVar,
        grand_total_base: widget.mercadoPagoModel.grandTotalBaseVar,
        grand_total_taxes: widget.mercadoPagoModel.grandTotalTaxesVar,
        grand_total_discount:widget.mercadoPagoModel.grandTotalDiscountVar);
        context.read<ShoppingCartProvider>().resetCollectionMap();



      Navigator.of(context).pushNamedAndRemoveUntil(UserCatalogue.id, (route) => false);
      showstuff(context, 'El pago fue exitoso.\n Puedes ver el estado de tu pedido en la area "Mis ordenes".'
        '\nNumero de operacion : ${payementID} \n Estado de pago : Apropado ');
       setState(() { payementID='' ;payementStatus='' ;payementStatusDetails='' ;});
  } else {
    showstuff(context, 'Algo salio mal!!! \n Puedes intentar a pagar otra ves o escoger otra manera de pago');
  }


}

  String name = '';
  String email = '';
  bool turnSplash = false;

  @override
  Widget build(BuildContext context) {




    return userModel==null || turnSplash == true ?
    SpinKitWave(color: Colors.green, size: 50.0,):
    Scaffold(
      body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                 children: [
                    PopUpMenuWidgetUsers(putArrow: true, showcart:false,
                      callbackArrow: (){Navigator.of(context).pop();},
                      voidCallbackCart: (){
                     Navigator.of(context).pop();
                     },),

                   SizedBox(height: 60,),
                   UsedWidgets().buildTextFormWidgetForText(
                     valueInitial: userModel?.name, label:'Nombre completo de quien paga ',
                     onChanged: (value) {setState(() {name  = value!;});},), SizedBox(height: 20,),
                   UsedWidgets().buildTextFormWidgetForEmail(
                     valueInitial:userModel?.email ?? '', label:'Correo electrónico de quien paga',
                     onChanged: (value) {setState(() {email = value!;});},), SizedBox(height: 10,),
                  SizedBox(height: 60,),

                   Container(
                       decoration: BoxDecoration(
                         color: Colors.greenAccent,
                         borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                       child: Padding(
                         padding: const EdgeInsets.all(12.0),
                         child: Column(
                           children: [
                             Text(' Total a pagar ',style: TextStyle(fontSize: 24),),
                             Text('  ${widget.mercadoPagoModel.grandTotalVar}\$',style: TextStyle(fontSize: 28,color: Colors.green),),
                           ],
                         ),
                       )),

                   SizedBox(height: 40,),
                     TextButton(
                       onPressed: () async {
                      setState(() {isLoading=true;});
                      await _showToast();
                       setState(() {isLoading=false;});

                       },

                        child: isLoading==true? CircularProgressIndicator():
                        Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Pagar Ahora', style: TextStyle(fontSize: 34,color: Colors.white)),
                            )
                        )

                     )


                 ],
        ),
              ),
            ),
      ),
    );
  }
  Future<void> _showToast() async {

    // String payementIdFromAp =await  PayementPreference().getPaymentId(
    //     widget.grandTotal,
    //     name==''?userModel!.name:name,
    //     email==''?userModel!.email:email
    // );

    String payementIdFromAp =await  PayementPreference().getPaymentId(
        widget.mercadoPagoModel.grandTotalVar,
       'TETE2170033',
       'test_user_14791293@testuser.com'
    );
    setState(() {
       payementID='' ;
       payementStatus ='' ;
       payementStatusDetails  ='';
       payementError='';

     });
    await methodChannelPayement.invokeMethod('showToast', <String, String>{
      'msg': 'This is a toast message from Flutter to android',
      'prefernceId' :payementIdFromAp,
      'pubkey' :'TEST-dc5e98df-3102-4256-abad-4dd12def5852',
    });










  // await methodChannelPayement.invokeMethod('showToast', <String, String>{
  //     'msg': 'This is a toast message from Flutter to android',
  //     'prefernceId' :payementIdFromAp,
  //     // 'pubkey' :'APP_USR-3736c193-6b7e-4d40-8aad-bef2aefa9eb7',
  //     'pubkey' :'TEST-dc5e98df-3102-4256-abad-4dd12def5852',
  //   });
  }


}
