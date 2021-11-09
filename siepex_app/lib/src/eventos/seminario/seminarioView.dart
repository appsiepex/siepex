import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/seminario.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/seminario/seminarioCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemSeminario extends StatefulWidget {
  ListagemSeminario({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemSeminarioState createState() => _ListagemSeminarioState();
}

class _ListagemSeminarioState extends State<ListagemSeminario> {
  List<dynamic> viewSeminario = [];
  bool carregou = false;
  getTodosSeminarios() async {
    try {
      var seminario =
      jsonDecode((await http.get(Uri.parse(baseUrl + "seminario"))).body);
      print(seminario);
      setState(() {
        viewSeminario = seminario;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMeusSeminarios() async {
    Participante.getStorage().then((user) async {
      try {
        var seminario = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/seminario")))
                .body);
        setState(() {
          print(seminario);
          viewSeminario = seminario['tbl_seminario'];
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
      getTodosSeminarios();
    } else {
      print("especifico");
      getMeusSeminarios();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewSeminario);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewSeminario.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetSeminario = [];
      String hr_inicio = '0';
      viewSeminario.forEach((seminario) {
        if (seminario['hr_inicio'] != hr_inicio) {
          widgetSeminario.add(linhaHora(hora: seminario['hr_inicio']));
          hr_inicio = seminario['hr_inicio'];
        }
        widgetSeminario.add(SeminarioCard(
          seminario: Seminario().fromJson(seminario),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetSeminario,
          ));
    }
  }
}
