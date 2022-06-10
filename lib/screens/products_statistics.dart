import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/apis/modify_status.dart';
import 'package:simo_v_7_0_1/providers/admin_get_pedidos_provider.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';

import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/screens/user_profile_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'admin_accounts.dart';
import 'admin_add_new_admins.dart';

import 'admin_inventory.dart';
import 'admin_profile.dart';
import 'admin_profile_screen.dart';
import 'cart_screen.dart';
import 'login_screen.dart';
import 'order_fill_in_form.dart';








class ProductStatistics extends StatefulWidget {
  static const String id = '/productsstatisctics9810937';
  @override
  _ProductStatisticsState createState() => _ProductStatisticsState();
}
class _ProductStatisticsState extends State<ProductStatistics> {
  bool startLogingOut=false;





  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    IconButton(onPressed: () async {
                     Navigator.of(context).pop();},
                      icon: Icon(Icons.arrow_back,color: Colors.green,),
                    ),



                    IconButton(onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>AdminProfileScreen (),
                      ),);},

                      icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
                    ),

                    IconButton(onPressed: () async {
                      setState(() {startLogingOut=true;});
                      bool answer= await LogoutAdminUserDeliveryMen().logOutUser(context);

                      print ('answeer    -------         $answer');
                      if(answer==true){

                        Navigator.pushNamed(context, LoginScreen.id);
                        UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                      } else{
                        UsedWidgets().showNotificationDialogue(context,'Algo salió mal');

                      }

                      setState(() {startLogingOut=false;});

                    }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),

                    ),

                  ],
                ),
              ),

              Divider(thickness: 6,),
              Expanded(
                child: Column(

                    children: <Widget>[
                      UsedWidgets().buildListTile(leadingIcon:Icons.category_outlined,
                        voidCallback: (){},title: 'Categorias',),

                      UsedWidgets().buildListTile(leadingIcon:Icons.shopping_basket_outlined,
                        voidCallback: (){},title: 'Productos',),




                    ]),
              ),
            ],
          ),
        )
    );
  }
}
