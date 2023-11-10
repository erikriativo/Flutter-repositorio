class Anotacao {
  int? id;
  String titulo = "";
  String descricao = "";
  String data = "";

  Anotacao(this.titulo, this.descricao, this.data);

  Anotacao.fromMap(Map map) {
    id = map["id"];
    titulo = map["titulo"];
    descricao = map["descricao"];
    data = map["data"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      "titulo": titulo,
      "descricao": descricao,
      "data": data,
    };
    if (id != null) {
      mapa["id"] = id;
    }
    return mapa;
  }
}
