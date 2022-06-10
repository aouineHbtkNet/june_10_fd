import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/order_fill_in_form.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';

import 'image_for_cart_screen.dart';
import 'image_widget.dart';

class UsedWidgets {






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






























  void showscreenShot
      (context, Widget  widget) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Divider(thickness: 2,color: Colors.blue,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: widget,
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






















  Widget UserAccountScreen({
    String? title,
    String? data,

  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),

            ],
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                data ?? '',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }


























  Widget buildDropDownButtonTypeOftaxl(
      {
        required String? valueParam,
        required String? Function(String? value) onChanged,
        final List? list,
        final String? label

      }) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),

        value: valueParam ,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value["id"].toString(),
          child: Text(value["nombre_categoria"].toString()),)).toList());
  }

























  void calculationDiscountAndtaxes(
  {
    double currentPrice = 0.0 ,
    double previousPrice = 0.0 ,
    double discountpercentage = 0.0 ,
    double discountvalue = 0.0 ,
    double taxValue = 0.0 ,
    double priceBase = 0.0 ,


}

      ) {

    // double calculateDiscountPercentage({required double previousPrice ,required double currentprice}) {
    //   return ((previousPrice - currentPrice) / previousPrice) * 100;
    // }


    double calculateDiscountPercentage() {
      return ((previousPrice - currentPrice) / previousPrice) * 100;
    }

    double calculateDiscountvalue({required double previousPrice ,required double currentprice}) {
      return previousPrice - currentPrice;
    }



    double calculateTaxValue({ required double currentPrice, required double taxPercentage}) {
      return currentPrice * (taxPercentage / 100);
    }


    double calculatePriceBase( {  required double currentPrice, required double  resultOfcalculateTaxValueFunction} ) {
      return currentPrice - resultOfcalculateTaxValueFunction;}


  }































  Widget buildDropDownSearch(
      {
        String ? conditionVar,
        required String? valueParam,
        required String? Function(String? value) onChanged,
        final List? list,
        final String? label


      }) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
         prefixIcon:
         conditionVar==null?
         IconButton(icon: Icon(Icons.category_rounded,color: Colors.green,size: 30,),
           onPressed: () { print('testing '); },)
             :
         IconButton(icon: Icon(Icons.clear,color: Colors.red,size: 30,),
           onPressed: () {
             conditionVar='';
             print('testing ');
             },),


          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),

        value: valueParam ,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Text(value.nombre_categoria.toString()),)).toList());
  }













  Widget buildDropDownButtonApiList(
      {
        required String? valueParam,
        required String? Function(String? value) onChanged,
        final List? list,
        final String? label


      }) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),

        value: valueParam ,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Text(value.nombre_categoria.toString()),)).toList());
  }




  Widget buildDropDownButtonApiListNoModel(
      {

        required String? valueParam,
        required String? Function(String? value) onChanged,
        final List? list,
        final String? label


      }) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        value: valueParam ,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value['1'].toString(),
          child: Text(value["nombre_categoria"].toString()),)).toList());
  }





































  Widget simpleTitleDataWidget(

  {
    required String title,
    required String data,

}

      ){

    return Column(children: [

      Text(title,style: TextStyle(fontSize: 18 ,fontFamily: 'Arkaya',color: Colors.blueGrey),),
      Text(data,style: TextStyle(fontSize: 24,fontFamily: 'OpenLight'),),


    ],);
  }







  Widget orderDetailsScreenHeading(
  {
    required double sizeTitle,
    required double sizeData,
    required String fontfamilyTitle,
    required String fontFamilyData,

    required String dateData,
    required String orderIdData  ,
    required String serialNumberdata ,
    required String totalPriceData ,
    required String totalPriceBaseData ,
    required String totalPriceTaxesData ,
    required String totalPriceDescountData ,
    //required String totalDelosProductos ,



  }

      ){

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.blueGrey,width: 2)

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fecha',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(dateData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),

              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Numero',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(orderIdData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),

              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // trucking_number
                Text('Serial',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(serialNumberdata,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),
              ],),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // trucking_number
                Text('Precio total',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(totalPriceData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData,color: Colors.blue),),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // trucking_number
                Text('Precio Base',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(totalPriceBaseData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),
              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // trucking_number
                Text('Valor de impuestos ',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(totalPriceTaxesData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),
              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // trucking_number
                Text('Valor de descuentos',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
                Text(totalPriceDescountData,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),
              ],),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // trucking_number
            //     Text('Cantidad de productos',style: TextStyle(fontSize: sizeTitle ,fontFamily: fontfamilyTitle),),
            //     Text(totalDelosProductos,style: TextStyle(fontSize: sizeData,fontFamily: fontFamilyData),),
            //   ],),








          ],





          ),
        ),

      ),
    );
  }














  Widget emptyCart(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [

               Text(' El carrito está vacío',style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
               Icon(Icons.shopping_cart_outlined,size: 60,color: Colors.yellow,),

              SizedBox(height: 20,),


              GestureDetector(
                onTap: (){ Navigator.of(context).pop();},
                child:Icon(
                  Icons.arrow_back,
                  size: 60,
                  color: Colors.green,
                ) ,)

            ],
          ),
        ),


      ],
    );
  }

  void showstuff(context, var myString) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: myString == null
                ? ClipRect(
                    child: Image.asset('assets/iconPlaceholder12.png'),
                  )
                : ClipRect(
                    child: Image.network(
                        'http://192.168.1.22/api_v_1/storage/app/public/notes/$myString'),
                  ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Center(child: Text('Ok')))
            ],
          );
        });
  }


















  Widget cartandCounterWidget(
      {required
      BuildContext context, VoidCallback? callback}) {

    return GestureDetector(
      onTap: callback,
      child: Container(
         decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
        Radius.circular(10.0) //                 <--- border radius here
    ),

         ),



        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
            Icon(Icons.shopping_cart_outlined,size: 28,),SizedBox(width: 6,),
            Text(
              '${context.watch<ShoppingCartProvider>().inCartItemsCount}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),

          ],),
        ),

    ));

  }

















  static Widget buildSpalshScreen() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
          SizedBox(
            height: 40,
          ),
          Text(
            'Loading',
            style: TextStyle(fontSize: 40.0, color: Colors.green),
          )
        ],
      ),
    );
  }

  static Widget spalshScreen = buildSpalshScreen();





  Widget buildDropDownButtonFixedList(
      {
         final String? valueInitial,
      required String? Function(String? value) onChanged,
      final List? list,
      final String? label}) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
       value: valueInitial,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es obligatorio';
          } else {
            return null;
          }
        },
        items: list!
            .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),
                ))
            .toList());
  }










  Widget buildTextFormWidgetForText({
    required String? Function(String? value) onChanged,
    String? valueInitial,
    String? label,
  }) {
    return TextFormField(
      initialValue: valueInitial,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }







  Widget testWidgetEmbtyEnabled({
    required String? Function(String? value) onChanged,
    String? valueInitial,
    String? label,
  }) {
    return TextFormField(
      initialValue: valueInitial,
      onChanged: onChanged,
      validator: (value) {},
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }






















  // RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');

  String? validateDouble(String? value) {
    String pattern =r'\d*\.?\d+';
    RegExp regex = RegExp(pattern);
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
   else  if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }



















  Widget buildTextFormWidgetForDoubleNoInitial({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,
      initialValue: null,

      validator:(String? value) {
           String pattern =r'\d*\.?\d+';
            RegExp regex = RegExp(pattern);


            if (value == null || value.trim().isEmpty) {
             return 'Este campo es obligatorio';
           }
            else if (!regex.hasMatch(value))
                 { return 'Ingresa formato valido Ex: 20.00';}
            else
                 return null;
                   },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

        ),
      ),
    );
  }




  Widget emailValidation({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {


        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';}
        else if (value.isEmpty || !value.contains('@' )) {return "Entrada invalida.Ex:example@example.com";}
        else if (value.isEmpty || !value.contains('.' )) {return "Entrada invalida.Ex:example@example.com";}
        else {return null;}},
      decoration: InputDecoration(
        label: Text(label ?? '', style: TextStyle(fontSize: 20, color: Colors.blue),
        ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),);
  }
  Widget passwordValidation({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      obscureText: true,
      controller: textEditingController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';}
       // else if (value.isEmpty || value.length<8) {return "La contraseña debe tener más de 8 caracteres";}
        else {return null;}},
      decoration: InputDecoration(
        label: Text(label ?? '', style: TextStyle(fontSize: 20, color: Colors.blue),
        ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),);
  }



  Widget doubleValidation({
    required TextEditingController textEditingController,
    String? label,
  }) {
      return TextFormField(
      controller: textEditingController,
      validator: (value) {
              String pattern =r'^[0-9]*[\.]?[0-9]*$';
              RegExp regex = RegExp(pattern);
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';}
        else if (!regex.hasMatch(value))
              { return 'El valor no es valido ';}
        else {return null;}},
      decoration: InputDecoration(
        label: Text(label ?? '', style: TextStyle(fontSize: 20, color: Colors.blue),
        ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),);
  }




  Widget buildTextFormWidgetForDoubleWithInitial({
    String? valueInitial,
    required String? Function(String? value) onChanged,
    String? label,
  }) {

    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    return TextFormField(
      initialValue:valueInitial ,
      onSaved: onChanged,


      validator:(String? value) {


        bool isValid = isNumeric(value!);
        String pattern =r'^[0-9]+[\.]?[0-9]+$';
        RegExp regex = RegExp(pattern);



        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';}

        else if (!regex.hasMatch(value))
        { return 'El valor no es valido from regex';}


        else if (!isValid)
        { return 'El valor no es valido from isNumeric ';}

        else
          return null;
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }














  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
     if (value == null || value.isEmpty || !regex.hasMatch(value))

      return 'Enter a valid email address';
    else
      return null;
  }




  Widget buildTextFormWidgetForEmailNoInitial({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,
     // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validateEmail,
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }



















  Widget userEditInfoProfile({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,


      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }


















  Widget userinfofielsEmtyenabled({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,


      validator: (value) {},
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }










  Widget RegDoubleNum({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
      controller: textEditingController,


      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }


















  Widget buildTextFormWidgetForTextNoInitial({
    required TextEditingController textEditingController,
    String? label,
  }) {
    return TextFormField(
     controller: textEditingController,
      validator: (value) {
       if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';}
        else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }









  Widget buildTextFormWidgetForTextWithInitialValue({
    String? valueInitial,
    required String? Function(String? value) onChanged,
    String? label,}) {
    return TextFormField(

    onChanged:onChanged ,
      initialValue: valueInitial,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';} else {
          return null;}},
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }





  Widget buildTextFormWidgetForTextWithInitialValuEditPage({
    required Key key,
    String? valueInitial,
    required String? Function(String? value) onChanged,
    String? label,}) {
    return TextFormField(

        key:key,
      onSaved:onChanged ,
      initialValue: valueInitial,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';} else {
          return null;}},
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

























  Widget buildTextFormWidgetForEmail(
      {required String? Function(String? value) onChanged,
      String? valueInitial,
      String? label}) {
    return TextFormField(
      initialValue: valueInitial,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget buildTextFormWidgetForPhone(
      {required String? Function(String? value) onChanged,
      String? valueInitial,
      String? label}) {
    return TextFormField(
      initialValue: valueInitial,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget buildTextFormWidgetForPassword(
      {required String? Function(String? value) onChanged,
      String? valueInitial,
      String? label}) {
    return TextFormField(
      initialValue: valueInitial,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Este campo es obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget addtocartWidget(BuildContext context, ProductPaginated product) {

    // var mapOfproducts = context.watch<ShoppingCartProvider>().collectionMap;
    return InkWell(
      onTap: () {

        // if(mapOfproducts[product]<9){

          context.read<ShoppingCartProvider>().addproductToMap(product);
       //else{ print (' ===================It is more than 9============================');}

        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          decoration: BoxDecoration(
            // color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 2,color: Colors.blueGrey)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Añadir al carrito',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                      ),
                ),
                Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.blueGrey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget OpciocesPagoWidget({
    required BuildContext context,
    void Function()? callbackEnLinea,
    void Function()? callbackdataFono,
    void Function()? callbackefectivo,
  }) {
    return Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0)),
        child: ExpansionTile(
            title: Text(
              'Escoger una de las opciones ',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            children: [
              ListTile(
                title: Text(
                  'Pagar en linea',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
                onTap: callbackEnLinea,
              ),
              ListTile(
                  title: Text(
                    'Pagar con datafono',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  onTap: callbackdataFono),
              ListTile(
                  title: Text(
                    'Pagar en effectivo',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  onTap: callbackefectivo),
            ]));
  }

  Widget OpciocesEntregaWidget(
      {required BuildContext context,
      void Function()? callbackDomicilio,
      void Function()? callbackTienda}) {
    return Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0)),
        child: ExpansionTile(
            title: Text(
              'Escoger una de las opciones ',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            children: [
              ListTile(
                title: Text(
                  'Engtrega a domicilio',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
                onTap: callbackDomicilio,
              ),
              ListTile(
                  title: Text(
                    'Entraga a la tienda',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  onTap: callbackTienda),

            ]));
  }

  Widget totalaPagarWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total a pagar ',
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            Text(
              '${context.watch<ShoppingCartProvider>().productPriceTotal.toString()}\$',
              style: TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }




  //------------------------------------------------------pedir un un orden start ==========
  Widget placeOrderwidget(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(OrderFillInFormWithOptions.id);
          },
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            primary: Colors.green,
            onPrimary: Colors.black,
          ),
          child: Text(
            'Pedir un orden',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
  //------------------------------------------------------pedir un un orden end ==========
  Widget buildListTileForTitle(
      {IconData? leadingIcon, VoidCallback? voidCallback, String? title ,String? trailing}) {
    return ListTile(
      onTap: voidCallback,
      leading: Icon(
        leadingIcon,
        color: Colors.amber,size: 32,
      ),
      title: Text(
        title!,
        style: TextStyle(
            fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
      trailing: Text(trailing??'',style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),),
    );
  }




  Widget buildListTile(
      {IconData? leadingIcon, VoidCallback? voidCallback, String? title ,String? trailing}) {
    return ListTile(
      onTap: voidCallback,
      leading: Icon(
        leadingIcon,
        color: Colors.amberAccent,
      ),
      title: Text(
        title!,
        style: TextStyle(
            fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
      trailing: Text(trailing??'',style: TextStyle(fontSize: 28,color: Colors.blue,fontWeight: FontWeight.bold),),
    );
  }





  Widget buildListTileForDuration(
      {IconData? leadingIcon, VoidCallback? voidCallback, String? title ,String? trailing}) {
    return ListTile(
      onTap: voidCallback,
      leading: Icon(
        leadingIcon,
        color: Colors.amberAccent,
      ),
      title: Text(
        title!,
        style: TextStyle(
            fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
      trailing: Text(trailing??'',style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold),),
    );
  }














  Widget buildRowNoSpaceScrollable({
    required String title,
    required String data,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          Text(
            data,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }




  Widget simpletitleDataPair(){


    return Column(children: [


    ],);


  }















  Widget buildRowSpaceBetween({
    String? title,
    String? data,
    IconData? icon,
    VoidCallback? callback,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title ?? '',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: callback,
                icon: Icon(
                  icon,
                  size: 28,
                  color: Colors.green,
                ),
              )
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                data ?? '',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
















  Widget buildWidggetProductDetails({
    String? title,
    String? data,


  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            color: Colors.grey,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),


          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                data ?? '',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }


















  Widget buildSelectedProduct({
    String? title,
    String? data,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontFamily: 'openlight'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                data ?? '',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar({required Function(String? value) callback}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: callback,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Buscar',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

Widget buildplusMinusbtn(BuildContext context, ProductPaginated product, int quantity) {
  return Row(
    children: [
      InkWell(
          onTap: () {
            context.read<ShoppingCartProvider>().decreaseProductQty(product);
          },
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: 16,
          )),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), color: Colors.white),
        child: Text(
          quantity.toString(),
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      InkWell(
          onTap: () {
            context.read<ShoppingCartProvider>().addproductToMap(product);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          )),
    ],
  );
}

class cartproductCard extends StatelessWidget {
  final ProductPaginated product;
  final int quantity;
  final int index;

  const cartproductCard(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [

        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey,width: 2)),

            child: ImagewidgetForCartScreen(
              networkImageUrl: product.foto_producto,
            ),
          ),
        ),


SizedBox(width: 10,),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey,width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.nombre_producto.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  Text(
                    '${context.watch<ShoppingCartProvider>().productpricesubTotal[index]}\$ X'
                        ' ${context.watch<ShoppingCartProvider>().inCartItemsList[index]}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),










               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 IconButton(
                   onPressed: () {
                     context
                         .read<ShoppingCartProvider>()
                         .decreaseProductQty(product);
                   },
                   icon: Icon(Icons.remove),
                 ),


                 Text(
                   quantity.toString(),
                   style: TextStyle(color: Colors.black, fontSize: 16),
                 ),





                 IconButton(
                   onPressed: () {
                     context.read<ShoppingCartProvider>().increaseQty(product);
                   },
                   icon: Icon(Icons.add),
                 ),


                 IconButton(
                   onPressed: () {
                     context.read<ShoppingCartProvider>().deleteFromMap(product);
                   },
                   icon: Icon(
                     Icons.clear,
                     color: Colors.red,
                     size: 30,
                   ),
                 ),

               ],)



                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}







class CartTotals extends StatelessWidget {
  const CartTotals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [



              buildTotalbars(
                title: 'Total a pagar',
                value: '${context
                    .watch<ShoppingCartProvider>()
                    .productPriceTotal} \$' ,
                color: Colors.blue,
                fontwieght: FontWeight.bold,
              ),




              buildTotalbars(
                title: 'Precio sin impuestos',
                value: '${context.watch<ShoppingCartProvider>().productPrecioSinImpuestoTotal}\$',
              ),



              buildTotalbars(
                title: 'Valor de impuestos',
                value: '${context.watch<ShoppingCartProvider>().productValorImpuestoTotal}\$',
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class buildTotalbars extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  final FontWeight? fontwieght;
  const buildTotalbars(
      {Key? key,
      required this.title,
      required this.value,
      this.color,
      this.fontwieght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: fontwieght,
          ),
        )
      ],
    );
  }
}


