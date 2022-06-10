import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/screens/admin_add_products.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/screens/products_statistics.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_app_bar.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'admin_profile_screen.dart';
import 'admin_show_products_edit_delet.dart';
import 'anadir_borrar_categorias_screen.dart';
import 'login_screen.dart';
class AdminInventory extends StatefulWidget {
  static const String id = '/admininventory';

  @override
  State<AdminInventory> createState() => _AdminInventoryState();
}



bool startLogingOut=false;
class _AdminInventoryState extends State<AdminInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[



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
                        setState(() {startLogingOut=true;});
                        bool answer= await LogoutAdminUserDeliveryMen().logOutAdmin(context);
                        print ('answeer    -------         $answer');
                        if(answer==true){
                          Navigator.pushNamed(context, LoginScreen.id);
                          UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                        } else{
                          UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                        }
                        setState(() {startLogingOut=false;});
                      }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),
                      ),],
                  ),
                ),

                Divider(thickness: 6,),

                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Inventario',style: TextStyle(fontSize: 20),),
                    )),
                Divider(thickness: 2,color: Colors.blueGrey,),

                UsedWidgets().buildListTile(leadingIcon: Icons.add,
                    voidCallback: (){Navigator.pushNamed(context, AdminAddProduct.id);},
                    title: 'Añadir un producto nuevo'),



                UsedWidgets().buildListTile(leadingIcon: Icons.edit,
                    voidCallback: (){Navigator.pushNamed(context, AdminShowProductsEditDelete.id);},
                    title: 'Editar y borrar productos'),


                UsedWidgets().buildListTile(leadingIcon: Icons.edit,
                    voidCallback: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>AdminAddDeleteCategories (),
                      ),);},
                    title: 'Añadir y borrar  categorias'),






              ]
          ),
        )
    );
  }
}
