import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PapierDatabase {
  PapierDatabase._();
  static final PapierDatabase instance = PapierDatabase._();

  Database? _db;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null) return existing;
    final dir = await getApplicationDocumentsDirectory();
    final db = await openDatabase(
      p.join(dir.path, 'papier.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE titulaires (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            prenom TEXT NOT NULL,
            color INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE documents (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulaire_id INTEGER NOT NULL,
            kind TEXT NOT NULL,
            label TEXT NOT NULL,
            expiration_ms INTEGER NOT NULL,
            notes TEXT NOT NULL DEFAULT '',
            remind_days TEXT NOT NULL DEFAULT '90,30,7',
            archived INTEGER NOT NULL DEFAULT 0,
            FOREIGN KEY (titulaire_id) REFERENCES titulaires (id)
          )
        ''');
      },
    );
    _db = db;
    return db;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
