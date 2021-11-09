import 'package:flutter/material.dart';
import 'package:siepex/models/oficina.dart';
// import 'package:siepex/src/agenda/evento_detalhes.dart';
import 'package:siepex/src/eventos/oficina/oficinaDetalhes.dart';

class OficinaCard extends StatelessWidget {
  final Oficina oficina;
  final bool cadastro;
  const OficinaCard({Key key, this.oficina, this.cadastro = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OficinaDetalhes(
                      oficina: oficina,
                      cadastro: cadastro,
                    )));
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Color(0xff249FAB),
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.only(left: 20, right: 10, top: 15),
                              width: 70,
                              height: 70,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          "https://avatars1.githubusercontent.com/u/29609021?s=400&u=24a2c965697b52e2697feb03ec808aa9b1b32443&v=4")))),
                          Text(
                            oficina.palestrantes,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                        margin: EdgeInsets.only(top: 0),
                        child: ListTile(
                          title: Text(oficina.titulo),
                          subtitle: Text(
                              '${oficina.hr_inicio}-${oficina.hr_fim}\nPredio:${oficina.local}\nVagas:${oficina.lmt_vagas}'),
                        )),
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          )),
    );
  }
}
