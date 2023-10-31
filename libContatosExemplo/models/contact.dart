// class Contact {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String img;

//   Contact(this.id, this.name, this.email, this.phone, this.img);

//   Contact.fromMap(Map map) {
//     id = map[idColumn];
//     name = map[nameColumn];
//     email = map[emailColumn];
//     phone = map[phoneColumn];
//     img = map[imgColumn];
//   }

//   Map<String, Object?> toMap() {
//     Map<String, dynamic> map = {
//       nameColumn: name,
//       emailColumn: email,
//       phoneColumn: phone,
//       imgColumn: img,
//     };
//     // ignore: unnecessary_null_comparison
//     if (id != null) {
//       map[idColumn] = id;
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
//   }

//   Map<String, Object?> cast() {
//     Map<dynamic, dynamic> myMap = {'key': 'value'};
//     Map<String, Object?> convertedMap = myMap.cast<String, Object?>();
//     return convertedMap;
//   }
// }

String contactTable = "contactsTable";
String columnId = "idColumn";
String columnName = "nameColumn";
String columnEmail = "emailColumn";
String columnPhone = "phoneColumn";
String columnImg = "imgColumn";

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? img;

  Contact({
     this.id,
      this.name,
      this.email,
      this.phone,
      this.img});

  Contact.fromMap(Map<String, dynamic> map, {int? id , Object? name, Object? email, Object? phone, Object? img}) {
    id = map[columnId];
    name = map[columnName];
    email = map[columnEmail];
    phone = map[columnPhone];
    img = map[columnImg];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnName: name,
      columnEmail: email,
      columnPhone: phone,
      columnImg: img,
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }

  Map<String, Object?> cast() {
    Map<dynamic, dynamic> myMap = {'key': 'value'};
    Map<String, Object?> convertedMap = myMap.cast<String, Object?>();
    return convertedMap;
  }
}
