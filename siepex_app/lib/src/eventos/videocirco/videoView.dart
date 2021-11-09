import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/models/videocirco.dart';
import 'package:siepex/models/participante.dart';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/videocirco/videoCard.dart';
import 'package:siepex/src/eventos/widgets/widgets.dart';

class ListagemVideo extends StatefulWidget {
  ListagemVideo({Key key, this.total = true}) : super(key: key);
  final bool total;
  _ListagemVideoState createState() => _ListagemVideoState();
}

class _ListagemVideoState extends State<ListagemVideo> {
  List<dynamic> viewVideo = [];
  bool carregou = false;
  getTodosVideos() async {
    try {
      var video =
      jsonDecode((await http.get(Uri.parse(baseUrl + "videocirco"))).body);
      print(video);
      setState(() {
        viewVideo = video;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        carregou = true;
      });
    }
  }

  getMeusVideos() async {
    Participante.getStorage().then((user) async {
      try {
        var video = jsonDecode(
            (await http.get(Uri.parse(baseUrl + "participante/${user.id}/video")))
                .body);
        setState(() {
          print(video);
          viewVideo = video['tbl_videocirco'];
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
      getTodosVideos();
    } else {
      print("especifico");
      getMeusVideos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(viewVideo);
    if (carregou == false) {
      return Container(
        //pourinhourglass
        //fadingfour
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 200,
        ),
      );
    } else if (viewVideo.length == 0 && carregou == true) {
      return Text("nada a ser exibido");
    } else {
      print('teste');
      List<Widget> widgetVideo = [];
      String hr_inicio = '0';
      viewVideo.forEach((video) {
        if (video['hr_inicio'] != hr_inicio) {
          widgetVideo.add(linhaHora(hora: video['hr_inicio']));
          hr_inicio = video['hr_inicio'];
        }
        widgetVideo.add(VideoCard(
          video: Video().fromJson(video),
          cadastro: widget.total,
        ));
      });
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: widgetVideo,
          ));
    }
  }
}
