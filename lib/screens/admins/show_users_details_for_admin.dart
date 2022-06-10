import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/get_user_info.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'change_pswrd_delivery_man_by_admin.dart';
import 'edit_delivery_men_by_admin.dart';



class UsersProfileScreenByAdmin extends StatefulWidget {
  static const String id = '/UsersProfileScreenByAdmin';


  int? selectedId;
  UsersProfileScreenByAdmin({this.selectedId});

  @override
  State<UsersProfileScreenByAdmin> createState() => _UsersProfileScreenByAdminState();
}

class _UsersProfileScreenByAdminState extends State<UsersProfileScreenByAdmin> {
  UserModel? userModel;
  @override
  void initState() {
    GetUserOrAdminInfo().getUserInfoByAdmin(widget.selectedId).then((value){
      setState(() {userModel = value;});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () async {
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.arrow_back,),),

                    ],
                  ),
                ),



                SizedBox(height: 20,),

                userModel==null?SpinKitWave(color: Colors.green, size: 50.0,): Container(child: Column(
                  children: [

                    Divider(thickness: 4,color: Colors.blueGrey,),
                    SingleChildScrollView( scrollDirection:Axis.horizontal,

                        child: Text('Detalles : ${userModel?.name}',style: TextStyle(fontSize: 20,color: Colors.blueGrey),)),
                    Divider(thickness: 4,color: Colors.blueGrey,),
                    UsedWidgets().UserAccountScreen(title: 'Nombre :', data:userModel?.name),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Nombre de usuario  ( tu email ):', data:userModel?.email,),
                    SizedBox(height:20 ,),
                    UsedWidgets().UserAccountScreen(title: 'celular :', data:userModel?.mobilePhone,),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Telefono fijo :', data:userModel?.fixedPhone),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'Dirección :',data:userModel?.address,),
                    SizedBox(height: 20,),
                    UsedWidgets().UserAccountScreen(title: 'N.de identificaion :',data:userModel?.identificationId,),
                    SizedBox(height: 20,),
                    Divider(thickness: 4,color: Colors.blueGrey,),

                  ],

                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}