import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siepex/src/eventos/juergs/models/modalidade.dart';
// import 'package:siepex/models/modalidade.dart';
import 'dart:convert';
import 'package:siepex/src/config.dart';
import 'package:siepex/src/eventos/juergs/models/serializeJuergs.dart';
// import 'package:provider/provider.dart';
import 'package:siepex/src/eventos/juergs/Widgets/errorDialog.dart';

class Equipe extends ChangeNotifier {
  String nome;
  int id;
  int idModalidade;
  String nomeModalidade;
  int maximoParticipantes;
  int numeroParticipantes;
  // int numero_rustica;
  // String cpfCapitao;
  // String celCapitao;
  // List<String> participantesCpf = <String>[];
  // List<String> participantesNomes = <String>[];
  List<Estudante> participantes = <Estudante>[];
  Estudante capitao;
  bool isLoading = false;
  int index;

  // get nomeCapitao => participantesNomes[indexCapitao()];
  // Retorna a string do cel com o traço no meio.
  get celCapitaoFormated {
    if (capitao.celular.isNotEmpty && capitao.celular != '0') {
      if (capitao.celular.length == 11) {
        return "(" + capitao.celular.substring(0,2) + ")" + capitao.celular.substring(2,7) + "-" + capitao.celular.substring(7,11);
      } else {
        return capitao.celular;
      }
    } else {
      return 'Não Cadastrou';
    }
  }

  //get celCapitaoFormated => celCapitao.substring(0, 5) + '-' + celCapitao.substring(5);
  // Retorna a string com numero de participantes / maximo de participantes
  get partFormat =>
      numeroParticipantes.toString() + '/' + maximoParticipantes.toString();

  Equipe.fromJson(jsonData) {
    this.nome = jsonData['nome_equipe'];
    this.id = jsonData['id'];
    this.idModalidade = jsonData['id_modalidade'];
    this.nomeModalidade = jsonData['nome_modalidade'];
    this.maximoParticipantes = int.parse(jsonData['maximo_participantes']
        .toString()); // Nao entendo porque, mas as vezes a api
    this.numeroParticipantes = int.parse(jsonData['numero_participantes']
        .toString()); // retorna int, outras retorna string. ??
    // this.numero_rustica = jsonData['numero_rustica'];
    this.capitao = Estudante.fromJson(jsonData['capitao']);
    try {
      for (var partJson in jsonData['participantes']) {
        Estudante part = Estudante.fromJson(partJson);
        participantes.add(part);
      }
    } catch (e) {
      print(e);
    }
  }

  Future entrarEquipe(BuildContext context, bool isActive) async {
    try {
      if(userJuergs.tipoParticipante != "Atleta"){
        errorDialog(context, 'Erro', 'Apenas atletas podem entrar em uma equipe!');
        return;
      }
      if (!isActive) {
        errorDialog(context, 'Erro', 'Inscrições Encerradas.');
        return;
      } else if (numeroParticipantes == maximoParticipantes) {
        errorDialog(context, 'Erro', 'A equipe está cheia.');
      }
      isLoading = true;
      notifyListeners();
      var resposta = jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/entra'),
              body: {'user_cpf': userJuergs.cpf, 'equipe_id': id.toString(), 'user_name':userJuergs.nome}))
          .body);

      var updatedTeam = Equipe.fromJson(resposta['data']);
      participantes = updatedTeam.participantes;
      numeroParticipantes = updatedTeam.numeroParticipantes;
      userJuergs.minhasEquipes.add(updatedTeam);
      isLoading = false;
      notifyListeners();
      return;
    } catch (e) {
      print("Erro ao entrar na equipe: " + e.toString());
      return;
    }
  }

  Future updateName(BuildContext context, String newName) async {
    try {
      if (newName != nome) {
        var resposta =
            jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/changeName'), body: {
          'id_modalidade': idModalidade.toString(),
          'nome_modalidade': nomeModalidade,
          'nome_equipe': newName,
          'id_equipe': id.toString(),
        }))
                .body);
        if (resposta['status'] == 'erro') {
          print(resposta['erro']);
          errorDialog(context, 'Erro', 'Nome da Equipe já existe.');
        } else {
          nome = newName;
          userJuergs.updateTeamName(id, nome);
          notifyListeners();
        }
      } else {
      }
    } catch (e) {
      print('Erro ao mudar nome da Equipe: ' + e.toString());
    }
  }

  Future changeCaptain(BuildContext context, Estudante newCap) async {
    try {
      isLoading = true;
      notifyListeners();
      var resposta =
          jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/changeCaptain'), body: {
        'newcap_cpf': newCap.cpf,
        'equipe_id': id.toString(),
      }))
              .body);
      if (resposta['status'] == 'erro') {
        errorDialog(context, 'Erro', 'Erro ao alterar o capitão');
      } else {
        capitao = newCap;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Erro ao mudar o capitão: ' + e.toString());
    }
  }

  Future deleteTeam(BuildContext context) async {
    try {
      // Modalidade modalidade = Provider.of<Modalidade>(context);
      // print(modalidade.nome);
      isLoading = true;
      notifyListeners();
      var resposta =
          jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/remove'), body: {
        'equipe_id': id.toString(),
      }))
              .body);
      if (resposta['status'] == 'erro') {
        print('Erro ao apagar Equipe');
        errorDialog(context, 'Erro', 'Erro ao excluir Equipe');
      } else {
        userJuergs.minhasEquipes.removeWhere((element) => element.id == id);
        // modalidade.inscrito = false;
        //userJuergs.minhasEquipes.removeWhere((element) => element.id == id);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Erro Ao Deletar Equipe: ' + e.toString());
    }
  }

  Future excludeMembers(BuildContext context, List<String> membersCpf) async {
    try {
      // Modalidade modalidade = Provider.of<Modalidade>(context);
      // print(modalidade.nome);
      isLoading = true;
      notifyListeners();
      var resposta =
          jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/excludeMembers'), body: {
        'equipe_id': id.toString(),
        'members_cpf': json.encode(membersCpf),
      }))
              .body);
      if (resposta['status'] == 'erro') {
        print('Erro excluir membros.');
        errorDialog(context, 'Erro', 'Erro ao excluir membros da equipe.');
      } else {
        print('Membros excluidos da equipe com sucesso');
        
        participantes.removeWhere((element) => membersCpf.contains(element.cpf));

        numeroParticipantes -= membersCpf.length;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Erro Ao Excluir Membros Equipe: ' + e.toString());
    }
  }

  // Pega as equipes registradas para a modalidade.
  static Future<List<Equipe>> getEquipesPorModalidade(int idModalidade) async {
    try {
      var resposta = jsonDecode((await http.put(Uri.parse(baseUrl + 'obtemEquipes/porModalidade'),
              body: {
            'id_modalidade': idModalidade.toString(),
          }))
          .body);
      if (resposta['status'] == 'sucesso'){
        List<Equipe> equipesList = new List<Equipe>();
        for (int i = 0; i < resposta['data'].length; i++) {
          equipesList.add(Equipe.fromJson(resposta['data'][i]));
          equipesList[i].index = i;
        }
        return equipesList;
      }
      else {
        print('Erro ao pegar Equipes');
        return [];
      }
    } catch (e) {
      print('Erro ao pegar Equipes ' + e.toString());
      return [];
    }
  }

  static Future<List<Equipe>> getEquipesPorFase(int idModalidade, int faseAtual) async {
    try {
      var resposta = jsonDecode((await http.put(Uri.parse(baseUrl + 'obtemEquipes/porFase'),
              body: {
            'id_modalidade': idModalidade.toString(),
            'fase_atual': faseAtual.toString()
          }))
          .body);
     if (resposta['status'] == 'sucesso'){
        List<Equipe> equipesList = new List<Equipe>();
        for (int i = 0; i < resposta['count']; i++) {
          equipesList.add(Equipe.fromJson(resposta['data'][i]));
          equipesList[i].index = i;
        }
        return equipesList;
      }
      else {
        print('Erro ao pegar Equipes');
        return [];
      }
    } catch (e) {
      print('Erro ao pegar Equipes ' + e.toString());
      return [];
    }
  }

  static Future<List<Equipe>> getMyEquipes(String userCpf) async {
    try {
      var resposta = jsonDecode((await http
              .put(Uri.parse(baseUrl + 'obtemEquipes/porUser'), body: {'user_cpf': userCpf}))
          .body);
      if (resposta['status'] == 'sucesso'){
        List<Equipe> equipesList = new List<Equipe>();

        for (int i = 0; i < resposta['data'].length; i++) {
          equipesList.add(Equipe.fromJson(resposta['data'][i]));
          equipesList[i].index = i;
        }
        return equipesList;
      }
      else {
        print('Erro ao pegar Equipes');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future criarEquipe(BuildContext context, Modalidade modalidade,
      String nomeEquipe, bool isActive) async {
    try {
      if (!(userJuergs.tipoParticipante == "Atleta")) {
        errorDialog(context, 'Erro', 'Apenas Atletas podem criar equipes!');
        return;
      } else if (!isActive) {
        errorDialog(context, 'Erro', 'Inscrições Encerradas');
        return;
      }
      if (nomeEquipe.isNotEmpty) {
        var resposta =
            jsonDecode((await http.put(Uri.parse(baseUrl + 'equipe/cadastra'), body: {
          'id_modalidade': modalidade.id.toString(),
          'nome_equipe': nomeEquipe,
          'nome_modalidade': modalidade.nome,
          'maximo_participantes': modalidade.maxParticipantes.toString(),
          'user_name': userJuergs.nome,
          'user_cpf': userJuergs.cpf,
          'user_cel': userJuergs.celular,
        }))
                .body);
        if (resposta['status'] == 'sucesso') {
          userJuergs.minhasEquipes.add(Equipe.fromJson(resposta['data']));
          errorDialog(context, 'Sucesso', 'Equipe Criada');
          return;
        } else if (resposta['erro'] == 'Equipe já existe') {
          errorDialog(context, 'Erro ao criar equipe!',
              'Já existe uma equipe com este nome.');
          return;
        } else if (resposta['erro'] == 'ja_cadastrado_na_modalidade') {
          errorDialog(context, 'Erro ao criar equipe!',
              'Você ja esta cadastrado nesta modalidade.');
          return;
        }
      } else {
        errorDialog(context, 'Erro ao criar equipe!',
            'O nome da equipe é obrigatório.');
      }
    } catch (e) {
      print('Erro ao criar Equipe: ' + e.toString());
      return;
    }
  }
}
