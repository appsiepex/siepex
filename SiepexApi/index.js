console.log('I am running!')

const express = require('express'),
  participante_rotas = require("./src/participante/participante_routes.js"),
  visitas_rotas = require("./src/eventos/visitas.js"),
  minicursos_rotas = require("./src/eventos/minicursos.js"),
  geral_rotas = require("./src/eventos/geral.js"),
  comissao_rotas = require("./src/comissao/comissao_routes"),
  trabalhos_rotas = require("./src/eventos/trabalhos.js"),
  cadastro_juergs_rotas = require("./src/eventos/cadastraJuergs.js"),
  obtem_participante_rotas = require("./src/eventos/obterParticipante.js"),
  obtem_modalidades_rotas = require("./src/eventos/obterModalidades.js"),
  cadastra_equipe_rotas = require("./src/eventos/cadastraEquipe.js"),
  obtem_equipes_rotas = require("./src/eventos/obterEquipes.js"),
  atualiza_participante_rotas = require("./src/eventos/atualizaParticipante.js"),
  oficina_rotas = require("./src/eventos/oficina.js"),
  palestras_rotas = require("./src/eventos/palestras.js"),
  rodas_rotas = require("./src/eventos/rodas.js"),
  mostra_rotas = require("./src/eventos/mostra.js"),
  forum_rotas = require("./src/eventos/forum.js"),
  seminario_rotas = require("./src/eventos/seminario.js"),
  videocirco_rotas = require("./src/eventos/videocirco.js"),
  circodanca_rotas = require("./src/eventos/circodanca.js"),
  teatro_rotas = require("./src/eventos/teatro.js"),
  musica_rotas = require("./src/eventos/musica.js"),
  danca_rotas = require("./src/eventos/danca.js"),
  jogos_rotas = require("./src/eventos/jogos.js"),
  bodyParser = require('body-parser');

const app = express();

var rawBodySaver = function (req, res, buf, encoding) {
  if (buf && buf.length) {
    req.rawBody = buf.toString(encoding || 'utf8');
  }
}

app.use(bodyParser.json({
  verify: rawBodySaver
}));

app.use(bodyParser.urlencoded({
  verify: rawBodySaver,
  extended: true
}));
app.use(bodyParser.raw({
  verify: rawBodySaver,
  type: '*/*'
}));

app.use('/participante', participante_rotas);
app.use('/visitas', visitas_rotas);
app.use('/minicursos', minicursos_rotas);
app.use('/geral', geral_rotas);
app.use('/comissao', comissao_rotas);
app.use("/trabalhos", trabalhos_rotas);
app.use("/cadastroJuergs", cadastro_juergs_rotas);
app.use("/obtemParticipante", obtem_participante_rotas);
app.use("/modalidades", obtem_modalidades_rotas);
app.use("/equipe", cadastra_equipe_rotas);
app.use('/obtemEquipes', obtem_equipes_rotas);
app.use('/atualizaParticipante', atualiza_participante_rotas);
app.use('/oficina', oficina_rotas);
app.use('/palestras', palestras_rotas);
app.use('/rodas', rodas_rotas);
app.use('/mostra', mostra_rotas);
app.use('/forum', forum_rotas);
app.use('/seminario', seminario_rotas);
app.use('/videocirco', videocirco_rotas);
app.use('/circodanca', circodanca_rotas);
app.use('/teatro', teatro_rotas);
app.use('/musica', musica_rotas);
app.use('/danca', danca_rotas);
app.use('/jogos', jogos_rotas);
app.get('/', function (req, res) {
  res.json("the server is on")
})


app.listen(process.env.PORT || 5000, function () {
  console.log('Example app listening on port ', (process.env.PORT || 5000));
});