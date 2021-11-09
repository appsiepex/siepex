import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/rodas.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/rodasdeconversas/rodasCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemRodas extends StatefulWidget {
  ListagemRodas({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemRodasState createState() => _ListagemRodasState();
}

class _ListagemRodasState extends State<ListagemRodas> {
  List<dynamic> viewRodas = [];
  bool carregou = false;
  getTodasRodas() async {
    try {
      var rodas =
      jsonDecode((await http.get(Uri.parse(baseUrl + "rodas"))).body);
      print(rodas);
      setState(() {
        viewRodas = rodas;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasRodas() async {
    Participante.getStorage().then((user) async {
      try {
        var rodas = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/rodas")))
                .body);
        setState(() {
          print(rodas);
          viewRodas = rodas['tbl_rodasdeconversas'];
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
      getTodasRodas();
    } else {
      print("especifico");
      getMinhasRodas();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewRodas);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewRodas.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetRodas = [];
      String hr_inicio = '0';
      viewRodas.forEach((rodas) {
        if (rodas['hr_inicio'] != hr_inicio) {
          widgetRodas.add(linhaHora(hora: rodas['hr_inicio']));
          hr_inicio = rodas['hr_inicio'];
        }
        widgetRodas.add(RodasCard(
          rodas: Rodas().fromJson(rodas),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetRodas,
          ));
    }
  }
}
