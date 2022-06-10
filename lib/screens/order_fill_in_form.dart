import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/apis/placeOrder.dart';
import 'package:simo_v_7_0_1/apis/set_get_sharedPrefrences_functions.dart';
import 'package:simo_v_7_0_1/apis/update_user_to_place_order.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';
import 'package:simo_v_7_0_1/modals/mercadoPago_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/start_channel_screen.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';


class OrderFillInFormWithOptions extends StatefulWidget {
  static const String id = '/ domiclioOTiendaOpciones';

  @override
  State<OrderFillInFormWithOptions> createState() =>
      _OrderFillInFormWithOptionsState();
}

class _OrderFillInFormWithOptionsState extends State<OrderFillInFormWithOptions> {
  UserModel? userModel;
  void showstuff(context, String  myString) {
    showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text(myString), actions: [
              ElevatedButton(onPressed: () async {Navigator.of(context).pop();},
                  child: Center(child: Text('Ok')))
            ],);});}


  void OnLinePayemewntAlert(context, String  myString) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text(myString), actions: [
        ElevatedButton(onPressed: () async {
          Navigator.of(context).pop();},
            child: Center(child: Text('Ok')))
      ],);});}




  @override
  void initState() {GetUserOrAdminInfo().getUserInfo().then((value)
  {setState(() {userModel = value;});});super.initState();}





  final _placeOrderKey = GlobalKey<FormState>();

  String valueSataus = '';String? valueManeraEntrega ;
  String? valueManeraPago;double valueDeliveryFees = 0.0;
  double valueGrandTotalFees = 0.0;String valueNombres = '';String valueMobilePhone = '';String valueFixedPhone = '';
  String valueEmail = '';String valueAddress = '';String valueIdentificationId = '';
  List listEntrega = Constants.LIST_MANERA_DE_ENTREGA;List listPago = Constants.LIST_MANERA_DE_PAGO;
  bool turnSplash = false;
  resetValues() {valueSataus = '';valueDeliveryFees = 0.0;valueGrandTotalFees = 0.0;
    valueNombres = '';valueMobilePhone = '';valueFixedPhone = '';valueEmail = '';
    valueAddress = '';valueIdentificationId = '';}
  @override
  Widget build(BuildContext context) {

    var  mapfproducts = context.watch<ShoppingCartProvider>().collectionMap  ;
    var  grandTotal = context.watch<ShoppingCartProvider>().productPriceTotal  ;
    var  grandTotalbase = context.watch<ShoppingCartProvider>().productPrecioSinImpuestoTotal  ;
    var  grandTotalTaxes = context.watch<ShoppingCartProvider>().productValorImpuestoTotal ;
    var  grandTotalDiscount = context.watch<ShoppingCartProvider>().productValorDescuentoTotal  ;

        print ('grandTotal-------------$grandTotal');
    print ('grandTotalbase-------------$grandTotalbase');
    print ('grandTotalTaxes-------------$grandTotalTaxes');
    print ('grandTotalDiscount-------------$grandTotalDiscount');





   return  Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [




                      PopUpMenuWidgetUsers(putArrow: true, showcart:false,
                        callbackArrow: (){Navigator.of(context).pop();},
                        voidCallbackCart: (){},), SizedBox(height: 20.0),

                      userModel==null || turnSplash== true ?  SpinKitWave(color: Colors.green, size: 50.0,) :
                      Container(
                  child: Column(children: [



                  Form(key: _placeOrderKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Total a pagar : ',style: TextStyle(fontSize: 20),),
                                SizedBox(height: 10.0),
                                Text('${context.watch<ShoppingCartProvider>().productPriceTotal} \$',style: TextStyle(fontSize: 28),),
                              ],
                            ),
                          ),),



                        SizedBox(height: 20.0),


                        UsedWidgets().buildTextFormWidgetForText(
                          valueInitial: userModel?.name, label:'Nombre completo',
                          onChanged: (value) {setState(() {valueNombres = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().buildTextFormWidgetForEmail(
                          valueInitial: userModel?.email ?? '',
                          label: 'Email', onChanged: (value) {setState(() {valueEmail = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().testWidgetEmbtyEnabled(
                          valueInitial: userModel?.fixedPhone ?? '', label: 'Teléfono fijo',
                          onChanged: (value) {setState(() {valueMobilePhone = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().buildTextFormWidgetForPhone(
                          valueInitial: userModel?.mobilePhone ?? '', label: 'Teléfono mobil',
                          onChanged: (value) {setState(() {valueMobilePhone = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().buildTextFormWidgetForText(
                          valueInitial: userModel?.address ?? '', label: 'Direccion',
                          onChanged: (value) {setState(() {valueAddress = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().buildTextFormWidgetForText(
                          valueInitial: userModel?.identificationId, label: 'N.identificaion',
                          onChanged: (value) {setState(() {valueIdentificationId = value!;});},), SizedBox(height: 20,),

                        UsedWidgets().buildDropDownButtonFixedList(
                            label: 'Escoger la manera de la entrega ', valueInitial: valueManeraEntrega,
                            onChanged:(value) {setState(() {valueManeraEntrega = value!;}
                            );}, list: listEntrega), SizedBox(height: 20,),

                        UsedWidgets().buildDropDownButtonFixedList(
                            label: 'Escoger la manera del pago ', valueInitial: valueManeraPago,
                            onChanged:(value) {setState(() {valueManeraPago = value!;}
                            );},  list: listPago),],),), SizedBox(height: 20,),

                  Container(
                    color: Colors.transparent, width: MediaQuery.of(context).size.width,
                    height: 60, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () async {
                      double?  _deliveryFeeAmount;
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      _deliveryFeeAmount= await prefs.getDouble('deliveryfeeamount');

                      if (_placeOrderKey.currentState!.validate()) {_placeOrderKey.currentState!.save();
                      setState(() {turnSplash = true;});

                      await UpdateUserToPlaceOrder().updateAllUserInfo(
                          name: valueNombres== ''? userModel!.name:valueNombres,
                          email: valueEmail==''?userModel!.email:valueEmail,
                          mobile_phone: valueMobilePhone==''? userModel!.mobilePhone:valueMobilePhone,
                          fixed_phone: valueFixedPhone==''?userModel!.fixedPhone:valueFixedPhone,
                          address: valueAddress ==''?userModel!.address:valueAddress,
                          identification_id: valueIdentificationId ==''?userModel!.identificationId:valueIdentificationId);

                      UserModel user=  await  GetUserOrAdminInfo().getUserInfo();

                      SetAndGetSharedPrefrences().setSharedPrefrences(
                          name: user.name,
                          email:user.email,
                          mobilePhone: user.mobilePhone,
                          fixedPhone: user.fixedPhone,
                          address: user.address,
                          identificationNumber:user.identificationId);

// =============================================================Here to start palce order=============================
                      List<CartModel>  listOfCartModel =[];// create an empty list of cartModel : the map of products as ProductModel

                      mapfproducts.forEach((key, value) { // filling the list of list of cartModel from mapofproduct using a cartmodel instance
                        CartModel cartModel =CartModel();
                        cartModel.product_id=key.id;
                        cartModel.product_quantity=value;
                        cartModel.producto_precio_total=key.precio_ahora*value;
                        cartModel.producto_precio_sinimpuesto_total=key.precio_sin_impuesto*value;
                        cartModel.producto_valor_impuesto_total=key.valor_impuesto*value;
                        cartModel.producto_valor_descuento_total=key.valor_descuento*value;
                        listOfCartModel.add(cartModel);});




                      if (valueManeraPago=='A la linea'){



                        double grandTotalVar=double.parse(grandTotal);
                        double grandTotalBaseVar=double.parse(grandTotalbase);
                        double grandTotalTaxesVar=double.parse(grandTotalTaxes);
                        double grandTotalDiscountVar=double.parse(grandTotalDiscount);
                        MercadoPagoModelPlaceOrder mercadoPagoModel =
                        MercadoPagoModelPlaceOrder(
                            valueSataus:valueSataus ,
                            manera_entrega: valueManeraEntrega,
                            manera_pago: valueManeraPago,
                            manera_pago_details: '',
                            grandTotalVar: grandTotalVar,
                            grandTotalDiscountVar: grandTotalDiscountVar,
                            grandTotalTaxesVar: grandTotalTaxesVar,
                            listOfCartModel:listOfCartModel,
                            grandTotalBaseVar: grandTotalBaseVar
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChannelPage (mercadoPagoModel: mercadoPagoModel,),),);
                        // context.read<ShoppingCartProvider>().resetCollectionMap();
                        resetValues();
                        setState(() {turnSplash = false;});









                      } else{
                        await  PlaceOrder().placeOrder(
                            cartModeList: listOfCartModel,
                            status: valueSataus,
                            manera_entrega:valueManeraEntrega ,
                            manera_pago:valueManeraPago ,
                           // delivery_fee: _deliveryFeeAmount,
                          //  grand_delivery_fees_in: (double.parse(grandTotal)+ (_deliveryFeeAmount==null?0:_deliveryFeeAmount)),
                            grand_total:double.parse(grandTotal),
                            grand_total_base: double.parse(grandTotalbase),
                            grand_total_taxes: double.parse(grandTotalTaxes),
                            grand_total_discount:double.parse(grandTotalDiscount));
                        context.read<ShoppingCartProvider>().resetCollectionMap();
                       resetValues();
                        Navigator.of(context).pushNamedAndRemoveUntil(UserCatalogue.id, (route) => false);
                        setState(() {turnSplash = false;});


                        UsedWidgets().showscreenShot(
                            context,
                            Column(children: [
                              Text('Tu pedido se recibió con éxito.'
                                  'Puedes seguir mirando el estado de tu pedido haciendo clic en el  icono  : ',
                                style: TextStyle(fontSize: 20),),

                              Icon(Icons.book_outlined,color:Colors.green,size: 40,)
                            ],)

                        );





                      }




                      }},

                      style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),),
                        primary: Colors.green, onPrimary: Colors.black,),
                      child: Text('Hacer un pedido', style: TextStyle(fontSize: 20.0),),
                    ),
                  ),
                  )




                ],

                ),),





                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
