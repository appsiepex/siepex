import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/musica.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/musica/musicaCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemMusica extends StatefulWidget {
  ListagemMusica({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemMusicaState createState() => _ListagemMusicaState();
}

class _ListagemMusicaState extends State<ListagemMusica> {
  List<dynamic> viewMusica = [];
  bool carregou = false;
  getTodasMusicas() async {
    try {
      var musica =
      jsonDecode((await http.get(Uri.parse(baseUrl + "musica"))).body);
      print(musica);
      setState(() {
        viewMusica = musica;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasMusicas() async {
    Participante.getStorage().then((user) async {
      try {
        var musica = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/musica")))
                .body);
        setState(() {
          print(musica);
          viewMusica = musica['tbl_musica'];
        });
      } catch (e) {
        print("erro");
        print(e);
      } finally {
        setState(() {
          carregou = true;
        });
      }
    });
  }

  @override
  void initState() {
    if (widget.total) {
      print("geral");
      getTodasMusicas();
    } else {
      print("especifico");
      getMinhasMusicas();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewMusica);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewMusica.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetMusica = [];
      String hr_inicio = '0';
      viewMusica.forEach((musica) {
        if (musica['hr_inicio'] != hr_inicio) {
          widgetMusica.add(linhaHora(hora: musica['hr_inicio']));
          hr_inicio = musica['hr_inicio'];
        }
        widgetMusica.add(MusicaCard(
          musica: Musica().fromJson(musica),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetMusica,
          ));
    }
  }
}
