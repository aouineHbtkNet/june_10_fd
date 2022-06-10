import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class GetPedidosProvider extends ChangeNotifier {


  // List <String> estadoListado =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
// List <String> listadoEstadoAlDomicilio =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
// List <String> listadoEstadoenlaTienda =['Recibido', 'En preparación', 'Listo para la entrega', 'En camino', 'Entregado', 'Pendiente'];
// List <String> maneraDePagoListado = [ 'En la linea', 'DataFono', 'efectivo'];
// List <String> maneraDeentregaListado =['Al domicilio', 'A la tienda'];



  String startTimeDefaultFromApi='';

  setStartTimeDefaultFromApi(String input){
    startTimeDefaultFromApi=input;
    notifyListeners();
  }
  String  endTimeDefaultFromApi ='';
  setEndTimeDefaultFromApi(String input){
    endTimeDefaultFromApi=input;
    notifyListeners();
  }
  String selectedTimeStart='' ;
 String get getselectedTimeStart=>selectedTimeStart;
  String selectedTimeEnd ='' ;
  String get getselectedTimeEnd=>selectedTimeEnd;
  int  _difference=1;
  int? get getDifference=>_difference;
  DateTimeRange? newDateTimeRange ;


  pickDateRange(BuildContext context) async {await pickDateRangeFunction(context);notifyListeners();}

  Future  pickDateRangeFunction( BuildContext context ) async {
   newDateTimeRange = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: DateTime.parse(startTimeDefaultFromApi),
            end: DateTime.parse( endTimeDefaultFromApi).add(Duration(hours: 23,minutes: 59))
        ),
        firstDate: DateTime(2022),
        lastDate:DateTime(2040));
    if (newDateTimeRange==null) return;
       _difference =newDateTimeRange?.duration.inDays??1;
      selectedTimeStart = DateFormat('yyyy-MM-dd ').format(newDateTimeRange!.start).toString();
      selectedTimeEnd  = DateFormat('yyyy-MM-dd ').format(newDateTimeRange!.end).toString();
    notifyListeners();
  }








}