import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:contatos/models/contact.dart';

class DatabaseProvider {
  // static final DatabaseProvider _instance = DatabaseProvider.internal();

  // factory DatabaseProvider() => _instance;

  // DatabaseProvider.internal();

  static late Database _database;

  static Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();

    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), "contactsnew.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE $contactTable ("
          "$columnId INTEGER PRIMARY KEY,"
          "$columnName TEXT,"
          "$columnEmail TEXT,"
          "$columnPhone TEXT,"
          "$columnImg TEXT"
          ")",
        );
      },
    );
  }

  // static Future<List<Contact>> getAllContacts1() async {
  //   final dbContact = await database;

  //   final contacts = await dbContact.rawQuery(
  //     "SELECT * FROM $contactTable ORDER BY $columnName ASC",
  //   );

  //   contacts.map((contact) {
  //     Contact.fromMap(
  //       id: contacts[columnId] as int,
  //       name: contact[columnName],
  //       email: contact[columnEmail],
  //       phone: contact[columnPhone],
  //       img: contact[columnImg],
  //     );
  //   });
  //   return contacts;
  // }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await database;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await database;
    List<Map<String, Object?>> maps = await dbContact.query(contactTable,
        columns: [columnId, columnName, columnEmail, columnPhone, columnImg],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> deleteContact(int id) async {
    final dbContact = await database;

    return await dbContact.delete(
      contactTable,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateContact(Contact contact) async {
    final dbContact = await database;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$columnId = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await database;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> contactList = List.empty();
    for (Map<String,dynamic> m in listMap) {
      contactList.add(Contact.fromMap(m));
    }
    return contactList;
  }

  Future getNumbers() async {
    Database dbContact = await database;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT (*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await database;
    return dbContact.close();
  }

  static Future<int> addContact(Contact contact) async {
    final db = await database;

    return db.insert(
      contactTable,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Contact>> searchContacts(String query) async {
    final db = await database;

    var contacts = await db.rawQuery(
      "SELECT * FROM $contactTable WHERE $columnName LIKE '%$query%'",
    );

    return List.generate(contacts.length, (index) {
      final id = contacts[index][columnId] as int;
      final name = contacts[index][columnName] as String;
      final email = contacts[index][columnEmail] as String;
      final phone = contacts[index][columnPhone] as String;
      final img = contacts[index][columnImg] as String;
      return Contact(
        id: id,
        name: name,
        email: email,
        phone: phone,
        img: img,
      );
    });
  }
}
