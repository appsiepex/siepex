import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/danca.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/danca/dancaCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemDanca extends StatefulWidget {
  ListagemDanca({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemDancaState createState() => _ListagemDancaState();
}

class _ListagemDancaState extends State<ListagemDanca> {
  List<dynamic> viewDanca = [];
  bool carregou = false;
  getTodasDancas() async {
    try {
      var danca =
      jsonDecode((await http.get(Uri.parse(baseUrl + "danca"))).body);
      print(danca);
      setState(() {
        viewDanca = danca;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasDancas() async {
    Participante.getStorage().then((user) async {
      try {
        var danca = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/danca")))
                .body);
        setState(() {
          print(danca);
          viewDanca = danca['tbl_danca'];
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
      getTodasDancas();
    } else {
      print("especifico");
      getMinhasDancas();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewDanca);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewDanca.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetDanca = [];
      String hr_inicio = '0';
      viewDanca.forEach((danca) {
        if (danca['hr_inicio'] != hr_inicio) {
          widgetDanca.add(linhaHora(hora: danca['hr_inicio']));
          hr_inicio = danca['hr_inicio'];
        }
        widgetDanca.add(DancaCard(
          danca: Danca().fromJson(danca),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetDanca,
          ));
    }
  }
}
