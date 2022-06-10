
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simo_v_7_0_1/apis/add_new_category.dart';
import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
import 'package:simo_v_7_0_1/apis/delete_category.dart';
import 'package:simo_v_7_0_1/apis/get_all_categories.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simo_v_7_0_1/uploadingImagesAndproducts.dart';
import 'package:simo_v_7_0_1/widgets_utilities/admin_functions.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'add_new_category_screen.dart';
import 'admin_profile_screen.dart';
import 'login_screen.dart';

class AdminAddDeleteCategories extends StatefulWidget {
  static const String id = '/adminAddDeleteCategories';
  @override _AdminAddDeleteCategoriesState createState() => _AdminAddDeleteCategoriesState();}

class _AdminAddDeleteCategoriesState extends State<AdminAddDeleteCategories> {
  final scaffoldKeyUnique = GlobalKey<ScaffoldState>();

  final _formKeyAddcategory = GlobalKey<FormState>();
String? categoryvalue;
bool iSLoading = false;
bool   done = false;





func(){

}

  List  data =[];
  @override
  void initState() {
   setState(() {done=true;});
    GetAllCategoriesAdmin().getCategoriesAdmin().then((value){
      setState(() {
        data=value;
        done=false;
      });




    });
    super.initState();
  }



  void showNotificationDialogue(context, String  myString) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Divider(thickness: 2,color: Colors.blue,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(myString,style: TextStyle(fontSize: 18),),
              ),
              Divider(thickness: 2,color: Colors.blue,),
              SizedBox(height: 10,),
            ],
          ),
        ), actions: [
        ElevatedButton(onPressed: () async {
          Navigator.of(context).pop();},
            child: Center(child: Text('Ok'))),
      ],);});}










  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () async {Navigator.of(context).pop();},
                  icon: Icon(Icons.arrow_back, color: Colors.green,),),

              ],),
            Container(decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>AdminAddNewCategoryScreen(),),);
                },

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Añadir una nueva categoría ', style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              ),),


         SizedBox(height: 40,),




             done == true || iSLoading == true ? SpinKitWave(color: Colors.green, size: 50.0,) :

                  Expanded(

                  child: ListView.builder(

                      itemCount:data.length,
                      itemBuilder: (context,int index){
                    return Card(

                      child: ListTile(




                        trailing: IconButton(
                           icon: Icon(Icons.delete,size: 28,color: Colors.red,),
                           onPressed: ()async {
                              setState(() {iSLoading = true;});
                             int selectedIndex = data[index]['id'];
                              String message = await DeleteCategory().deleteOrder(selectedIndex);
                              data = [];
                              List value = await GetAllCategoriesAdmin().getCategoriesAdmin();
                              setState(() {data = value;});
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
                              setState(() {iSLoading =false;});
                            

                           }),
                         
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                            child: Text('${data[index]['nombre_categoria']}',style: TextStyle(fontSize: 20,color: Colors.blueGrey),)),







                      ),
                    );


                  }),
                  ),


                ],),
            ),





    );
  }


}