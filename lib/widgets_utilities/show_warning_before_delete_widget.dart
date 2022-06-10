import 'package:flutter/material.dart';

import '../uploadingImagesAndproducts.dart';

class ShowwarningBeforeDelete extends StatefulWidget {

 final  int id;

  const ShowwarningBeforeDelete({Key? key ,
     required this.id
  }) : super(key: key);

  @override
  _ShowwarningBeforeDeleteState createState() => _ShowwarningBeforeDeleteState();
}

class _ShowwarningBeforeDeleteState extends State<ShowwarningBeforeDelete> {

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
          //  title: Text('Notification'),
          content: Text('Do you really want to delete this product? '),
          actions: [

            ElevatedButton(
                onPressed: () async {
                  String message = await ProductUploadingAndDispalyingFunctions().deleteProduct(widget.id);

                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
                 // showMessage(context , message);
                  setState(() {});

                },
                child: Text('Ok')),
            ElevatedButton(
                onPressed: () async {Navigator.of(context).pop();},
                child: Text('cancel'))
          ],
        );
      }

    }



void showMessage(context ,String message) {
  showDialog(
      context: context,
      builder: (context ) {
        return AlertDialog(
          content: Text(message),
          actions: [

            ElevatedButton(
                onPressed: () async {

                  Navigator.of(context).pop();


                },
                child: Text('Ok')),

          ],
        );
      });
}
