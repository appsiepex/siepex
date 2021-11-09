import 'package:flutter/material.dart';
import 'package:siepex/src/eventos/musica/musicaView.dart';

class MusicaPage extends StatelessWidget {
  const MusicaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Música"),
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
            child: ListagemMusica()),
      ),
      //),
    );
  }
}
