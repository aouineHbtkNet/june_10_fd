import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/delete_order.dart';
import 'package:simo_v_7_0_1/apis/modify_status.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'orders_admin_details.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class OrdersdashBoardForAdmins extends StatefulWidget {
  const OrdersdashBoardForAdmins({Key? key}) : super(key: key);
  static const String id = '/OrdersdashBoardForAdmins';
  @override
  State<OrdersdashBoardForAdmins> createState() => _OrdersdashBoardForAdminsState();
}

class _OrdersdashBoardForAdminsState extends State<OrdersdashBoardForAdmins> {


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
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/getOrdersWithFilters?page=$page');
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
    String? maneraDeEntregaSelectado;
    String? maneraDepagoSelectado;
     String? maneraDepagoSelectadoEnvio;
    String? estadoSelectado;
    String? estadoSelectadoForPopUp;
     String? domicilrioSelectadoForPopUpChange;
     String? DomiciliarioSelectado;
    List <String> estadoListado =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
  List <String> listadoEstadoAlDomicilio =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
  List <String> listadoEstadoenlaTienda =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
   List <String> maneraDePagoListado = [ 'En la linea', 'DataFono', 'efectivo'];
  List <String> maneraDeentregaListado =['Al domicilio', 'A la tienda'];
  int  _difference=1;
  int page =1;
  OrdersPaginatedModel dataFromApi= OrdersPaginatedModel();
  List<OrderModel> ordersList = [];
  UserModel? domiciliarioAsignado;
  UserModel userModel0   =UserModel();
  List<UserModel> domiciliarioListado=[];
  String? idToBeSearched ;
  String? nameDeliveryManToBeSearched ;
  bool hasMore=true;
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameDeliveryManController = TextEditingController();
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
  adduser0ToList() {userModel0.id=0;userModel0.name='Sin domiciliario';domiciliarioListado.add(userModel0);}
  initFetchData() async{
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
        orderStatus: estadoSelectado ,
        orderManeraEntrega: maneraDeEntregaSelectado,
        orderManeraDepago:maneraDepagoSelectado ,
        orderStartTime:selectedTimeStart,
        OrderEndTime:selectedTimeEnd,
         domicilario:DomiciliarioSelectado);
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
      adduser0ToList();
      page++;
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
    orderStatus: estadoSelectado ,
    orderManeraEntrega: maneraDeEntregaSelectado,
    orderManeraDepago:maneraDepagoSelectado ,
    orderStartTime:selectedTimeStart,
    OrderEndTime:selectedTimeEnd,
      domicilario:DomiciliarioSelectado);
     setState(() {
    ordersList.addAll(newData.listOfOrders);
    page++;
    onFetchingProcess =false; // just tells when the function in process
  });
  }

bool changeBtnStatus=false;
  final _dropdownPopUpkey = GlobalKey<FormState>();
  final _dropdownPopUpkeyDomiciliario = GlobalKey<FormState>();

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
    _nameDeliveryManController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {






    print('domicilrioSelectadoForPopUpChange========================>$domicilrioSelectadoForPopUpChange');

    return
      Scaffold(body: SafeArea(
        child: Column(children: [
          Row( mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(onPressed: () async {Navigator.of(context).pop();},
                    icon: Icon(Icons.arrow_back,color: Colors.green,),),
                ),
              
              
              Expanded(child: Text('Dias : ${_difference}',style: TextStyle(fontSize: 20,color: Colors.blueGrey),)),

                Expanded(
                  flex: 2,
                  child: Card(
                    child: TextField(controller: _idController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: _idController.text.length>0? IconButton(icon:  Icon(Icons.clear,color: Colors.red,size: 28,), onPressed: () {
                          setState(() {
                            _idController.clear();
                            idToBeSearched=null;
                          });
                        }):SizedBox(width: 0,),
                        label: const Center(child: Text("ID"),),
                        labelStyle:  TextStyle(fontSize: 20,color: Colors.black),
                        border: InputBorder.none,),
                      onChanged: (value) { idToBeSearched= value;setState(() {});},),
                  ),
                ),
            ],), Divider(thickness: 2,),


             SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                 InkWell(onTap:() async{
                   DateTimeRange? newDateTimeRange = await showDateRangePicker(
                       context: context, initialDateRange: DateTimeRange(start: DateTime.parse(_startTimeDefaultFromApi),
                       end: DateTime.parse( _endTimeDefaultFromApi).add(Duration(hours: 23,minutes: 59))
                       ),
                       firstDate: DateTime(2022),
                       lastDate:DateTime(2040));
                   if (newDateTimeRange==null) return;
                   setState(() {
                     _difference =newDateTimeRange.duration.inDays;
                     selectedTimeStart = DateFormat('yyyy-MM-dd ').format(newDateTimeRange.start).toString();
                     selectedTimeEnd  = DateFormat('yyyy-MM-dd ').format(newDateTimeRange.end).toString();
                   });
                   },
                   child:

                   dataFromApi.startTime==null?Text(''):
                   Row(children: [Padding(padding: const EdgeInsets.all(8.0),
                      child: selectedTimeStart==''?  Text(' Desde : ${ _startTimeDefaultFromApi.split(" ").first}', style: TextStyle(fontSize: 18),) :
                   Text(' Desde : ${selectedTimeStart}', style: TextStyle(fontSize: 18),
                  ),
              ),


                Padding(padding: const EdgeInsets.all(8.0),
                  child:selectedTimeEnd==''?  Text(' Hasta : ${ _endTimeDefaultFromApi.split(" ").first}', style: TextStyle(fontSize: 18),) :

                  Text(' Hasta : ${selectedTimeEnd}', style: TextStyle(fontSize: 18),),), SizedBox(height: 10,),

              ],),),),

            Divider(thickness: 2,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                    color: Colors.lightBlueAccent,
                    child: Row(children: [

                      maneraDeEntregaSelectado==null?SizedBox(width: 0,):
                      IconButton(onPressed: (){ setState(() { maneraDeEntregaSelectado=null;  });},
                        icon: Icon(Icons.clear,color: Colors.red,),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(hint: Text('Entrega'),
                            dropdownColor:Colors.lightBlueAccent, style:TextStyle(fontSize: 20,color: Colors.black,),
                            value: maneraDeEntregaSelectado, items: maneraDeentregaListado.map((String items) {
                              return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                            onChanged: (String? newValue) {setState(() {
                              maneraDeEntregaSelectado = newValue!;});},),
                        ),
                      ),

                    ],),
                  ),
                Card(
                  color: Colors.lightBlueAccent,
                  child: Row(children: [

                    estadoSelectado==null?SizedBox(width: 0,):
                    IconButton(onPressed: (){ setState(() { estadoSelectado=null;  });},
                      icon: Icon(Icons.clear,color: Colors.red,),),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(hint: Text('Estado'), dropdownColor:Colors.lightBlueAccent,
                          style:TextStyle(fontSize: 20,color: Colors.black,), value:estadoSelectado,
                          items: estadoListado.map((String items) {return DropdownMenuItem(
                            value: items, child: Text(items),);}).toList(), onChanged: (String? newValue) {setState(() {
                            estadoSelectado = newValue!;});},),
                      ),
                    ),

                  ],),
                )







              ],),),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  child: Row(children: [
                    maneraDepagoSelectado==null?SizedBox(width: 0,):
                    IconButton(onPressed: (){ setState(() { maneraDepagoSelectado=null;  });},
                      icon: Icon(Icons.clear,color: Colors.red,),),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(hint: Text('Pago'),
                          dropdownColor:Colors.lightBlueAccent, style:TextStyle(fontSize: 20,color: Colors.black,),
                          value: maneraDepagoSelectado, items: maneraDePagoListado.map((String items) {
                            return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                          onChanged: (String? newValue) {setState(() {
                            maneraDepagoSelectado = newValue!;});},),
                      ),
                    ),
                  ],),
                ),

                Card( color: Colors.lightBlueAccent,
                  child: Row(children: [
                    DomiciliarioSelectado==null?SizedBox(width: 0,):
                    IconButton(onPressed: (){ setState(() { DomiciliarioSelectado=null;  });},
                      icon: Icon(Icons.clear,color: Colors.red,),),


                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Text('Domiciliario'), dropdownColor:Colors.lightBlueAccent,
                          style:TextStyle(fontSize: 20,color: Colors.black,), value:DomiciliarioSelectado  ,
                          onChanged:(value) {setState(() {DomiciliarioSelectado = value!;print(DomiciliarioSelectado);});},
                          items: domiciliarioListado.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                            value: value.id.toString(), child: Text(value.name.toString()),)).toList()),
                    ),




                  ],),),
              ],),),


             InkWell(
              onTap: ()async{await initFetchData();},
              child: Container(
                width: double.infinity,
                child: Card(
                    color: Colors.purple,
                    child: Icon(Icons.search,size: 50,color: Colors.white,)),
              ),
            ),


            SingleChildScrollView(scrollDirection: Axis.horizontal, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                  Text('Cantidad de los pedidos : ',style: TextStyle(fontSize: 20,),),
                  Text('${totalFromApi}',style: TextStyle(color:Colors.teal,fontSize: 26,fontWeight: FontWeight.bold),)],),
            ),),


            ordersList.isEmpty && onFetchingProcess==true  ?
            SpinKitWave(color: Colors.green, size: 50.0,)
                :ordersList.isEmpty && onFetchingProcess==false ?
            Padding(padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('No hay pedidos', style: TextStyle(fontSize: 20,color: Colors.blueGrey,),),
                ),
              ),)
                :  Expanded(
                 child: ListView.builder(
                  controller: _scrollController,
                  itemCount: ordersList.length +1  ,
                  itemBuilder: (BuildContext ctx, index) {

                    if(index < ordersList.length){


                      void showsDomiciliriosDropdownForChange( context ) {
                        showDialog(context: context, builder: (context) {return AlertDialog(content: SingleChildScrollView(child:
                          Column(children: [SizedBox(height: 10,),
                              DropdownButtonHideUnderline(
                                child:  Form(
                                  key: _dropdownPopUpkeyDomiciliario,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField<String>(
                                        hint: Text('Domiciliario'),
                                        style:TextStyle(fontSize: 20,color: Colors.black,),
                                        value:domicilrioSelectadoForPopUpChange,
                                        onChanged:(value) {setState(() {domicilrioSelectadoForPopUpChange = value!;});},
                                        items: domiciliarioListado.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                                          value: value.id.toString(), child: Text(value.name.toString()),)).toList()),
                                  ),
                                ),),
                              SizedBox(height: 10,),],),),
                          actions: [Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: () async {
                                Navigator.of(context).pop();
                                setState(() {domicilrioSelectadoForPopUpChange=null;});},
                                  child: Center(child: Text('Regresar'))),
                              ElevatedButton(onPressed: () async {
                                if (_dropdownPopUpkeyDomiciliario.currentState!.validate()) {
                                  _dropdownPopUpkeyDomiciliario.currentState!.save();
                                  int? idInt= ordersList[index].id;
                                  setState(() { ordersList.clear();onFetchingProcess =true;});
                                  Navigator.of(context).pop();
                                 if(domicilrioSelectadoForPopUpChange==null){

                                   showNoticevalueDomicilarioEmpty(context);

                                 }else{ await ModifyStatusAndDomiciliario().modifyDomiciliario(idInt??0,domicilrioSelectadoForPopUpChange! );}
                                  setState(() {domicilrioSelectadoForPopUpChange=null;});
                                  await initFetchData();}}, child: Center(child: Text('Ok'))),],)
                          ],);});}

                      void showsStatusDropdown( context ) {
                        showDialog(context: context, builder: (context) {return AlertDialog(
                            content: SingleChildScrollView(child: Column(
                                children: [SizedBox(height: 10,), Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Form(key: _dropdownPopUpkey,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(hint: Text('Estado'),
                                            dropdownColor:Colors.lightBlueAccent, style:TextStyle(fontSize: 20,color: Colors.black,),
                                            value: estadoSelectadoForPopUp ,
                                            items:listadoEstadoAlDomicilio.map((String items) {
                                              return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                                            validator: (value) {if (value == null) {return 'Este campo es obligatorio';}},
                                            onChanged: (String? newValue) {setState(() {
                                              estadoSelectadoForPopUp = newValue!;
                                            });},),),)),
                                         SizedBox(height: 10,),],),),
                            actions: [Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(onPressed: () async {
                                  Navigator.of(context).pop();
                                  setState(() {estadoSelectadoForPopUp=null;});},
                                    child: Center(child: Text('Regresar'))),
                              ElevatedButton(onPressed: () async {
                            if (_dropdownPopUpkey.currentState!.validate()) {
                              _dropdownPopUpkey.currentState!.save();
                              int? idInt= ordersList[index].id;
                              setState(() { ordersList.clear();onFetchingProcess =true;});
                                    Navigator.of(context).pop();
                                    if(estadoSelectadoForPopUp==null){
                                      showNoticevalueEmpty(context);
                                    }else{
                                      await ModifyStatusAndDomiciliario().modifySatatus(idInt??0,estadoSelectadoForPopUp!);
                                    }
                                    setState(() {estadoSelectadoForPopUp=null;});
                                    await initFetchData();}}, child: Center(child: Text('Ok'))),],)
                          ],);});}

                      return Card(elevation: 20, child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [SingleChildScrollView(scrollDirection: Axis.horizontal, child:
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



                                  ordersList[index].status!='Pendiente'?
                                  showOrderAttrbutes(title: 'Estado', data:'${ordersList[index].status}')
                                      : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [Text('Estado : ',style: TextStyle(fontSize: 20,color: Colors.blueGrey,),),
                                            Text('${ordersList[index].status}',style:
                                            TextStyle(fontSize: 20,color: Colors.red, fontWeight: FontWeight.bold),),],),
                                      ),

                                  showOrderAttrbutes(title: 'Entrega', data:'${ordersList[index].manera_entrega}'),


                                ],),),


                                SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                    showOrderAttrbutes(title: 'Total', data:'${ordersList[index].grand_total}\$'),
                                  showOrderAttrbutes(title: 'Domiciliario', data:
                                  ordersList[index].domiciliarioAsignado?.user?.id==0?'Sin domiciliario':
                                  '${ordersList[index].domiciliarioAsignado?.user?.name}'),


                                ],),),




                              showOrderAttrbutes(title: 'Dirección', data:'${ordersList[index].getUser?.user?.address}'),



                              SingleChildScrollView(scrollDirection: Axis.horizontal, child:
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                showOrderAttrbutes(title: 'Pago', data:'${ordersList[index].manera_pago}'),
                                ordersList[index].manera_pago_details==null?SizedBox(width: 0,height: 0,):
                                showOrderAttrbutes(title: 'Detalles', data:'${ordersList[index].manera_pago_details}'),

                              ],),),









                                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(
                                                primary: Colors.grey, onPrimary: Colors.white, elevation: 20,  // ElevationshadowColor: Colors.amber,
                                              ), onPressed: () async{


                                                        Navigator.push(context, MaterialPageRoute(builder:
                                                      (context)=>OrderDetailsForAdmin(orderModel:ordersList[index],),),);

                                    },


                                              child: Text('Detalles',style: TextStyle(fontSize: 20),),),),
                                    SizedBox(width: 10,),

                                    Expanded(child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.lightGreen, onPrimary: Colors.white, elevation: 20,  // Elevation
                                            shadowColor: Colors.amber,),
                                           onPressed: () async{

                                                ordersList[index].manera_entrega=='A la tienda'?filterStatusListEnLaTienda(string: ordersList[index].status)
                                                 :filterStatusListAldomicilio(string: ordersList[index].status);
                                                  showsStatusDropdown(context);





                                            }, child: Text('Estado',style: TextStyle(fontSize: 20,),)),),
                                  ],),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            ordersList[index].status=='Pendiente'?SizedBox(width: 0,): Expanded(child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(primary: Colors.orangeAccent, onPrimary: Colors.white,
                                                    elevation: 20, shadowColor: Colors.amber,),
                                                    onPressed: () async{
                                                int? id4=ordersList[index].id;
                                                setState(() { ordersList.clear();onFetchingProcess =true;});
                                                await ModifyStatusAndDomiciliario().modifySatatus(id4??0,'Pendiente');
                                                await initFetchData();
                                                }, child: Text('Pendiente',style: TextStyle(fontSize: 20,),)),),
                                          ordersList[index].status=='Pendiente'?SizedBox(width: 0,): SizedBox(width: 10,),
                                            Expanded(child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(primary: Colors.red, onPrimary: Colors.white, elevation: 20,
                                                    shadowColor: Colors.amber,),
                                                  onPressed: () async{
                                               showdeleteConfiramtion(context,ordersList[index]);
                                               setState(() {isOnProcess=false;});
                                               }, child: Text('Borrar',style: TextStyle(fontSize: 20,),)),),],),
                                   Row(children: [
                                     Expanded(child: ElevatedButton(
                                         style: ElevatedButton.styleFrom(primary: Colors.teal, onPrimary: Colors.white, elevation: 20,  // Elevation
                                           shadowColor: Colors.amber,),
                                            onPressed: () async{
                                           showsDomiciliriosDropdownForChange(context);
                                         }, child: Text('Cambiar domiciliario',style: TextStyle(fontSize: 20,),)
                                     )
                                       ,),

                                   ],)






                              ],),),);}
                    else{return   hasMore ? SpinKitWave(color: Colors.green, size: 50.0,): SizedBox(height: 0,);}


                  }
                 ),
            )
          ,],),),);}





  void showNoticevalueEmpty
      ( context  ) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(content: SingleChildScrollView(
        child: Column(children: [SizedBox(height: 10,),
          Text('Tienes que seleccionar un estado  para continuar'),
          SizedBox(height: 10,),],),), actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('OK'))),],)],);});}

  void showNoticevalueDomicilarioEmpty
      ( context  ) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(content: SingleChildScrollView(
        child: Column(children: [SizedBox(height: 10,),
          Text('Tienes que seleccionar un domiciliario para continuar'),
          SizedBox(height: 10,),],),), actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('OK'))),],)],);});}


  void showdeleteConfiramtion
      ( context  ,OrderModel orderModelinter) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(content: SingleChildScrollView(
          child: Column(children: [SizedBox(height: 10,),
                 Text('¿Está seguro de que desea eliminar pedido  número :  ${orderModelinter.id} ?'),
              SizedBox(height: 10,),],),), actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('NO'))),
            ElevatedButton(onPressed: () async {setState(() {ordersList.clear();onFetchingProcess =true;});
              Navigator.of(context).pop();await DeleteOrder().deleteOrder(orderModelinter.id??0);
              await initFetchData();}, child: Center(child: Text('Si'))),],)],);});}


  filterStatusListEnLaTienda({String? string}) {
    switch (string) {
      case "Recibido":
        {setState(() {listadoEstadoAlDomicilio = [ 'En preparación', 'Listo para la entrega', 'Entregado'];});}break;
      case "Listo para la entrega":
        {setState(() {listadoEstadoAlDomicilio = [ 'Entregado'];});}break;
      default:
        {setState(() {listadoEstadoAlDomicilio = ['Recibido', 'En preparación', 'Listo para la entrega', 'Entregado', 'Pendiente'];});}break;
    }
  }


filterStatusListAldomicilio({String? string}){
  switch( string) {
    case "Recibido": {
      setState(() {listadoEstadoAlDomicilio= [ 'En preparación', 'En camino', 'Entregado'];});}break;
    case "En preparación": {
      setState(() {listadoEstadoAlDomicilio= [ 'En camino', 'Entregado',];});}break;
    case "En camino": {
      setState(() {listadoEstadoAlDomicilio= [ 'Entregado',];});}break;
    default: {
      setState(() {listadoEstadoAlDomicilio= [ 'Recibido','En preparación', 'En camino', 'Entregado','Pendiente'];});}break;
  }

}












}


























//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/src/provider.dart';
// import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_camino.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_domicilio_en_preparacion.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_domicilio_entregados.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_domicilio_pendientes.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_domicilio_receivedos.dart';
// import 'package:simo_v_7_0_1/screens/pedidos_tienda_en_preparacion%20.dart';
// import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
// import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
//
// class PedidosAldomicilio extends StatefulWidget {
//   static const String id = '/PedidosAlDomicilio';
//   const PedidosAldomicilio({Key? key}) : super(key: key);
//
//   @override
//   _PedidosAldomicilioState createState() => _PedidosAldomicilioState();
// }
//
// class _PedidosAldomicilioState extends State<PedidosAldomicilio> {
//   ScrollController _scrollController =ScrollController();
//
//   @override void  dispose(){
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState()
//   { super.initState();
//   context.read<GetPedidosProvider>().initFetchData();
//
//   _scrollController.addListener(() async{
//     if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
//       if ( lenghthOrderList ==  lengthTotalFromAp )
//       {
//         context.read<GetPedidosProvider>().setHasMoreTofalse();
//       }
//       else{
//
//         context.read<GetPedidosProvider>().setHasMoreToTrue();
//         context.read<GetPedidosProvider>(). loadMoreData();
//       }
//     }
//   });
//
//   }
//
//   int lenghthOrderList=0;
//   int? lengthTotalFromAp;
//   bool isLoading=false;
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     lenghthOrderList = context.watch<GetPedidosProvider>().ordersList.length;
//     lengthTotalFromAp  = context.watch<GetPedidosProvider>().totalFromApi;
//
//     return Scaffold(
//
//         body: SafeArea(
//           child: Column(
//             children: [
//               PopUpMenuWidgetAdmins(putArrow: true,callbackArrow: (){Navigator.of(context).pop();},),
//
//
//               IconButton(onPressed:()async{
//                 await  context.read<GetPedidosProvider>().initFetchData();
//               }, icon: Icon(Icons.security,size: 28,)),
//               SizedBox(height: 10,),
//               Text('orders list length :  ${context.watch<GetPedidosProvider>().totalFromApi}',style: TextStyle(fontSize: 28),),
//               SizedBox(height: 10,),
//               context.watch<GetPedidosProvider>().selectedTimeStart==''?
//               Text('start time  :  ${context.watch<GetPedidosProvider>().startTimeDefaultFromApi.split(" ").first}',style: TextStyle(fontSize: 28),)
//                   :Text('start time  :  ${context.watch<GetPedidosProvider>().selectedTimeStart}',style: TextStyle(fontSize: 28),),
//               SizedBox(height: 10,),
//               context.watch<GetPedidosProvider>().selectedTimeEnd==''?
//               Text('start time  :  ${context.watch<GetPedidosProvider>(). endTimeDefaultFromApi.split(" ").first}',style: TextStyle(fontSize: 28),):
//               Text('end time :  ${context.watch<GetPedidosProvider>().selectedTimeEnd}',style: TextStyle(fontSize: 28),),
//               SizedBox(height: 10,),
//
//
//
//               IconButton(onPressed:()async{
//                 await  context.read<GetPedidosProvider>(). pickDateRange(context) ;
//               }, icon: Icon(Icons.select_all,size: 28,)),
//               SizedBox(height: 10,),
//
//
//
//               UsedWidgets().buildListTile(leadingIcon:Icons.read_more,
//                   voidCallback: (){  Navigator.of(context).pushNamed(PedidosRecividosDomicilio.id) ;  },
//                   title:' Recibidos  ' , trailing:'${ context.watch<GetPedidosProvider>().orderListOrderDeliveredReceived.length}' ),
//
//               Divider(thickness: 2,),
//               context.watch<GetPedidosProvider>().ordersList.isEmpty && context.watch<GetPedidosProvider>().onFetchingProcess==true  ?
//               SpinKitWave(color: Colors.green, size: 50.0,)
//                   :context.watch<GetPedidosProvider>().ordersList.isEmpty && context.watch<GetPedidosProvider>().onFetchingProcess==false ?
//               Padding(padding: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text('No hay pedidos',
//                       style: TextStyle(fontSize: 28,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
//                   ),
//                 ),)
//                   :  Expanded(
//
//                 child: ListView.builder(
//                     controller: _scrollController,
//                     itemCount:lenghthOrderList+1 ,
//                     itemBuilder: (context,index){
//                       if( index < lenghthOrderList){
//                         return
//                           Column(
//                             children: [
//                               Card(
//                                 color:Colors.green,
//                                 child: Container(
//                                   color: Colors.greenAccent,
//                                   height: 100,
//                                   width: double.infinity,
//                                   child: Text('${context.watch<GetPedidosProvider>().ordersList[index].id}',
//                                     style: TextStyle(fontSize: 24),),
//                                 ),
//                               ),
//
//
//                             ],
//                           );
//                       } else
//                       {
//                         return  context.watch<GetPedidosProvider>().hasMore ? SpinKitWave(color: Colors.green, size: 50.0,): SizedBox(height: 0,);
//                       }
//
//
//
//                     }
//                 ),
//
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
//










