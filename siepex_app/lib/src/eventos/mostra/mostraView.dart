import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/mostra.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/mostra/mostraCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemMostra extends StatefulWidget {
  ListagemMostra({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemMostraState createState() => _ListagemMostraState();
}

class _ListagemMostraState extends State<ListagemMostra> {
  List<dynamic> viewMostra = [];
  bool carregou = false;
  getTodasMostra() async {
    try {
      var mostra =
      jsonDecode((await http.get(Uri.parse(baseUrl + "mostra"))).body);
      print(mostra);
      setState(() {
        viewMostra = mostra;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasMostra() async {
    Participante.getStorage().then((user) async {
      try {
        var mostra = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/mostra")))
                .body);
        setState(() {
          print(mostra);
          viewMostra = mostra['tbl_mostra'];
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
      getTodasMostra();
    } else {
      print("especifico");
      getMinhasMostra();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewMostra);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewMostra.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetMostra = [];
      String hr_inicio = '0';
      viewMostra.forEach((mostra) {
        if (mostra['hr_inicio'] != hr_inicio) {
          widgetMostra.add(linhaHora(hora: mostra['hr_inicio']));
          hr_inicio = mostra['hr_inicio'];
        }
        widgetMostra.add(MostraCard(
          mostra: Mostra().fromJson(mostra),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetMostra,
          ));
    }
  }
}
