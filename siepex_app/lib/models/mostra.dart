class Mostra {
  int id;
  String titulo;
  String palestrantes;
  String hr_inicio;
  String hr_fim;
  String lmt_vagas;
  String local;
  String sala;
  String obs;

  Mostra (
      {this.id,
        this.titulo,
        this.palestrantes,
        this.hr_inicio,
        this.hr_fim,
        this.lmt_vagas,
        this.local,
        this.sala,
        this.obs});

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.titulo = json['titulo'];
    this.palestrantes = json['palestrantes'];
    this.hr_inicio = json['hr_inicio'];
    this.hr_fim = json['hr_fim'];
    this.lmt_vagas = json['lmt_vagas'];
    this.local = json['local'];
    this.sala = json['sala'];
    this.obs = json['obs'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['palestrantes'] = this.palestrantes;
    data['hr_inicio'] = this.hr_inicio;
    data['hr_fim'] = this.hr_fim;
    data['lmt_vagas'] = this.lmt_vagas;
    data['local'] = this.local;
    data['sala'] = this.sala;
    data['obs'] = this.obs;
    return data;
  }
}
