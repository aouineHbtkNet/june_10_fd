import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/widgets_utilities/image_widget.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';


class SelectedProductDetails extends StatefulWidget {
  const SelectedProductDetails({Key? key}) : super(key: key);
  static const String id = '/ selectedProductDetails';
  @override
  _SelectedProductDetailsState createState() => _SelectedProductDetailsState();
}



Widget addtocartWidget(BuildContext context, ProductPaginated product) {

  return ElevatedButton(
    onPressed: () {
      int? qtyOfCurrentItem =context.read<ShoppingCartProvider>().addproductToMap(product);
      Navigator.of(context).pop();
      if (qtyOfCurrentItem! >= 9){
        print('qtyOfCurrentItem${qtyOfCurrentItem}');
        showAlert(context, 'la cantidad maxima de cada producto es 9 articolos');
      }},
    child: Text('Añadir al carrito', style: TextStyle(fontSize: 24,),));}









void showAlert(context, String  myString) {
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







void showstuff(context, var myString) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: myString == '' || myString == null
              ? ClipRect(
                  child: Image.asset('assets/iconPlaceholder12.png'),
                )
              : ClipRect(
                  child: Image.network(
                      'https://hbtknet.com/storage/notes/$myString'),
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

var selectedProduct;
int quantityLocal = 1;

class _SelectedProductDetailsState extends State<SelectedProductDetails> {
  @override
  Widget build(BuildContext context) {
    selectedProduct = ModalRoute.of(context)!.settings.arguments as ProductPaginated;

    var mymap = context.watch<ShoppingCartProvider>().collectionMap;


   return selectedProduct == null
        ? Text('Loading')
        : Scaffold(
            body: SafeArea(
              child: Column(
             mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,


                children: [

               Expanded(
                flex: 1,

                child: PopUpMenuWidgetUsers(putArrow: true, showcart: false,
                  callbackArrow: () {Navigator.of(context).pop();},
                ),
              ),

              Expanded(
                flex: 10,

                 child: Stack(
                   alignment: Alignment.topCenter,
                    children: [





                      
                      Container(
                        height:400,
                        child: ImagewidgetNoButton(networkImageUrl: selectedProduct.foto_producto,),
                      ),





                  Positioned(child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: addtocartWidget(context, selectedProduct),
                  ), ),












                  DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      maxChildSize: 0.8,
                      minChildSize: 0.4,
                      builder:(context,controller)=>Container(
                      color: Colors.white,
                      child: ListView(
                      controller: controller,
                     children: [








                       UsedWidgets().buildWidggetProductDetails(
                         title: 'Categoia :',data:'${selectedProduct.category}',),


                       UsedWidgets().buildWidggetProductDetails(
                         title: 'Marca :',data:'${selectedProduct.marca}',),


                       UsedWidgets().buildWidggetProductDetails(
                         title: 'Nombre :',data:'${selectedProduct.nombre_producto}'),
                       UsedWidgets().buildWidggetProductDetails(
                           title: 'Contenido :',data:'${selectedProduct.contenido}'),
                       UsedWidgets().buildWidggetProductDetails(
                           title: 'Precio :',data:'${selectedProduct.precio_ahora}\$'),

                       UsedWidgets().buildWidggetProductDetails(
                           title: 'Precio Antes :',data:'${selectedProduct.precio_anterior}\$'),
                       UsedWidgets().buildWidggetProductDetails(
                           title: 'Descuento :',data:'${selectedProduct.porciento_de_descuento}\%'),

                       UsedWidgets().buildWidggetProductDetails(
                           title: ' Descripción :',data:'${selectedProduct.descripcion}'),


                     ],
                    ),
                  )),

                  ],
                ),
              ),

            ]),
          ));
  }
}
