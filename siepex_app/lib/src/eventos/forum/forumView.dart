import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/forum.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/forum/forumCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemForum extends StatefulWidget {
  ListagemForum({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemForumState createState() => _ListagemForumState();
}

class _ListagemForumState extends State<ListagemForum> {
  List<dynamic> viewForum = [];
  bool carregou = false;
  getTodosForum() async {
    try {
      var forum =
      jsonDecode((await http.get(Uri.parse(baseUrl + "forum"))).body);
      print(forum);
      setState(() {
        viewForum = forum;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMeusForum() async {
    Participante.getStorage().then((user) async {
      try {
        var forum = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/forum")))
                .body);
        setState(() {
          print(forum);
          viewForum = forum['tbl_forum'];
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
      getTodosForum();
    } else {
      print("especifico");
      getMeusForum();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewForum);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewForum.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetForum = [];
      String hr_inicio = '0';
      viewForum.forEach((forum) {
        if (forum['hr_inicio'] != hr_inicio) {
          widgetForum.add(linhaHora(hora: forum['hr_inicio']));
          hr_inicio = forum['hr_inicio'];
        }
        widgetForum.add(ForumCard(
          forum: Forum().fromJson(forum),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetForum,
          ));
    }
  }
}
