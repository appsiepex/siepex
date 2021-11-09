import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/oficina.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/oficina/oficinaCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemOficina extends StatefulWidget {
  ListagemOficina({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemOficinaState createState() => _ListagemOficinaState();
}

class _ListagemOficinaState extends State<ListagemOficina> {
  List<dynamic> viewOficina = [];
  bool carregou = false;
  getTodasOficinas() async {
    try {
      var oficina =
      jsonDecode((await http.get(Uri.parse(baseUrl + "oficina"))).body);
      print(oficina);
      setState(() {
        viewOficina = oficina;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasOficinas() async {
    Participante.getStorage().then((user) async {
      try {
        var oficina = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/oficina")))
                .body);
        setState(() {
          print(oficina);
          viewOficina = oficina['tbl_geral'];
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
      getTodasOficinas();
    } else {
      print("especifico");
      getMinhasOficinas();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewOficina);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewOficina.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetOficina = [];
      String hr_inicio = '0';
      viewOficina.forEach((oficina) {
        if (oficina['hr_inicio'] != hr_inicio) {
          widgetOficina.add(linhaHora(hora: oficina['hr_inicio']));
          hr_inicio = oficina['hr_inicio'];
        }
        widgetOficina.add(OficinaCard(
          oficina: Oficina().fromJson(oficina),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetOficina,
          ));
    }
  }
}
