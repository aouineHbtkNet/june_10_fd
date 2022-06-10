import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/providers/shared_preferences_provider.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/cart_screen.dart';
import 'package:simo_v_7_0_1/screens/pagar_ahora_enLinea.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_admins.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'package:simo_v_7_0_1/widgets_utilities/statefulWidget_textFormField.dart';

import 'admin_dash_board.dart';

class AdminNameAndName extends StatefulWidget {
  static const String id = '/olij8763427';
  @override
  State<AdminNameAndName> createState() => _AdminNameAndNameState();
}
class _AdminNameAndNameState extends State<AdminNameAndName> {
  String? valueX;
  final _formX = GlobalKey<FormState>();
  String? table;
  int? id;
  String? name;
  String? email;
  String? mobilePhone;
  String? fixedPhone;
  String? address;
  String? identificationNumber;

  func() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    table =  await prefs.getString(Constants.USER_TABLE_KEY);
    id =await prefs.getInt(Constants.USER_ID_KEY);
    name =await prefs.getString(Constants.USER_NAME_KEY);
    email =await prefs.getString(Constants.USER_EMAIL_KEY);
    mobilePhone =await prefs.getString(Constants.USER_MOBILE_PHONE_KEY);
    fixedPhone  =await prefs.getString(Constants.USER_FIXED_PHONE_KEY);
    address=await prefs.getString(Constants.USER_ADDRESS_KEY);
    identificationNumber=await prefs.getString(Constants.USER_IDENTIFICATION_NUMBER_KEY);
    setState(()  {
    });
  }
  @override
  void initState() {
    func();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    print('Noooooooooooooooooooooooooooooooooooooooooooooooooo');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PopUpMenuWidgetAdmins(putArrow: true,
                  callbackArrow: (){Navigator.of(context).pushNamedAndRemoveUntil(AdminDashBoard .id,
                            (Route<dynamic> route) => false);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(title: 'ID ', data: id.toString(),callback: (){}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(title: 'Nombre :', data:name,icon: Icons.edit,callback: (){
                  Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(title: 'Email :', data: email,icon: Icons.edit,callback: (){
                  Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                UsedWidgets().buildRowSpaceBetween(title: 'celular :', data:mobilePhone,icon: Icons.edit,callback: (){
                  Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(title: 'Telefono fijo :', data:fixedPhone,icon: Icons.edit,callback: (){
                  Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(
                    title: 'Dirección :',data:address, icon: Icons.edit,callback: (){
                  Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(
                    title: 'Numero de identificaion :',data:identificationNumber,
                    icon: Icons.edit,callback: (){Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
                SizedBox(height: 20,),
                UsedWidgets().buildRowSpaceBetween(title: 'Cambiar tu  contraseña',icon: Icons.edit,
                    callback: (){Navigator.of(context).pushNamed(PagarAhoraEnLinea.id);}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
