import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  String text;
  CustomDialog({required this.text});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 178, 227, 255),
      actions: [
        SizedBox(height: 25.0,),
        Center(
          child: Text(
            "Congratulations !",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0,),
        Center(child: Text(widget.text, style: TextStyle(fontSize:20.0),)),
        SizedBox(height: 10.0,),
        InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    height:50.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(228, 6, 164, 255),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "Play Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ],

      // title: Text("Ma boîte de dialogue personnalisée"),
      // content: Text("Contenu de la boîte de dialogue personnalisée"),
      // actions: <Widget>[
      //   TextButton(
      //     child: Text("Fermer"),
      //     onPressed: () {
      //       Navigator.of(context).pop(); // Ferme la boîte de dialogue
      //     },
      //   ),
      //   // Ajoutez d'autres actions si nécessaire
      // ],
    );
  }
}
