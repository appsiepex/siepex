import 'package:flutter/material.dart';
import 'package:siepex/utils/percentage_helper.dart';

class GridItem {
  String nome;
  String rota;
  IconData icone;
  GridItem(this.nome, this.rota, this.icone);
}

Widget itemButton(GridItem item, BuildContext context,
    {bool expanded = true, Future<dynamic> func(), bool function = false}) {
  Widget retorno = FlatButton(
    onPressed: () {
      if (function) {
        func();
      } else {
        Navigator.pushNamed(context, item.rota);
      }
    },
    child: Container(
        height: PercentageHelper.height(15, context),
        width: PercentageHelper.width(24, context),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Color(0xFF006133), spreadRadius: 0.8, blurRadius: 2)
            ],
            // border: Border.all(color: Colors.black),
            color: Color(613300),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.icone,
              size: 70,
              color: Colors.white,
              // semanticLabel: 'fjhdjkfhdjkfhjk',
            ),
            Text(
              item.nome,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
              softWrap: true,
            )
          ],
        )),
  );
  if (expanded) {
    return Expanded(
      child: retorno,
      flex: 1,
    );
  } else {
    return retorno;
  }
}

Widget itemButtonPersonalizado(GridItem item, BuildContext context,
    {bool expanded = true, Future<dynamic> func(), bool function = false}) {
  Widget retorno = FlatButton(
    onPressed: () {
      if (function) {
        func();
      } else {
        Navigator.pushNamed(context, item.rota);
      }
    },
    padding: const EdgeInsets.all(16),
    child: Container(
        height: PercentageHelper.height(15, context),
        width: PercentageHelper.width(75, context),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black54, spreadRadius: 0.8, blurRadius: 2)
            ],
            color: Color(613300),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.icone,
              size: 70,
              color: Colors.white,
            ),
            Text(
              item.nome,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
              softWrap: true,
            )
          ],
        )),
  );
  if (expanded) {
    return Expanded(
      child: retorno,
      flex: 1,
    );
  } else {
    return retorno;
  }
}
