import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'delivery_men/al_domicilio_en_camino.dart';
import 'delivery_men/al_domicilio_en_preparacion.dart';
import 'delivery_men/al_domicilio_entregado.dart';
import 'delivery_men/al_domicilio_pendiente.dart';
import 'delivery_men/al_domicilio_recibido.dart';
import 'delivery_men/en_la_tienda_en_preparacion.dart';
import 'delivery_men/en_la_tienda_recibidos.dart';
import 'delivery_men/en_tienda_entregado.dart';
import 'delivery_men/en_tienda_listo_para_entrega.dart';
import 'delivery_men/en_tienda_pendiente.dart';
import 'delivery_men_profile_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class DeliveryMenDashboard extends StatefulWidget {
  static const String id = '/deliverymenDashboard';
  const DeliveryMenDashboard({Key? key}) : super(key: key);

  @override
  State<DeliveryMenDashboard> createState() => _DeliveryMenDashboardState();
}

class _DeliveryMenDashboardState extends State<DeliveryMenDashboard> {

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

    return  ordersPaginatedModel;
  }


  bool iSLoading = false;
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
    setState(() {onFetchingProcess =true;});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  await prefs.getString('spToken');
    name =  await prefs.getString('username');
    id =  await prefs.getInt('id');
    setState(() {
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
        orderStatus: '' ,
        orderManeraEntrega: '',
        orderManeraDepago:maneraDepagoSelectado ,
        orderStartTime:context.read<GetPedidosProvider>().getselectedTimeStart,
        OrderEndTime:context.read<GetPedidosProvider>().getselectedTimeEnd,
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
      context.read<GetPedidosProvider>().setStartTimeDefaultFromApi(_startTimeDefaultFromApi);
      context.read<GetPedidosProvider>().setEndTimeDefaultFromApi(_endTimeDefaultFromApi);
      onFetchingProcess =false;
    });
  }


  @override
  void initState()
  { super.initState();
  initFetchData();
  }

  @override void  dispose(){
    _idController.dispose();
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body:iSLoading?SpinKitWave(color: Colors.green, size: 50.0,): Column(
            children: [


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () async {Navigator.of(context).pushNamed(DeliveryMenProfileScreen.id);
                      }, icon: Icon(Icons.account_circle_outlined,color: Colors.green,),),


                    IconButton(onPressed: () async {setState(() {iSLoading =true;});
                      bool answer= await LogoutAdminUserDeliveryMen().logOutDeliveryMen(context);
                      if(answer==true){Navigator.pushNamed(context, LoginScreen.id);
                        UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                      } else{UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                      }setState(() {iSLoading == false;});}, icon:  Icon(Icons.exit_to_app,color: Colors.red,),),],),),



              Container(
                width: double.infinity,
                child: Card(
                  color: Color(0xFF9FE2BF ),
                  elevation: 20,
                  child:Column(children: [
                    SingleChildScrollView(scrollDirection:Axis.horizontal,child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Text('${name}', style: TextStyle(fontSize: 20),),)),
                    Divider(thickness: 2,),
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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: ()async{
                          String beginTime = await context.read<GetPedidosProvider>().getselectedTimeStart;
                          String endTime= await context.read<GetPedidosProvider>().getselectedTimeEnd;
                          setState(() {selectedTimeStart= beginTime;selectedTimeEnd=endTime;});
                          await initFetchData();},
                        child: Container(
                        width: double.infinity, child: Card(
                          color: Color(0xFFCCCCFF),child: Icon(Icons.search,size: 50,color: Colors.white,)),),
                      ),
                    ),

                    totalFromApi==0?Text('',style: TextStyle(fontSize: 20,color: Colors.indigo),):
                    Padding(
                      padding: const EdgeInsets.all( 8.0),
                      child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                        children: [Text(' Total Pedidos asignados : ',
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                          Text('${dataFromApi.AllOrders}', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22,color: Colors.blue,fontWeight: FontWeight.bold),),],)),),

                  ],) ,
                ),
              ),


              ordersList.isEmpty && onFetchingProcess==true  ?
              SpinKitWave(color: Colors.green, size: 50.0,)
                  :
            Expanded(
              child: Card(
                child: ListView( children: [


                  Divider(thickness: 2,),
                  Padding(padding: const EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                      children: [Icon(Icons.storefront_rounded,size: 28,color: Colors.amber,),
                        SizedBox(width: 4.0,), Text('En tienda  : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                        Text('${dataFromApi.EnLaTiendaEnGeneral}', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22,color: Colors.blue,fontWeight: FontWeight.bold),),],)),),

                  Divider(thickness: 2,),
                  InkWell(onTap: (){Navigator.of(context).pushNamed(EnLatiendaRecibido.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Recibidos  : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.EnLaTiendaRicibido}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),


                  InkWell(onTap: (){Navigator.of(context).pushNamed(EnLaTiendaEnPreparacion.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('En preparcaion  : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.EnLaTiendaEnPreparacion}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),


                  InkWell(
                    onTap: (){Navigator.of(context).pushNamed(EnLaTiendaListoParaEntrega.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Listos Para entrega  : ',
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.EnLaTiendaListoParaEntrega}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),

                  InkWell(onTap: (){Navigator.of(context).pushNamed(EnLaTiendaEntregado.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Entregados : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.EnLaTiendaEntregado}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),

                  InkWell(onTap: (){Navigator.of(context).pushNamed(EnLaTiendaPendiente.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(children: [ Text('Pendientes : ',
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.EnLaTiendaPendiente}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),

//============================================================Aldomicilio==========================

                  Divider(thickness: 2,),
                  Padding(padding: const EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(scrollDirection:Axis.horizontal,
                        child: Row(children: [Icon(Icons.delivery_dining, size: 28,color: Colors.amber,),
                        SizedBox(width: 4.0,), Text('Al domicilio  : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                        Text('${dataFromApi.AldomicilioEnGeneral}', textAlign: TextAlign.center,



                          style: TextStyle(fontSize: 22,color: Colors.blue,fontWeight: FontWeight.bold),),],)),),

                  Divider(thickness: 2,),
                  InkWell(onTap: (){Navigator.of(context).pushNamed(AlDomicilioRecibidos.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Recibidos  : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.Aldomiciliorecibido}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],
                        )
                        ),
                      ),),
                  ),


                  InkWell(onTap: (){Navigator.of(context).pushNamed(AlDomicilioEnPreparacion.id);},
                    child: Card(color: Color(0xFFE8F6F3 ), child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(children: [ Text('En preparcaion  : ',
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.AldomicilioEnPreparacion}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),


                  InkWell(onTap: (){Navigator.of(context).pushNamed(AlDomicilioEncamino.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0), child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('En camino : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.AldomicilioEnCamino}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),

                  InkWell(onTap: (){Navigator.of(context).pushNamed(AlDomicilioEntregado.id);},
                    child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Entregados : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.AldomicilioEntregado}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),
                  ),

                  InkWell(onTap: (){Navigator.of(context).pushNamed(AlDomicilioPendiente.id);}, child: Card(color: Color(0xFFE8F6F3 ),
                      child: Padding(padding: const EdgeInsets.all( 8.0),
                        child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Row(
                          children: [ Text('Pendientes : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                            Text('${dataFromApi.AldomicilioPendiente}', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),],)),),),),

                ],

    ),
              ),
            )  ],
          ),
        ),
      ),
    );
  }






}
