import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/teatro.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/teatro/teatroCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemTeatro extends StatefulWidget {
  ListagemTeatro({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemTeatroState createState() => _ListagemTeatroState();
}

class _ListagemTeatroState extends State<ListagemTeatro> {
  List<dynamic> viewTeatro = [];
  bool carregou = false;
  getTodosTeatros() async {
    try {
      var teatro =
      jsonDecode((await http.get(Uri.parse(baseUrl + "teatro"))).body);
      print(teatro);
      setState(() {
        viewTeatro = teatro;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMeusTeatros() async {
    Participante.getStorage().then((user) async {
      try {
        var teatro = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/teatro")))
                .body);
        setState(() {
          print(teatro);
          viewTeatro = teatro['tbl_teatro'];
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
      getTodosTeatros();
    } else {
      print("especifico");
      getMeusTeatros();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewTeatro);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewTeatro.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetTeatro = [];
      String hr_inicio = '0';
      viewTeatro.forEach((teatro) {
        if (teatro['hr_inicio'] != hr_inicio) {
          widgetTeatro.add(linhaHora(hora: teatro['hr_inicio']));
          hr_inicio = teatro['hr_inicio'];
        }
        widgetTeatro.add(TeatroCard(
          teatro: Teatro().fromJson(teatro),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetTeatro,
          ));
    }
  }
}
