
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/modify_status_for_domiciliarios.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import '../delivery_men_dashboard.dart';
import 'orders_deleivery_man_cart_items.dart';

class EnLaTiendaEntregado extends StatefulWidget {
  const EnLaTiendaEntregado({Key? key}) : super(key: key);
  static const String id = '/EnLaTiendaEntregado';
  @override
  State<EnLaTiendaEntregado> createState() => _EnLaTiendaEntregadoState();
}

class _EnLaTiendaEntregadoState extends State<EnLaTiendaEntregado> {


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

  Future   getOrdersByFilters({String? order_id, String? user_id, String? orderTruckingNumber, String? orderStatus,
    String? orderManeraEntrega, String?orderManeraDepago, String? orderStartTime, String? OrderEndTime, String? domicilario} ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print ('spToken==================${spToken}');
    final Map<String, String> _userprofileHeader =
    {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/repartidor/getOrdersWithFiltersForDomiciliarios?page=$page');
    Map<String, dynamic> body = {'id':order_id , 'user_id':user_id, 'trucking_number':orderTruckingNumber, 'status':orderStatus ,
      'manera_entrega':orderManeraEntrega , 'manera_pago':orderManeraDepago , 'startTime':orderStartTime , 'endtTime':OrderEndTime ,
      'deliverymanid':domicilario,
    };
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader,body: jsonEncode(body));
    var  data = jsonDecode(response.body);
    OrdersPaginatedModel ordersPaginatedModel =OrdersPaginatedModel();
    ordersPaginatedModel=  await OrdersPaginatedModel.fromjson( data );
    print('data ==================>${data['orders']['data']}');
    print('length ==================>${ ordersPaginatedModel.listOfOrders.length}');
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
    setState(() {
      onFetchingProcess =true;
      page=1;
      totalFromApi=0;
      ordersList.clear();
      _startTimeDefaultFromApi='';
      _endTimeDefaultFromApi='';
      domiciliarioListado.clear();});
    dataFromApi = await getOrdersByFilters(
        order_id:  idToBeSearched,
        user_id: '',
        orderTruckingNumber: '',
        orderStatus: 'Entregado' ,
        orderManeraEntrega: 'A la tienda',
        orderManeraDepago:maneraDepagoSelectado ,
        orderStartTime:context.read<GetPedidosProvider>().getselectedTimeStart,
        OrderEndTime:context.read<GetPedidosProvider>().getselectedTimeEnd,
        // orderStartTime:selectedTimeStart,
        // OrderEndTime:selectedTimeEnd,
        domicilario:id.toString());
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
  await getOrdersByFilters(
      order_id:  idToBeSearched,
      user_id: '',
      orderTruckingNumber: '',
      orderStatus: 'Entregado' ,
      orderManeraEntrega: 'A la tienda',
      orderManeraDepago:maneraDepagoSelectado ,

      // orderStartTime:selectedTimeStart,
      // OrderEndTime:selectedTimeEnd,
      orderStartTime:context.read<GetPedidosProvider>().getselectedTimeStart,
      OrderEndTime:context.read<GetPedidosProvider>().getselectedTimeEnd,
      domicilario:id.toString());
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
            children: [IconButton(onPressed: () async {Navigator.of(context).pop();Navigator.of(context).pushNamed(DeliveryMenDashboard.id);},
              icon: Icon(Icons.arrow_back,color: Colors.green,),),],),



          Container(
            width: double.infinity,
            child: Card(
              color: Color(0xFF9FE2BF ),
              elevation: 20,
              child: Column(children: [
                SingleChildScrollView(scrollDirection:Axis.horizontal,child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Text('En tienda :Entregado', style: TextStyle(fontSize: 20),),)),
                Divider(thickness: 2,),
                SingleChildScrollView(scrollDirection:Axis.horizontal,child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Text('${name}', style: TextStyle(fontSize: 20),),)),

                SingleChildScrollView(scrollDirection:Axis.horizontal,child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Text(' Dias :${context.watch<GetPedidosProvider>().getDifference}', style: TextStyle(fontSize: 20),),)),

                SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                Card(
                  child: InkWell(onTap:() async{
                    context.read<GetPedidosProvider>().pickDateRange( context);},
                    child: dataFromApi.startTime==null?Text(''):
                    Row(children: [Padding(padding: const EdgeInsets.all(8.0),
                      child: context.watch<GetPedidosProvider>().selectedTimeStart==''?
                      Text(' Desde : ${ context.watch<GetPedidosProvider>().startTimeDefaultFromApi.split(" ").first}', style: TextStyle(fontSize: 18),) :
                      Text(' Desde : ${context.watch<GetPedidosProvider>().selectedTimeStart}', style: TextStyle(fontSize: 18),),),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child:context.watch<GetPedidosProvider>().selectedTimeEnd==''?
                        Text(' Hasta : ${ context.watch<GetPedidosProvider>().endTimeDefaultFromApi.split(" ").first}', style: TextStyle(fontSize: 18),) :
                        Text(' Hasta : ${context.watch<GetPedidosProvider>().selectedTimeEnd}', style: TextStyle(fontSize: 18),),),
                      SizedBox(height: 10,),],),),
                ),),
                Card( color: Color(0xFF008080),
                  child: TextField(controller: _idController, textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: _idController.text.length>0? IconButton(icon:  Icon(Icons.clear,color: Colors.red,size: 28,), onPressed: () {
                        setState(() {_idController.clear();idToBeSearched=null;});}):SizedBox(width: 0,),
                      label: const Center(child: Text("Buscar por numeros"),),
                      labelStyle:  TextStyle(fontSize: 20,color: Colors.black),
                      border: InputBorder.none,),
                    onChanged: (value) { idToBeSearched= value;setState(() {});},),
                ),
                InkWell(
                  onTap: ()async{


                    String beginTime = await context.read<GetPedidosProvider>().getselectedTimeStart;
                    String endTime= await context.read<GetPedidosProvider>().getselectedTimeEnd;

                    setState(() {selectedTimeStart= beginTime;selectedTimeEnd=endTime;});
                    await initFetchData();}, child: Container(
                  width: double.infinity, child: Card(
                    color: Colors.purple,child: Icon(Icons.search,size: 50,color: Colors.white,)),),
                ),

                totalFromApi==0?Text('',style: TextStyle(fontSize: 20,color: Colors.indigo),):
                SingleChildScrollView(scrollDirection: Axis.horizontal, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [Text('Cantidad de los pedidos : ',style: TextStyle(fontSize: 20,),),
                    Text('${totalFromApi}',style: TextStyle(color:Colors.teal,fontSize: 26,fontWeight: FontWeight.bold),)],),
                ),),



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
                            SizedBox(width: 10,),
                            Text('${DateTime.parse('${ordersList[index].created_at}').toLocal().year}-'
                                '${DateTime.parse('${ordersList[index].created_at}').toLocal().month}-'
                                '${DateTime.parse('${ordersList[index].created_at}').toLocal().day} '
                                '${DateTime.parse('${ordersList[index].created_at}').toLocal().hour}:'
                                '${DateTime.parse('${ordersList[index].created_at}').toLocal().minute}:',
                              style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                            SizedBox(width: 10,) ,
                            Text('ID : ${ordersList[index].id}', style: TextStyle(fontSize: 20,color: Colors.blueGrey),)],),),
                        SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          showOrderAttrbutes(title: 'Dirección', data:'${ordersList[index].getUser?.user?.address}'),
                          showOrderAttrbutes(title: 'Cliente', data:'${ordersList[index].getUser?.user?.name}'),
                        ],),),
                        SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          showOrderAttrbutes(title: 'Total', data:'${ordersList[index].grand_total}\$'),
                          showOrderAttrbutes(title: 'Pago', data:'${ordersList[index].manera_pago}'),
                          ordersList[index].manera_pago_details==null?SizedBox(height: 0,width: 0,):
                          showOrderAttrbutes(title: 'Detalles', data:'${ordersList[index].manera_pago_details}'),
                        ],),),


                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(
                            primary: Colors.grey, onPrimary: Colors.white, elevation: 20,), onPressed: () async{
                            print (' order model ------${ordersList[index].id}');


                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>OrderDetailsForDEliveryMen(orderModel:ordersList[index],),),);
                          }, child: Text('Detalles',style: TextStyle(fontSize: 20),),),),
                          ],),



                        Row(children: [Expanded(child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.orangeAccent, onPrimary: Colors.white,
                              elevation: 20, shadowColor: Colors.orangeAccent,),
                            onPressed: () async{
                              int? id4=ordersList[index].id;
                              setState(() { ordersList.clear();onFetchingProcess =true;});
                              await ModifyStatusForDomiciliarios().setToStatusForDomiciliarios(id4??0,'Pendiente');
                              await initFetchData();
                            }, child: Text('Pendiente',style: TextStyle(fontSize: 20,),)),),],),



                        SizedBox(height: 16,)


                      ],),),);}
                  else{return   hasMore ? SpinKitWave(color: Colors.green, size: 50.0,): SizedBox(height: 0,);}
                }),),],),),);}



}


