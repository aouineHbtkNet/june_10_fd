import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'add_admin.dart';
import 'admin_add_new_admins.dart';
import 'admin_profile_screen.dart';
import 'admin_show_products_edit_delet.dart';
import 'admins/add_new_admin.dart';
import 'admins/add_new_delivery_man.dart';
import 'admins/add_new_user.dart';
import 'admins/options_admins_by_admin.dart';
import 'admins/options_delivery_men_by_admin.dart';
import 'admins/options_users_by_admin.dart';
import 'login_screen.dart';


class AdminManagingAccounts extends StatefulWidget {
  static const String id = '/adminMangingAccounts';

  @override
  State<AdminManagingAccounts> createState() => _AdminManagingAccountsState();
}

class _AdminManagingAccountsState extends State<AdminManagingAccounts> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProviderOne>(context);
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

                      Navigator.of(context).pop();
                    },
                      icon: Icon(Icons.arrow_back,color: Colors.green,),
                    ),
                    IconButton(onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>AdminProfileScreen (),
                      ),);},
                      icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
                    ),
                    IconButton(onPressed: () async {
                      setState(() {});
                      bool answer= await LogoutAdminUserDeliveryMen().logOutAdmin(context);
                      print ('answeer    -------         $answer');
                      if(answer==true){
                        Navigator.pushNamed(context, LoginScreen.id);
                        UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                      } else{
                        UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                      }
                      setState(() {});
                    }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),
                    ),],
                ),
              ),

              Divider(thickness: 6,),

              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cuentas',style: TextStyle(fontSize: 20),),
                  )),
              Divider(thickness: 2,color: Colors.blueGrey,),

              SizedBox(height: 16,),


              Expanded(
                child: ListView(

                  //  shrinkWrap: true,

                    children: <Widget>[

                      UsedWidgets().buildListTile(leadingIcon: Icons.add,
                          voidCallback: (){ Navigator.of(context).pushNamed(AddNewAdmin.id);},
                          title: 'Agregar un nuevo admin'),

                      UsedWidgets().buildListTile(leadingIcon: Icons.add,
                          voidCallback: (){ Navigator.of(context).pushNamed(AddNewDeliveryMan.id);},
                          title: 'Agregar un nuevo domiciliario'),

                      UsedWidgets().buildListTile(leadingIcon: Icons.add,
                          voidCallback: (){ Navigator.of(context).pushNamed(AddNewUser.id);},
                          title: 'Agregar un nuevo cliente'),


                      UsedWidgets().buildListTile(leadingIcon: Icons.read_more,
                          voidCallback: (){Navigator.of(context).pushNamed(SearchDetailsAdminByAdmin.id);},
                          title: 'Administradores'),

                      UsedWidgets().buildListTile(leadingIcon: Icons.read_more,
                          voidCallback: (){Navigator.of(context).pushNamed(SearchDetailsDeleteDEliveryMenScrn.id);},
                          title: ' Domicilarios'),

                      UsedWidgets().buildListTile(leadingIcon: Icons.read_more,
                          voidCallback: (){Navigator.of(context).pushNamed(SearchDetailsUsersScrn.id);},
                          title: ' Clientes'),


















                    ]
                ),
              ),
            ],
          ),
        )
    );
  }
}
