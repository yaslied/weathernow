import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_now/model/tarefa.dart';

final String tarefaTable = "tarefaTable";
final String idColumn = "idColumn";
final String tituloColumn = "tituloColumn";
final String descricaoColumn = "descricaoColumn";
final String diaInteiroColumn = "diaInteiroColumn";
final String hrInicialColumn = "hrInicialColumn";
final String hrFinalColumn = "hrFinalColumn";

class TarefaController {
  static final TarefaController _instance = TarefaController.internal();

  factory TarefaController() => _instance;

  TarefaController.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
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

  // ignore: missing_return
  Future<Tarefa> getTarefa(int id) async {
    Database dbTarefa = await db;
    List<Map> maps = await dbTarefa.query(tarefaTable,
        columns: [idColumn, tituloColumn, descricaoColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Tarefa.fromMap(maps.first);
    }
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
}
