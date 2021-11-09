import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/circodanca.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/circodanca/circodancaCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemCirco extends StatefulWidget {
  ListagemCirco({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemCircoState createState() => _ListagemCircoState();
}

class _ListagemCircoState extends State<ListagemCirco> {
  List<dynamic> viewCirco = [];
  bool carregou = false;
  getTodosCircos() async {
    try {
      var circo =
      jsonDecode((await http.get(Uri.parse(baseUrl + "circodanca"))).body);
      print(circo);
      setState(() {
        viewCirco = circo;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMeusCircos() async {
    Participante.getStorage().then((user) async {
      try {
        var circo = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/circo")))
                .body);
        setState(() {
          print(circo);
          viewCirco = circo['tbl_circodanca'];
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
      getTodosCircos();
    } else {
      print("especifico");
      getMeusCircos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewCirco);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewCirco.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetCirco = [];
      String hr_inicio = '0';
      viewCirco.forEach((circo) {
        if (circo['hr_inicio'] != hr_inicio) {
          widgetCirco.add(linhaHora(hora: circo['hr_inicio']));
          hr_inicio = circo['hr_inicio'];
        }
        widgetCirco.add(CircoCard(
          circo: Circo().fromJson(circo),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetCirco,
          ));
    }
  }
}
