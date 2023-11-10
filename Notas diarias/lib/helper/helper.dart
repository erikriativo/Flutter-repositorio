import 'dart:io';

import 'package:notas_diarias/model/anotacaomodelo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AnotacaoHelper {
  static const String tabelaAnotacoes = "anotacoes";

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  Database? _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDb();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = """
    CREATE TABLE $tabelaAnotacoes (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)
     """;
    await db.execute(sql);
  }

  inicializarDb() async {
    databaseFactory = databaseFactoryFfi;
    final Directory caminhoBancoDeDados =
        await getApplicationDocumentsDirectory();
    final localDatabase =
        path.join(caminhoBancoDeDados.path, "databases", "anotacoes.db");
    var db = await databaseFactory.openDatabase(localDatabase,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ));
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    Database bancoDeDados = await db;

    int id = await bancoDeDados.insert(tabelaAnotacoes, anotacao.toMap());

    return id;
  }

  recuperarAnotacoesTabela() async {
    Database bancoDeDados = await db;

    String sql = "SELECT * FROM $tabelaAnotacoes ORDER BY data DESC";
    List anotacoes = await bancoDeDados.rawQuery(sql);
    return anotacoes;
  }

  Future<int> atualizarAnotacao(Anotacao anotacao) async {
    Database bancoDeDados = await db;
    return await bancoDeDados.update(
      tabelaAnotacoes,
      anotacao.toMap(),
      where: "id = ?",
      whereArgs: [anotacao.id],
    );
  }

  Future<int> removerAnotacao(int? id) async {
    Database bancoDeDados = await db;
    return await bancoDeDados
        .delete(tabelaAnotacoes, where: "id = ?", whereArgs: [id]);
  }
}
