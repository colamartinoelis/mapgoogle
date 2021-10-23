import 'package:flutter/material.dart';

class Pannello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.all(16),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: 60,
              height: 4,
              decoration: new BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: new BorderRadius.circular(4)),
            ),
            tipoTrasporto(
                assetImage: "asset/uber-normal.png",
                tipo: 'UberX'
                    '',
                time: "12.00",
                price: "\$10.50"),
            tipoTrasporto(
                assetImage: "asset/uber-pop.jpg",
                tipo: 'Pool'
                    '',
                time: "12.10",
                price: "\$7.50"),
            new Divider(
              thickness: 1,
            ),
            new SizedBox(
              height: 16,
            ),
            new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Pay at station or "
                      "at "
                      "transit services"),
                  new SizedBox(
                    height: 10,
                  ),
                  pulsantePrenotazione(),
                ]),
          ],
        ));
  }
}

Widget tipoTrasporto({
  @required String assetImage,
  @required String tipo,
  @required String time,
  @required String price,
}) =>
    new ListTile(
        onTap: () {
          return print("prova");
        },
        leading: new Image.asset(
          assetImage,
          width: 60,
        ),
        title: new Text(
          tipo,
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: new Text(time),
        trailing: new Text(price));

Widget pulsantePrenotazione() => new MaterialButton(
      onPressed: () {
        return print("prova Pulsante");
      },
      minWidth: double.infinity,
      color: Colors.black,
      textColor: Colors.white,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5)),
      child: new Text('BOOK RIDE!'),
    );
