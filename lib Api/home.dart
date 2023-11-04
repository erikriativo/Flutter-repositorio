import 'package:consumo_api_avancado/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String urlBase = "https://jsonplaceholder.typicode.com";
  Post post = Post(0, 0, "", "");

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(Uri.parse("$urlBase/posts"));
    var jsonBody = json.decode(response.body);
    List<Post> postagens = [];
    for (var post in jsonBody) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
  }

  _post() async {
    var corpo = json.encode({
      "userId": 200,
      "id": null,
      "title": "Ola mundo",
      "body": "Nova mensagem"
    });
    http.Response response = await http.post(Uri.parse("$urlBase/posts"),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta Body: ${response.body}");
  }

  _put() async {
    int putIndex = 2;
    Post post =
        Post(120, 2, "Ola novo mundo", "corpo da mensagem tambem alterada");

    var corpo = json.encode(post.toJson());
    http.Response response = await http.put(
        Uri.parse("$urlBase/posts/$putIndex"),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta Body: ${response.body}");
  }

  _patch() async {
    int putIndex = 2;
    Post post = Post(120, 2, "Ola novo mundo", "Nova menssagem de Novo mundo");

    var corpo = json.encode(post.toJson());
    http.Response response = await http.put(
        Uri.parse("$urlBase/posts/$putIndex"),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta Body: ${response.body}");
  }

  _delete() async {
    int putIndex = 2;
    http.Response response =
        await http.delete(Uri.parse("$urlBase/posts/$putIndex"));

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Consumo de Api avançado"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(onPressed: _post, child: const Text("Salvar")),
                  ElevatedButton(onPressed: _put, child: const Text("Alterar")),
                  ElevatedButton(onPressed: _patch, child: const Text("patch")),
                  ElevatedButton(
                      onPressed: _delete, child: const Text("Deletar"))
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Post>>(
                    future: _recuperarPostagens(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            print("ocorreu um erro");
                            return Container();
                          } else {
                            print("Carregou");
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  List<Post> lista = snapshot.data!;
                                  Post post = lista[index];

                                  return ListTile(
                                    title: Text("$index. ${post.title}"),
                                    subtitle: Text(post.body),
                                  );
                                });
                          }
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
