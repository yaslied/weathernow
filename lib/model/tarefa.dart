class Tarefa {
  int id;
  String titulo, descricao;
  bool diaInteiro;
  DateTime hrinicial, hrfinal;
  String cor;

  Tarefa.fromMap(Map map) {
    id = map[id];
    titulo = map[titulo];
    descricao = map[descricao];
    diaInteiro = map[diaInteiro];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      tituloColumn: titulo,
      statusColumn: status,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  Tarefa.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        descricao = json['descricao'];
}

enum Notificacao { min, hr }
