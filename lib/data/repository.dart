import '../domain/models.dart';
import '../domain/presets.dart';
import 'database.dart';

class PapierRepository {
  PapierRepository({PapierDatabase? database})
      : _database = database ?? PapierDatabase.instance;

  final PapierDatabase _database;

  Future<void> ensureDefaultTitulaire() async {
    final rows = await (await _database.database).query('titulaires');
    if (rows.isNotEmpty) return;
    await insertTitulaire(
      Titulaire(id: 0, prenom: 'Moi', colorValue: titulaireColors.first),
    );
  }

  Future<List<Titulaire>> titulaires() async {
    final rows = await (await _database.database).query(
      'titulaires',
      orderBy: 'id ASC',
    );
    return rows.map(_titulaireFromRow).toList();
  }

  Future<int> insertTitulaire(Titulaire titulaire) async {
    return (await _database.database).insert('titulaires', {
      'prenom': titulaire.prenom,
      'color': titulaire.colorValue,
    });
  }

  Future<void> updateTitulaire(Titulaire titulaire) async {
    await (await _database.database).update(
      'titulaires',
      {'prenom': titulaire.prenom, 'color': titulaire.colorValue},
      where: 'id = ?',
      whereArgs: [titulaire.id],
    );
  }

  Future<void> deleteTitulaire(int id) async {
    final db = await _database.database;
    await db.delete('documents', where: 'titulaire_id = ?', whereArgs: [id]);
    await db.delete('titulaires', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PapierDocument>> documents({bool includeArchived = false}) async {
    final rows = await (await _database.database).query(
      'documents',
      where: includeArchived ? null : 'archived = 0',
      orderBy: 'expiration_ms ASC',
    );
    return rows.map(_documentFromRow).toList();
  }

  Future<int> insertDocument(PapierDocument document) async {
    return (await _database.database).insert(
      'documents',
      _documentToRow(document)..remove('id'),
    );
  }

  Future<void> updateDocument(PapierDocument document) async {
    await (await _database.database).update(
      'documents',
      _documentToRow(document)..remove('id'),
      where: 'id = ?',
      whereArgs: [document.id],
    );
  }

  Future<void> deleteDocument(int id) async {
    await (await _database.database).delete(
      'documents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> replaceAll({
    required List<Titulaire> titulaires,
    required List<PapierDocument> documents,
  }) async {
    final db = await _database.database;
    await db.transaction((txn) async {
      await txn.delete('documents');
      await txn.delete('titulaires');
      final idMap = <int, int>{};
      for (final titulaire in titulaires) {
        final newId = await txn.insert('titulaires', {
          'prenom': titulaire.prenom,
          'color': titulaire.colorValue,
        });
        idMap[titulaire.id] = newId;
      }
      for (final document in documents) {
        final mapped = idMap[document.titulaireId];
        if (mapped == null) continue;
        await txn.insert(
          'documents',
          _documentToRow(document.copyWith(titulaireId: mapped))..remove('id'),
        );
      }
    });
  }

  Titulaire _titulaireFromRow(Map<String, Object?> row) {
    return Titulaire(
      id: row['id']! as int,
      prenom: row['prenom']! as String,
      colorValue: row['color']! as int,
    );
  }

  PapierDocument _documentFromRow(Map<String, Object?> row) {
    return PapierDocument(
      id: row['id']! as int,
      titulaireId: row['titulaire_id']! as int,
      kind: DocumentKind.values.byName(row['kind']! as String),
      label: row['label']! as String,
      expiration: DateTime.fromMillisecondsSinceEpoch(
        row['expiration_ms']! as int,
      ),
      notes: row['notes']! as String,
      remindDays: (row['remind_days']! as String)
          .split(',')
          .where((e) => e.isNotEmpty)
          .map(int.parse)
          .toList(),
      archived: (row['archived']! as int) == 1,
    );
  }

  Map<String, Object?> _documentToRow(PapierDocument document) {
    return {
      'id': document.id,
      'titulaire_id': document.titulaireId,
      'kind': document.kind.name,
      'label': document.label,
      'expiration_ms': DateTime(
        document.expiration.year,
        document.expiration.month,
        document.expiration.day,
      ).millisecondsSinceEpoch,
      'notes': document.notes,
      'remind_days': document.remindDays.join(','),
      'archived': document.archived ? 1 : 0,
    };
  }
}
