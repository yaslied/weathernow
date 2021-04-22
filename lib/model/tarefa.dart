import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tarefaTable = "tarefaTable";
final String idColumn = "idColumn";
final String tituloColumn = "tituloColumn";
final String descricaoColumn = "descricaoColumn";
final String diaInteiroColumn = "diaInteiroColumn";
final String hrInicialColumn = "hrInicialColumn";
final String hrFinalColumn = "hrFinalColumn";
final String notificacao = "notificacaoColumn";

class TarefaHelper {
  static final TarefaHelper _instance = TarefaHelper.internal();
  factory TarefaHelper() => _instance;

  TarefaHelper.internal();

  Database _db; //apenas essa classe consegue acessar o db

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath =
        await getDatabasesPath(); //await para esperar retornar antes de continuar execucao
    final path = join(databasesPath, "tarefa.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE "
          "$tarefaTable($idColumn INTEGER PRIMARY KEY, "
          "$tituloColumn TEXT,"
          "$descricaoColumn TEXT,"
          "$diaInteiroColumn BOOLEAN,"
          "$hrInicialColumn TIMESTAMP,"
          "$hrFinalColumn TIMESTAMP)");
    });
  }

  Future<Tarefa> saveTarefa(Tarefa tarefa) async {
    Database dbTarefa = await db;
    tarefa.id = await dbTarefa.insert(tarefaTable, tarefa.toMap());
    return tarefa;
  }

  Future<Tarefa> getTarefa(int id) async {
    Database dbTarefa = await db;
    List<Map> maps = await dbTarefa.query(tarefaTable,
        columns: [idColumn, tituloColumn, descricaoColumn],
        where: "$idColumn = ?",
        whereArgs: [id]); //buscando tarefa apenas pelo id informado

    if (maps.length > 0) {
      return Tarefa.fromMap(maps.first);
    } else
      return null;
  }

  Future<int> deleteTarefa(int id) async {
    Database dbTarefas = await db;
    return await dbTarefas
        .delete(tarefaTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  // ignore: missing_return
  Future<Tarefa> updateTarefa(Tarefa tarefa) async {
    Database dbTarefas = await db;
    dbTarefas.update(tarefaTable, tarefa.toMap(),
        where: "$idColumn = ?", whereArgs: [tarefa.id]);
  }

  Future<List<Tarefa>> getTodasTarefa() async {
    Database dbTarefa = await db;

    List resultado = await dbTarefa.rawQuery("SELECT * FROM $tarefaTable");

    return resultado.map((item) => Tarefa.fromMap(item)).toList();
  }

  close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Tarefa {
  Tarefa();

  int id;
  String titulo, descricao;
  String diaInteiro;
  DateTime hrInicial, hrFinal;
  String cor;

  Tarefa.fromMap(Map map) {
    id = map[idColumn];
    titulo = map[tituloColumn];
    descricao = map[descricaoColumn];
    diaInteiro = map[diaInteiroColumn];
    hrInicial = map[hrInicialColumn];
    hrFinal = map[hrFinalColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      tituloColumn: titulo,
      descricaoColumn: descricao,
      diaInteiroColumn: diaInteiro,
      hrInicialColumn: hrInicial,
      hrFinalColumn: hrFinal
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  String toString() {
    return "Tarefa(id: $id, descricao: $descricao, diaInteiro: $diaInteiro, hrInicial: $hrInicial, hrFinal: $hrFinal)";
  }

  Tarefa.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        descricao = json['descricao'];
}
