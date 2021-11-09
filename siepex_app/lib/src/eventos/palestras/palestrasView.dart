import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/palestras.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/palestras/palestrasCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemPalestras extends StatefulWidget {
  ListagemPalestras({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemPalestrasState createState() => _ListagemPalestrasState();
}

class _ListagemPalestrasState extends State<ListagemPalestras> {
  List<dynamic> viewPalestras = [];
  bool carregou = false;
  getTodasPalestras() async {
    try {
      var palestras =
      jsonDecode((await http.get(Uri.parse(baseUrl + "palestras"))).body);
      print(palestras);
      setState(() {
        viewPalestras = palestras;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMinhasPalestras() async {
    Participante.getStorage().then((user) async {
      try {
        var palestras = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/palestras")))
                .body);
        setState(() {
          print(palestras);
          viewPalestras = palestras['tbl_palestra'];
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
      getTodasPalestras();
    } else {
      print("especifico");
      getMinhasPalestras();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewPalestras);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewPalestras.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetPalestras = [];
      String hr_inicio = '0';
      viewPalestras.forEach((palestras) {
        if (palestras['hr_inicio'] != hr_inicio) {
          widgetPalestras.add(linhaHora(hora: palestras['hr_inicio']));
          hr_inicio = palestras['hr_inicio'];
        }
        widgetPalestras.add(PalestrasCard(
          palestras: Palestras().fromJson(palestras),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetPalestras,
          ));
    }
  }
}
