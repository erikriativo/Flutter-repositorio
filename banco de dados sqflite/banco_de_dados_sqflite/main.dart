import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //CRUD com banco de dados e path_provider
  //Create, Read, Update e Delete.

  @override
  void initState() {
    super.initState();
    _abrirBancodeDados();
  }

  String tabelaUsuarios = "usuarios";

  Future<Database> _abrirBancodeDados() async {
    //Define suporte para Linux, windowns e MACOs
    databaseFactory = databaseFactoryFfi;

    //Defina o caminho com path_provider, é recomendado pois tem maior controle no armazenamento.
    final Directory directory = await getApplicationDocumentsDirectory();

    //Após obter o caminho com path_provider, iremos determinar o caminho onde iremos
    //armazenar o banco de dados
    final databasePath = path.join(directory.path, "databases",
        "my_database.db"); //databasePath = home/user/Documents/databases/my_database.db

    //print(databasePath.toString());

    var db = await databaseFactory.openDatabase(databasePath,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              await db.execute('''
              CREATE TABLE $tabelaUsuarios (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT,
                idade INTEGER)
              ''');
            }));

    // Verifique se o banco de dados abriu corretamente.
    //print(db.isOpen.toString());

    return db;
  }

  _salvarDb() async {
    //Em todo método para utilização de SQL banco de dados é necessário que haja a instancia do banco de dados
    //Tanto para uma possivel abertura do banco, ou recuperação de um banco já existente.
    Database db = await _abrirBancodeDados();

    String nome = "Maria Mafalda";
    int idade = 47;

    Map<String, dynamic> dadosUsuario = {'nome': nome, 'idade': idade};

    await db.insert(tabelaUsuarios, dadosUsuario);

    // Para listar os usuários após a inserção:
    //_listarDb();
  }

  _listarDb() async {
    Database db = await _abrirBancodeDados();
    //String filtro = "a";
    String sql =
        "SELECT * FROM usuarios "; //Seleciona Todos as colunas da tabela Usuarios
    //Alguns exemplos de filtros em SQL
    //String sql = "SELECT * FROM $tabelaUsuarios WHERE idade >= 18 AND idade <= 30 ";
    //String sql = "SELECT * FROM $tabelaUsuarios WHERE idade BETWEEN 18 AND 50 ";
    //String sql = "SELECT * FROM $tabelaUsuarios WHERE nome LIKE '%$filtro%' ORDER BY UPPER(nome) ASC";
    //String sql = "SELECT * FROM $tabelaUsuarios WHERE nome LIKE '%$filtro%' ORDER BY idade DESC";
    //String sql = "SELECT * FROM $tabelaUsuarios WHERE nome LIKE '%$filtro%' ORDER BY idade DESC LIMIT 2";
    final List<Map<String, dynamic>> query = await db.rawQuery(sql);

    print("Usuários : ${query.toString()}");

    /*for (var usuario in query) {
      print(
          "item id : ${usuario['id']} nome : ${usuario['nome']}, idade : ${usuario['idade']}");
    }*/
  }

  _listarUsuarioPeloId(int id) async {
    Database db = await _abrirBancodeDados();
    List usuarios = await db.query(tabelaUsuarios,
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);

    //Para o usuario que atenda as condicoes do [id] acima sera exibido no console
    for (var usuario in usuarios) {
      print(
          "item id : ${usuario['id'].toString()} nome : ${usuario['nome']}, idade : ${usuario['idade'].toString()}");
    }
  }

  _atualizarUsuario(int id) async {
    Database db = await _abrirBancodeDados();

    Map<String, dynamic> dadosUsuario = {"nome": "Erik Bruno", "idade": 27};

    int retorno = await db.update(
      tabelaUsuarios, 
      dadosUsuario,
      where: "id = ?",
      whereArgs: [id]);

    print("Quantidade atualizada: $retorno");
  }

  _deletar(int id) async {
    Database db = await _abrirBancodeDados();
    //Perceba que o metodo delete ele retorna um Future<int> ele nos tras a quantidade
    //de itens que foram removidos da tabela.
    int retorno =
        await db.delete(tabelaUsuarios, where: "id = ?", whereArgs: [id]);

    print("Quantidade de itens removidos: $retorno");
  }

  @override
  void dispose() async {
    Database db = await _abrirBancodeDados();
    db.close(); // Feche o banco de dados quando não precisar mais dele.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_listarUsuarioPeloId(3);
    //_deletar(3);
    //_salvarDb();
    //_listarDb();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banco de dados SQFlite"),
      ),
      body: Container(),
    );
  }
}
