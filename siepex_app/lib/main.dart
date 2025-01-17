import 'package:flutter/material.dart';
import 'package:siepex/models/seminario.dart';
import 'package:siepex/src/agenda/agenda.dart';
import 'package:siepex/src/areaParticipante/alimentacao/alimentacao.dart';
import 'package:siepex/src/areaParticipante/homeParticipante.dart';
import 'package:siepex/src/areaParticipante/meusEventos/meusEventos.dart';
import 'package:siepex/src/areaParticipante/mudasenha.dart';
import 'package:siepex/src/areaParticipante/qr.dart';
import 'package:siepex/src/comissao/comissao.dart';
import 'package:siepex/src/eventos/eventos.dart';
import 'package:siepex/src/eventos/geral/geral.dart';
import 'package:siepex/src/eventos/juergs/AlternatePage.dart';
import 'package:siepex/src/eventos/juergs/PerfilParticipantes.dart';
import 'package:siepex/src/eventos/juergs/tabelas/PaginaTabela.dart';
import 'package:siepex/src/eventos/juergs/RegulamentoPage.dart';
import 'package:siepex/src/eventos/minicursos/minicursos.dart';
import 'package:siepex/src/eventos/trabalhos/Trabalhos.dart';
import 'package:siepex/src/eventos/visitas/visitas.dart';
import 'package:siepex/src/eventos/oficina/oficina.dart';
import 'package:siepex/src/eventos/palestras/palestras.dart';
import 'package:siepex/src/eventos/rodasdeconversas/rodas.dart';
import 'package:siepex/src/eventos/mostra/mostra.dart';
import 'package:siepex/src/eventos/forum/forum.dart';
import 'package:siepex/src/eventos/seminario/seminario.dart';
import 'package:siepex/src/eventos/videocirco/video.dart';
import 'package:siepex/src/eventos/circodanca/circodanca.dart';
import 'package:siepex/src/eventos/teatro/teatro.dart';
import 'package:siepex/src/eventos/musica/musica.dart';
import 'package:siepex/src/eventos/danca/danca.dart';
import 'package:siepex/src/hoteis/hoteis.dart';
import 'package:siepex/src/info/avisos.dart';
import 'package:siepex/src/info/info.dart';
import 'package:siepex/src/inicio/inicio.dart';
import 'package:siepex/src/login/login.dart';
import 'package:siepex/src/mapa_evento/mapa_evento.dart';
import 'package:siepex/src/notfound.dart';
import 'package:siepex/src/palestrantes/palestrantes.dart';
import 'package:siepex/src/restaurantes/restaurante.dart';
import 'package:siepex/src/sobre/sobre.dart';
import 'package:siepex/src/eventos/juergs/JuergsSobre.dart';
import 'package:siepex/src/eventos/juergs/Home/InicioJuergs.dart';
import 'package:siepex/src/eventos/juergs/HoteisJuergs.dart';
import 'package:siepex/src/eventos/juergs/RestauranteJuergs.dart';
import 'package:siepex/src/eventos/juergs/DefaultPage.dart';
import 'package:siepex/src/eventos/juergs/ParticipanteJuergs.dart';
import 'package:siepex/src/eventos/juergs/CadastraParticipante.dart';
import 'package:siepex/src/eventos/juergs/LoginPage.dart';
import 'package:siepex/src/eventos/juergs/Home/ModalidadesPage.dart';
import 'package:siepex/src/eventos/juergs/equipe/PaginaEquipes.dart';
import 'package:siepex/src/eventos/forumAreas/forumAreas.dart';
import 'package:siepex/src/inicio/inicioSiepex.dart';
import 'package:siepex/src/tabs/tabs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() => runApp(MyApp());

// flutter build --build-number=x --build-name=y
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: <String, WidgetBuilder>{
        'tabs': (BuildContext context) => TabsPage(),
        'eventos': (BuildContext context) => EventosPage(),
        'agenda': (BuildContext context) => AgendaPage(),
        'sobre': (BuildContext context) => SobrePage(),
        'palestrantes': (BuildContext context) => PalestrantesPage(),
        'inicio': (BuildContext context) => InicioPage(),
        'hoteis': (BuildContext context) => HoteisPage(),
        'restaurantes': (BuildContext context) => RestaurantesPage(),
        'info': (BuildContext context) => InfoPage(),
        'homeParticipante': (BuildContext context) => HomeParticipante(),
        'qr': (BuildContext context) => QrPage(),
        '404': (BuildContext context) => NotFoundPage(),
        'alimentacao': (BuildContext context) => AlimentacaoPage(),
        'MapaEvento': (BuildContext context) => MapaEventoPage(),
        'login': (BuildContext context) => LoginPage(),
        "minicursos": (BuildContext context) => MinicursosPage(),
        "visitas": (BuildContext context) => VisitasPage(),
        "meuseventos": (BuildContext context) => MeusEventosPage(),
        "mudasenha": (BuildContext context) => MudaSenhaPage(),
        "avisos": (BuildContext context) => AvisosPage(),
        "geral": (BuildContext context) => GeralPage(),
        "comissao": (BuildContext context) => ComissaoPage(),
        "trabalhos": (BuildContext context) => TrabalhosPage(),
        "oficina": (BuildContext context) => OficinaPage(),
        "palestras": (BuildContext context) => PalestrasPage(),
        "rodasdeconversas": (BuildContext context) => RodasPage(),
        "mostra": (BuildContext context) => MostraPage(),
        "forum": (BuildContext context) => ForumEventosPage(),
        "seminario": (BuildContext context) => SeminarioPage(),
        "videocirco": (BuildContext context) => VideoCircoPage(),
        "circodanca": (BuildContext context) => CircoDancaPage(),
        "teatro": (BuildContext context) => TeatroPage(),
        "musica": (BuildContext context) => MusicaPage(),
        "danca": (BuildContext context) => DancaPage(),
        "juergsSobre": (BuildContext context) => JuergsSobre(),
        "forumAreas": (BuildContext context) => ForumPage(),
        "inicioSiepex": (BuildContext context) => InicioSiepex(),
        "loginJuergs": (BuildContext context) => LoginJuergs(),
        "inicioJuergs": (BuildContext context) => InicioJuergs(),
        "hoteisJuergs": (BuildContext context) => HoteisJuergs(),
        "modalidadesJuergs": (BuildContext context) => ModalidadesPage(),
        "restaurantesJuergs": (BuildContext context) => RestaurantesJuergs(),
        "defaultPage": (BuildContext context) => DefaultPage(),
        "participanteJuergs": (BuildContext context) => ParticipanteJuergs(),
        "cadastraParticipante": (BuildContext context) =>
            CadastraParticipante(),
        "paginaEquipes": (BuildContext context) => PaginaEquipes(),
        "alternatePage": (BuildContext context) => AlternatePage(),
        "regulamentoPage": (BuildContext context) => RegulamentoPage(),
        "tabelaPage": (BuildContext context) => PaginaTabela(),
        "perfilParticipante": (BuildContext context) => PerfilParticipante(),
      },
      //Deixar em PT-BR a agenda
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      title: 'Siepex App',

      theme: ThemeData(
        // textSelectionColor: Colors.white
        primaryColor: Color(0xff004422),
        textTheme: TextTheme(
          subhead: TextStyle(color: Colors.black)
        ),
        // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        // textTheme: Typography(platform: TargetPlatform.iOS).white,
        // backgroundColor: Colors.green[30],
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      // home: TabsPage(),
    );
  }
}
