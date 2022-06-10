import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';

class OrdersPaginatedModel{


  List<OrderModel> listOfOrders =[];
  List<UserModel> listOfDeliveryMen=[];
  int total=0;
  String ? startTime;
  String ? endtTime;

  int AllOrders=0;

   int EnLaTiendaEnGeneral=0;
  int EnLaTiendaRicibido= 0;
  int EnLaTiendaEnPreparacion= 0;
  int EnLaTiendaListoParaEntrega= 0;
  int EnLaTiendaEntregado=0;
  int EnLaTiendaPendiente=0;



  int AldomicilioEnGeneral=0;
  int Aldomiciliorecibido=0;
  int AldomicilioEnPreparacion= 0;
  int AldomicilioEnCamino=0;
  int AldomicilioEntregado=0;
  int AldomicilioPendiente=0;




  OrdersPaginatedModel();

  factory  OrdersPaginatedModel.fromjson(Map<String,dynamic> json){

     OrdersPaginatedModel ordersPaginatedModel =OrdersPaginatedModel();




     ordersPaginatedModel.AllOrders=json['AllOrders']??0 ;

    ordersPaginatedModel.EnLaTiendaEnGeneral=json['EnLaTiendaEnGeneral'] ??0;

     ordersPaginatedModel.EnLaTiendaRicibido=json['EnLaTiendaRicibido']??0 ;

    ordersPaginatedModel.EnLaTiendaEnPreparacion=json['EnLaTiendaEnPreparacion']??0 ;

    ordersPaginatedModel.EnLaTiendaListoParaEntrega=json['EnLaTiendaListoParaEntrega']??0 ;

    ordersPaginatedModel.EnLaTiendaEntregado=json['EnLaTiendaEntregado']??0 ;

    ordersPaginatedModel.EnLaTiendaPendiente=json['EnLaTiendaPendiente']??0 ;

    ordersPaginatedModel.AldomicilioEnGeneral=json['AldomicilioEnGeneral']??0 ;

    ordersPaginatedModel.Aldomiciliorecibido=json['Aldomiciliorecibido']??0 ;

    ordersPaginatedModel.AldomicilioEnPreparacion=json['AldomicilioEnPreparacion']??0 ;

    ordersPaginatedModel.AldomicilioEnCamino=json['AldomicilioEnCamino']??0 ;

    ordersPaginatedModel.AldomicilioEntregado=json['AldomicilioEntregado'] ??0;

    ordersPaginatedModel.AldomicilioPendiente=json['AldomicilioPendiente']??0 ;


     for( var deliveryMan  in json['domiciliarios'] ??[]   ){
      UserModel temp = UserModel.fromJson(deliveryMan);
      ordersPaginatedModel.listOfDeliveryMen.add(temp);
    }


    ordersPaginatedModel.startTime =json['start_time'] ;
    ordersPaginatedModel.endtTime =json['end_time'];

   ordersPaginatedModel.total = json['orders']['total'] ;

    for( var order  in json['orders']['data']   ){
      OrderModel temp = OrderModel.fromJason(order);
      ordersPaginatedModel.listOfOrders.add(temp);
    }
    return ordersPaginatedModel;
  }
}

class OrderModel{
 int? id;
 int? user_id;
 String? status;
 String? manera_entrega;
 String? manera_pago;
 String? manera_pago_details;//added recentley
 int? trucking_number;
 String? delivery_fee;
 String? grand_delivery_fees_in;
 String? grand_total;
 String? grand_total_base;
 String? grand_total_taxes;
 String? grand_total_discount;
 int? repartidor;
 String? observation;//added recentley
 String? created_at;
 UserModelByIdForOrders ? getUser;
 UserModelByIdForOrders? domiciliarioAsignado;

  OrderModel();

  factory OrderModel.fromJason(Map<String,dynamic> json){

    OrderModel orderModel=OrderModel();
    orderModel.id=json['id']  ?? null;
    orderModel.user_id=json['user_id']  ?? null;
    orderModel.status=json['status']  ?? null;
    orderModel.manera_entrega=json['manera_entrega']  ?? null;
    orderModel.manera_pago=json['manera_pago']  ?? null;

    orderModel.manera_pago_details=json['manera_pago_details']  ?? null;//added recentley

    orderModel.trucking_number=json['trucking_number']  ?? null;
    orderModel.delivery_fee=json['delivery_fee']  ?? null;
    orderModel.grand_delivery_fees_in=json['grand_delivery_fees_in']  ?? null;
    orderModel.grand_total=json['grand_total']  ?? null;
    orderModel.grand_total_base=json['grand_total_base']  ?? null;
    orderModel.grand_total_taxes=json['grand_total_taxes']  ?? null;
    orderModel.grand_total_discount=json['grand_total_discount']  ?? {};
    orderModel.repartidor=json['repartidor_id']  ?? null;

    orderModel.observation=json['observation']  ?? null;//added recentley

    orderModel.created_at=json['created_at']  ?? null;
    orderModel.getUser=UserModelByIdForOrders.fromJason(json['get_order_id_for_order_model'] ?? {});
    orderModel.domiciliarioAsignado=UserModelByIdForOrders.fromJason(json['get_delivery_men'] ?? {});



    return orderModel;
  }

}


class UserModelByIdForOrders{
  UserModel? user;
  UserModelByIdForOrders();
  factory UserModelByIdForOrders.fromJason(Map<String,dynamic> json){
    UserModelByIdForOrders userModelByIdForOrders=UserModelByIdForOrders();
    userModelByIdForOrders.user= UserModel.fromJson(json);
    return userModelByIdForOrders;
  }

}


