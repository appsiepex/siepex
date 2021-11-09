import 'package:flutter/material.dart';
import 'package:siepex/src/eventos/circodanca/circodancaView.dart';

class CircoDancaPage extends StatelessWidget {
  const CircoDancaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Circo Dança"),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       print('pesquisa');
          //     },
          //   )
          // ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/img/arte_uergs/Background_App_Siepex.png'),
                    fit: BoxFit.cover)),
            child: ListagemCirco()),
      ),
      //),
    );
  }
}
