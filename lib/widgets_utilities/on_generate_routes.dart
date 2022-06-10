import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/items_in_cart_for_admin.dart';
import 'package:simo_v_7_0_1/modals/mercadoPago_model.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/screens/add_admin.dart';
import 'package:simo_v_7_0_1/screens/add_new_category_screen.dart';
import 'package:simo_v_7_0_1/screens/admin_change_password.dart';
import 'package:simo_v_7_0_1/screens/admin_edit_product.dart';
import 'package:simo_v_7_0_1/screens/admin_profile_screen.dart';
import 'package:simo_v_7_0_1/screens/admin_selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/admin_user_name_edit.dart';
import 'package:simo_v_7_0_1/screens/admins/add_new_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/add_new_delivery_man.dart';
import 'package:simo_v_7_0_1/screens/admins/add_new_user.dart';
import 'package:simo_v_7_0_1/screens/admins/change_pswrd_delivery_man_by_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/edit_delivery_men_by_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/options_admins_by_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/options_delivery_men_by_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/options_users_by_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/orders_admin_details.dart';
import 'package:simo_v_7_0_1/screens/admins/orders_dashboard_for_admins.dart';
import 'package:simo_v_7_0_1/screens/admins/show_delievery_men_details_for_admin.dart';
import 'package:simo_v_7_0_1/screens/admins/show_details_admins.dart';
import 'package:simo_v_7_0_1/screens/admins/show_users_details_for_admin.dart';
import 'package:simo_v_7_0_1/screens/anadir_borrar_categorias_screen.dart';
import 'package:simo_v_7_0_1/screens/deleivery_admin_edit_account_info.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/al_domicilio_en_camino.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/al_domicilio_en_preparacion.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/al_domicilio_entregado.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/al_domicilio_pendiente.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/al_domicilio_recibido.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/en_la_tienda_en_preparacion.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/en_la_tienda_recibidos.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/en_tienda_entregado.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/en_tienda_listo_para_entrega.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/en_tienda_pendiente.dart';
import 'package:simo_v_7_0_1/screens/delivery_men/orders_deleivery_man_cart_items.dart';
import 'package:simo_v_7_0_1/screens/delivery_men_dashboard.dart';
import 'package:simo_v_7_0_1/screens/delivery_men_edit_password_screen.dart';
import 'package:simo_v_7_0_1/screens/delivery_men_profile_screen.dart';
import 'package:simo_v_7_0_1/screens/error_screen.dart';
import 'package:simo_v_7_0_1/screens/order_details_screen.dart';
import 'package:simo_v_7_0_1/screens/products_statistics.dart';
import 'package:simo_v_7_0_1/screens/screen_to_send_code.dart';
import 'package:simo_v_7_0_1/screens/start_channel_screen.dart';
import 'package:simo_v_7_0_1/screens/user_account_edit.dart';
import 'package:simo_v_7_0_1/screens/user_change_password.dart';
import 'package:simo_v_7_0_1/screens/users/orders_users_cart_items.dart';


class RouteGenerator {


//   Navigator.push(context,
//   MaterialPageRoute(builder:
//   (context)=>UserOrdersDetailsScreen (
//   selectedOrder:ordersList[index],
//   ),
//   ),
//   );
// },


  // Navigator.push(context, MaterialPageRoute(builder:
  // (context)=>AdminProfileScreen (),
  // ),);},

  // if (settings.name == UserOrdersDetailsScreen.id) {
  // var data  = settings.arguments;
  // return MaterialPageRoute(
  // builder: (context) => UserOrdersDetailsScreen(selectedOrder: data,),
  // );
  // }





  static Route<dynamic> generateRoute(RouteSettings settings) {









//UsersProfileScreenByAdmin


    if (settings.name == UsersProfileScreenByAdmin.id) {

      int? id  = settings.arguments as int? ;
      return MaterialPageRoute(
        builder: (context) => UsersProfileScreenByAdmin(selectedId:id,),
      );
    }


    if (settings.name == ChangePswrdDeliveryByAdmin.id) {

      int? id  = settings.arguments as int? ;
      return MaterialPageRoute(
        builder: (context) => ChangePswrdDeliveryByAdmin(selectedId:id,),
      );
    }


    if (settings.name == EditDeliveryManByAdmin.id) {

      int? id  = settings.arguments as int? ;
      return MaterialPageRoute(
        builder: (context) => EditDeliveryManByAdmin(selectedId:id,),
      );
    }



    if (settings.name == DeliveryMenProfileScreenByAdmin.id) {

      int? id  = settings.arguments as int? ;
      return MaterialPageRoute(
        builder: (context) => DeliveryMenProfileScreenByAdmin(selectedId:id,),
      );
    }





    if (settings.name == AdminsProfileScreenByAdmin.id) {

     int? id  = settings.arguments as int? ;
      return MaterialPageRoute(
        builder: (context) => AdminsProfileScreenByAdmin(selectedId:id,),
      );
    }

















    if (settings.name == ScreenToSendCodeAndNewPswrd.id) {
    var email  = settings.arguments;
    return MaterialPageRoute(
    builder: (context) => ScreenToSendCodeAndNewPswrd(emailFromApi: email,),
    );
    }

//AlDomicilioPendiente

    if (settings.name == AlDomicilioPendiente.id) {
      return MaterialPageRoute(
        builder: (context) => AlDomicilioPendiente(),
      );
    }



    if (settings.name == AlDomicilioEntregado.id) {
      return MaterialPageRoute(
        builder: (context) => AlDomicilioEntregado(),
      );
    }

    if (settings.name == AlDomicilioEncamino.id) {
      return MaterialPageRoute(
        builder: (context) => AlDomicilioEncamino(),
      );
    }








    if (settings.name == AlDomicilioEnPreparacion.id) {
      return MaterialPageRoute(
        builder: (context) => AlDomicilioEnPreparacion(),
      );
    }



    if (settings.name == AlDomicilioRecibidos.id) {
      return MaterialPageRoute(
        builder: (context) => AlDomicilioRecibidos(),
      );
    }

    if (settings.name == EnLaTiendaPendiente.id) {
      return MaterialPageRoute(
        builder: (context) => EnLaTiendaPendiente(),
      );
    }
    if (settings.name == EnLaTiendaEntregado.id) {
      return MaterialPageRoute(
        builder: (context) => EnLaTiendaEntregado(),
      );
    }


    if (settings.name == EnLaTiendaListoParaEntrega.id) {
      return MaterialPageRoute(
        builder: (context) => EnLaTiendaListoParaEntrega(),
      );
    }

    if (settings.name == EnLaTiendaEnPreparacion.id) {
      return MaterialPageRoute(
        builder: (context) => EnLaTiendaEnPreparacion(),
      );
    }



    if (settings.name == EnLatiendaRecibido.id) {
      return MaterialPageRoute(
        builder: (context) => EnLatiendaRecibido(),
      );
    }






    if (settings.name == OrderDetailsForUsers.id) {
      OrderModel orderModel =OrderModel();
      orderModel = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsForUsers(orderModel:orderModel,),
      );
    }

    if (settings.name == OrderDetailsForDEliveryMen.id) {
      OrderModel orderModel =OrderModel();
      orderModel = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsForDEliveryMen(orderModel:orderModel,),
      );
    }

    if (settings.name == OrderDetailsForAdmin.id) {
      OrderModel orderModel =OrderModel();
     orderModel = settings.arguments as OrderModel;
    return MaterialPageRoute(
    builder: (context) => OrderDetailsForAdmin(orderModel:orderModel,),
    );
    }









    if (settings.name == OrdersdashBoardForAdmins.id) {
      return MaterialPageRoute(
        builder: (context) => OrdersdashBoardForAdmins(),
      );
    }































    if (settings.name == SearchDetailsDeleteDEliveryMenScrn.id) {
      return MaterialPageRoute(
        builder: (context) => SearchDetailsDeleteDEliveryMenScrn(),
      );
    }





    if (settings.name == SearchDetailsUsersScrn.id) {
      return MaterialPageRoute(
        builder: (context) => SearchDetailsUsersScrn(),
      );
    }





    if (settings.name == AddNewDeliveryMan.id) {
      return MaterialPageRoute(
        builder: (context) => AddNewDeliveryMan(),
      );
    }


    if (settings.name == AddNewUser.id) {
      return MaterialPageRoute(
        builder: (context) => AddNewUser(),
      );
    }


    if (settings.name == SearchDetailsAdminByAdmin.id) {
      return MaterialPageRoute(
        builder: (context) => SearchDetailsAdminByAdmin(),
      );
    }











    if (settings.name == AddNewAdmin.id) {
      return MaterialPageRoute(
        builder: (context) => AddNewAdmin(),
      );
    }





    if (settings.name == DeliveryEditPassword.id) {
      return MaterialPageRoute(
        builder: (context) => DeliveryEditPassword(),
      );
    }


    if (settings.name == DeliveryEditAccount.id) {
      return MaterialPageRoute(
        builder: (context) => DeliveryEditAccount(),
      );
    }

    if (settings.name == DeliveryMenProfileScreen .id) {
      return MaterialPageRoute(
        builder: (context) => DeliveryMenProfileScreen(),
      );
    }



    if (settings.name == DeliveryMenDashboard .id) {
      return MaterialPageRoute(
        builder: (context) => DeliveryMenDashboard(),
      );
    }



    if (settings.name == AddAdminForm .id) {
      return MaterialPageRoute(
        builder: (context) => AddAdminForm(),
      );
    }


    if (settings.name == AdminSelectedProductDetails.id) {

      ProductPaginated? productPaginated =  ProductPaginated();
      List<Category>? listOfCategories =[];

      productPaginated  = settings.arguments as ProductPaginated?;

      return MaterialPageRoute(
        builder: (context) => AdminSelectedProductDetails (productPaginated: productPaginated,),
      );
    }



    if (settings.name == AdminAddNewCategoryScreen .id) {
      return MaterialPageRoute(
        builder: (context) => AdminAddNewCategoryScreen(),
      );
    }





    if (settings.name == AdminAddDeleteCategories .id) {
      return MaterialPageRoute(
        builder: (context) => AdminAddDeleteCategories (),
      );
    }






    if (settings.name == ProductStatistics .id) {


      return MaterialPageRoute(
        builder: (context) => ProductStatistics (),
      );
    }





    if (settings.name == AdminEditPassword .id) {


      return MaterialPageRoute(
        builder: (context) => AdminEditPassword (),
      );
    }





    if (settings.name == AdminEditAccount.id) {


      return MaterialPageRoute(
        builder: (context) => AdminEditAccount(),
      );
    }





    if (settings.name == AdminProfileScreen.id) {


      return MaterialPageRoute(
        builder: (context) => AdminProfileScreen(),
      );
    }


    if (settings.name == UserEditPassword.id) {


      return MaterialPageRoute(
        builder: (context) => UserEditPassword(),
      );
    }









    if (settings.name == UserEditAccountScreen.id) {


      return MaterialPageRoute(
        builder: (context) => UserEditAccountScreen(),
      );
    }






    if (settings.name == AdminEditProduct.id) {

            ProductPaginated? product =ProductPaginated();
            List<Category>? listOfCategories =[];

            product  = settings.arguments as ProductPaginated?;
            listOfCategories = settings.arguments as List<Category>? ;

             var data  = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AdminEditProduct(selectedproduct: product,categoryList: listOfCategories,),
      );
    }

    if (settings.name == UserOrdersDetailsScreen.id) {
      var data  = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => UserOrdersDetailsScreen(selectedOrder: data,),
      );
    }


    // if (settings.name == WebPageMercadoPago.id) {
    //   var data  = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => UserOrdersDetailsScreen(selectedOrder: data,),
    //   );
    // }


    if (settings.name == ChannelPage.id) {
      MercadoPagoModelPlaceOrder mercadoPagoModel;

      mercadoPagoModel = settings.arguments as MercadoPagoModelPlaceOrder ;
      return MaterialPageRoute(
        builder: (context) => ChannelPage(mercadoPagoModel: mercadoPagoModel,),
      );
    }




    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }




}

