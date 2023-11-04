class Post {
  final int _userId;
  final int _id;
  final String _title;
  final String _body;

  Post(this._userId, this._id, this._title, this._body);

  Map toJson() {
    return {"userId": _userId, "id": _id, "title": _title, "body": _body};
  }

  String get body => _body;
  set body(String value) {
    body = value;
  }

  String get title => _title;
  set title(String value) {
    title = value;
  }

  int get userId => _userId;
  set userId(int value) {
    userId = value;
  }

  int get id => _id;
  set id(int value) {
    id = value;
  }
}
