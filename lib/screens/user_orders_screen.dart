
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/screens/users/orders_users_cart_items.dart';




class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({Key? key}) : super(key: key);
  static const String id = '/UserOrdersScreen87865';
  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {


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



  // Route::post('/getOrdersWithFiltersForUsers', [ClientResourceController::class, 'bringOrders']);
  Future   getOrdersByFilters({String? order_id, String? user_id, String? orderTruckingNumber, String? orderStatus,
    String? orderManeraEntrega, String?orderManeraDepago, String? orderStartTime, String? OrderEndTime, String? domicilario} ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print ('spToken==================${spToken}');
    final Map<String, String> _userprofileHeader =
    {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/client/getOrdersWithFiltersForUsers?page=$page');
    Map<String, dynamic> body = {'id':order_id , 'user_id':user_id, 'trucking_number':orderTruckingNumber, 'status':orderStatus ,
      'manera_entrega':orderManeraEntrega , 'manera_pago':orderManeraDepago , 'startTime':orderStartTime , 'endtTime':OrderEndTime ,
      'deliverymanid':domicilario,
    };
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader,body: jsonEncode(body));
    var  data = jsonDecode(response.body);
    OrdersPaginatedModel ordersPaginatedModel =OrdersPaginatedModel();
    ordersPaginatedModel=  await OrdersPaginatedModel.fromjson( data );
    return  ordersPaginatedModel;
  }
  void showstuff(context, var data,) {
    showDialog(context: context, builder: (context)
    {return AlertDialog(
      content: ListView.builder(
          itemCount: data['listOfOrderProducts'].length ,
          itemBuilder: (BuildContext context, index) {
            return ListTile(leading: Text('${data['listOfOrderProducts'][index]}'),);
          }), actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();},
        child: Center(child: Text('Ok')))],);});}


  String selectedTimeStart ='';
  String selectedTimeEnd ='';
  String? maneraDepagoSelectado;
  int  _difference=1;
  int page =1;
  OrdersPaginatedModel dataFromApi= OrdersPaginatedModel();
  List<OrderModel> ordersList = [];
  UserModel? domiciliarioAsignado;
  List<UserModel> domiciliarioListado=[];
  String? idToBeSearched ;
  String? nameDeliveryManToBeSearched ;
  bool hasMore=true;
  TextEditingController _idController = TextEditingController();
  ScrollController _scrollController =ScrollController();
  int totalFromApi=0 ;
  bool isDownloading=false;
  bool isSearching=false;
  bool  filteredList=false;
  bool onFetchingProcess =false;
  bool startLogingOut =false;
  String _startTimeDefaultFromApi='';
  String  _endTimeDefaultFromApi ='';
  bool isTimeFromApiLoadedOneTime = false;
  String _start='';
  String _end='';
  bool isOnProcess=false;
  bool isOnProcess2=false;
  String? token;
  String? name;
  int? id;

  initFetchData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  await prefs.getString('spToken');
    name =  await prefs.getString('username');
    id =  await prefs.getInt('id');


    print('id to be sent to bring productos user ===============$id');


    setState(() {
      onFetchingProcess =true;
      page=1;
      totalFromApi=0;
      ordersList.clear();
      _startTimeDefaultFromApi='';
      _endTimeDefaultFromApi='';
      domiciliarioListado.clear();});
    dataFromApi = await getOrdersByFilters(user_id: id.toString(),);
    setState(() {
      if(isTimeFromApiLoadedOneTime == false){
        _startTimeDefaultFromApi=dataFromApi.startTime.toString();
        _start= _startTimeDefaultFromApi;
        _endTimeDefaultFromApi=dataFromApi.endtTime.toString();
        _end= _endTimeDefaultFromApi;
        isTimeFromApiLoadedOneTime=true;}
      else{_startTimeDefaultFromApi=_start;_endTimeDefaultFromApi= _end;}
      totalFromApi =dataFromApi.total;
      ordersList=dataFromApi.listOfOrders;
      domiciliarioListado=dataFromApi.listOfDeliveryMen;

      page++;

      context.read<GetPedidosProvider>().setStartTimeDefaultFromApi(_startTimeDefaultFromApi);
      context.read<GetPedidosProvider>().setEndTimeDefaultFromApi(_endTimeDefaultFromApi);
      onFetchingProcess =false;
      hasMore=false;});
  }
  loadMoreData() async{ if(onFetchingProcess){ return;}
  setState(() {onFetchingProcess =true;});
  OrdersPaginatedModel newData =
  dataFromApi = await getOrdersByFilters(user_id: id.toString(),);
  setState(() {
    ordersList.addAll(newData.listOfOrders);
    page++;
    onFetchingProcess =false;
  });
  }


  @override
  void initState()
  { super.initState();

  initFetchData();
  _scrollController.addListener(() async{
    if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
      print('reached the scroll max');
      if (ordersList.length  == totalFromApi  ){
        setState(() { hasMore=false;});}
      else{setState(() {hasMore=true;});loadMoreData();}}});
  }

  @override void  dispose(){
    _idController.dispose();
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        resizeToAvoidBottomInset : false,

        body: SafeArea(
          child: Column(children: [
            Row(
              children: [IconButton(onPressed: () async {Navigator.of(context).pop();},
                icon: Icon(Icons.arrow_back,color: Colors.green,),),],),




            InkWell(
              onTap: () async{
               await  initFetchData();

              },
              child: Card(
                color: Colors.tealAccent,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text('Actualizar',style: TextStyle(fontSize: 24),),
                      Icon(Icons.refresh,size: 32,color: Colors.blueGrey,)
                    ],
                  ),
                ),
              ),

            ),


            Container(
              width: double.infinity,
              child: Card(
                color: Color(0xFF9FE2BF ),
                elevation: 20,
                child: Column(children: [




                  SingleChildScrollView(scrollDirection:Axis.horizontal,child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Text('Pedidos para  ${name}', style: TextStyle(fontSize: 20),),)),

                ],),),
            ),


            SizedBox(height: 16,),

            ordersList.isEmpty && onFetchingProcess==true  ? SpinKitWave(color: Colors.green, size: 50.0,)
                :ordersList.isEmpty && onFetchingProcess==false ?
            Padding(padding: const EdgeInsets.all(8.0),
              child: Padding(padding: const EdgeInsets.all(8.0), child: Center(
                child: Text('No hay pedidos', style: TextStyle(fontSize: 20,color: Colors.blueGrey,),),),),)
                :  Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: ordersList.length +1  ,
                  itemBuilder: (BuildContext ctx, index) {
                    if(index < ordersList.length){
                      return Card(elevation: 20, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [

                          SizedBox(height: 16,),




                          SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('${index+1}/${ totalFromApi}',
                              style: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.bold),),

                              Text('  ID : ${ordersList[index].id}', style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                              SizedBox(width: 10,),
                              Text('${DateTime.parse('${ordersList[index].created_at}').toLocal().year}-'
                                  '${DateTime.parse('${ordersList[index].created_at}').toLocal().month}-'
                                  '${DateTime.parse('${ordersList[index].created_at}').toLocal().day} '
                                  '${DateTime.parse('${ordersList[index].created_at}').toLocal().hour}h'
                                  '${DateTime.parse('${ordersList[index].created_at}').toLocal().minute}min',
                                style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                              SizedBox(width: 10,) ,


                            ],),),

                          showOrderAttrbutes(title: 'Estado', data:'${ordersList[index].status}'),
                          showOrderAttrbutes(title: 'Manera de entrega', data:'${ordersList[index].manera_entrega}'),

                          ordersList[index].manera_entrega=='A la tienda'?SizedBox(width: 0,height: 0,):
                          showOrderAttrbutes(title: 'Domiciliario', data:'${ordersList[index].domiciliarioAsignado?.user?.name}'),

                          showOrderAttrbutes(title: 'Pago', data:'${ordersList[index].manera_pago}'),
                          ordersList[index].manera_pago_details==null?SizedBox(height: 0,width: 0,):
                          showOrderAttrbutes(title: 'Detalles', data:'${ordersList[index].manera_pago_details}'),

                          showOrderAttrbutes(title: 'Total a pagar ', data:'${ordersList[index].grand_delivery_fees_in}\$'),

                          ordersList[index].delivery_fee=='0.000'? SizedBox(height: 0,width: 0,) :

                          showOrderAttrbutes(title: 'Costo de envio', data:'${ordersList[index].delivery_fee}\$'),
                          ordersList[index].delivery_fee=='0.000'? SizedBox(height: 0,width: 0,) :
                          showOrderAttrbutes(title: ' sub Total', data:'${ordersList[index].grand_total}\$'),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent, onPrimary: Colors.white, elevation: 20,), onPressed: () async{
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=> OrderDetailsForUsers(orderModel:ordersList[index],),),);
                              }, child: Text('Detalles',style: TextStyle(fontSize: 20),),),),
                            ],),




                          SizedBox(height: 16,)


                        ],),),);}
                    else{return   hasMore ? SpinKitWave(color: Colors.green, size: 50.0,): SizedBox(height: 0,);}
                  }),),],),),);}



}


























// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:simo_v_7_0_1/apis/user_get_orders.dart';
// import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
// import 'order_details_screen.dart';
//
// class UserOrdersScreen extends StatefulWidget {
//   static const String id = '/UserOrderScreen';
//   @override
//   State<UserOrdersScreen> createState() => _UserOrdersScreenState();
// }
//
// class _UserOrdersScreenState extends State<UserOrdersScreen> {
//
//   Widget detailedPayedOnLine(List<String > list){
//     return Column(
//       children: [
//         Container(width:double.infinity, child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Manera de pago :' ,style: TextStyle(fontSize: 20),),
//         )),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             // color: Colors.amberAccent,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//
//                   Text(list[0].toString() ,style: TextStyle(fontSize: 20),),
//                   Text(list[1].toString() ,style: TextStyle(fontSize: 20),),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Text('N.de operacion :' ,style: TextStyle(fontSize: 20),),
//                         Text(' ${list[2]}' ,style: TextStyle(fontSize: 28,color: Colors.blue),),
//                       ],
//                     ),
//                   ),
//
//                 ],),
//             ),
//           ),
//         )
//
//
//       ],
//     );
//
//   }
//
//
//
//
//   List ordersList = [];
// bool isLoading=false;
//   getOrderList() async{
//    setState(() {isLoading=true;});
//     ordersList= await  GetOrdersUser().getOrdersUser();
//    setState(() {isLoading=false;});
//   }
//   @override
//   void initState() {
//     getOrderList();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     print('signature -----------------------98765432345678909876543234567893345678');
//
//     return Scaffold(
//
//
//         body: SafeArea(
//
//               child: Column(
//
//                 children: [
//                    PopUpMenuWidgetUsers(putArrow: true,showcart: false,
//                     callbackArrow: (){Navigator.of(context).pop();},
//                       voidCallbackCart: (){}),
//                        ordersList.isEmpty && isLoading==true
//                       ?SpinKitWave(color: Colors.green, size: 50.0,)
//                       :ordersList.isEmpty && isLoading==false? Text('No hay pedidos',style: TextStyle(fontSize: 20,color: Colors.blueGrey),)
//                       : Expanded(// A la linea
//                          child: ListView.builder(
//                           itemCount: ordersList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             String paymentMethodAsString= ordersList[index]['manera_pago'].toString();
//                             List<String> paymentMethodasList =paymentMethodAsString.split(',');
//
//                              DateTime orderTime = DateTime.parse(ordersList[index]['created_at']);
//                             int year =  orderTime.year;
//                             int month = orderTime.month;
//                             int day =  orderTime.day;
//                             int hour =  orderTime.hour;
//                             int min =  orderTime.minute;
//                             int sec =  orderTime.second;
//
//
//
//                           return Padding(padding: const EdgeInsets.all(8.0), child: Card(child:
//                           Column(
//                             children: [
//
//                              SizedBox(height: 10,),
//
//
//
//
//
//                               Padding(padding: const EdgeInsets.all(8.0), child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                 Text('Fecha :' ,style: TextStyle(fontSize: 20),),
//                                 Text('${DateTime.parse(ordersList[index]['created_at'])}',
//
//
//
//                                   // '${year}-${month}-${day} ${hour}: ${min}: ${sec} ',
//
//                                   style: TextStyle(fontSize: 18,color: Colors.blueGrey),),],),),
//
//                               Divider(thickness: 4,),
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
//                               Padding(padding: const EdgeInsets.all(8.0),
//                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                       Text('Id :' ,style: TextStyle(fontSize: 20),),
//                                         Text(ordersList[index]['id'].toString() ,style: TextStyle(fontSize: 20),),],),),
//                                    Padding(padding: const EdgeInsets.all(8.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                         Text('Serial :' ,style: TextStyle(fontSize: 20),),
//                                         Text(ordersList[index]['trucking_number'].toString() ,style: TextStyle(fontSize: 20),),],)),
//                                      Padding(padding: const EdgeInsets.all(8.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                         Text('Manera de Entrega :' ,style: TextStyle(fontSize: 20),),
//
//
//
//                                           ordersList[index]['manera_entrega']==null?Text(''): Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(ordersList[index]['manera_entrega'].toString() ,style: TextStyle(fontSize: 20),),
//                                           ),],),),
//
//
//
//
//                                   paymentMethodasList.length==3? detailedPayedOnLine(paymentMethodasList)
//                                       :
//                                   Padding(padding: const EdgeInsets.all(8.0),child:
//                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                     Text('Manera de pago:' ,style: TextStyle(fontSize: 20 ),),
//                                     ordersList[index]['manera_pago']==null?Text(''): Text(ordersList[index]['manera_pago'] ,
//                                       style: TextStyle(fontSize: 20,
//                                           ),),],),),
//
//
//
//
//
//
//
//
//                             Padding(padding: const EdgeInsets.all(8.0),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                    children: [
//
//
//                                       paymentMethodasList.length==3?
//                                       Text('Total pagado :  ' ,style: TextStyle(fontSize: 20),):
//                                       Text('Total a pagar : ' ,style: TextStyle(fontSize: 20),),
//
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                              //color: Colors.amberAccent,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(8.0),
//                                                   child: Text('${ordersList[index]['grand_total']} \$' ,style: TextStyle(fontSize: 28),),
//                                                 )),
//                                           ),],),
//                               ),),
//
//
//
//
//                                   Padding(padding: const EdgeInsets.all(8.0),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//
//                                         Text('Status:' ,style: TextStyle(fontSize: 20 ),),
//                                         ordersList[index]['status']==null?Text(''): Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(ordersList[index]['status'] ,
//                                             style: TextStyle(fontSize: 20,
//                                                 fontFamily: 'OpenLight'),),
//                                         ),],),),
//
//
//
//
//                             Padding(padding: const EdgeInsets.all(8.0),
//                               child: InkWell(onTap: (){
//                                 Navigator.push(context,
//                                   MaterialPageRoute(builder:
//                                       (context)=>UserOrdersDetailsScreen (
//                                        selectedOrder:ordersList[index],
//                                  ),
//                                   ),
//                                 );
//                               },
//
//                                 child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                                     Text('Ver Detailles',style: TextStyle(color:Colors.green,
//                                         fontSize: 20,fontFamily: 'OpenDark'),), SizedBox(width: 10,),
//                                         Icon(Icons.more_horiz_outlined,size: 20,color:Colors.green)],),),)
//
//                           ],),),);}),),
//
//                 ],
//               ),
//             ));}
// }
