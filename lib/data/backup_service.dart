import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/models.dart';
import 'repository.dart';

class BackupService {
  BackupService(this._repository);

  final PapierRepository _repository;

  Future<void> exportJson() async {
    final titulaires = await _repository.titulaires();
    final documents = await _repository.documents(includeArchived: true);
    final payload = jsonEncode({
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'titulaires': titulaires.map((e) => e.toJson()).toList(),
      'documents': documents.map((e) => e.toJson()).toList(),
    });
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/echeances-papier.json');
    await file.writeAsString(payload);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        subject: 'Export Échéances',
      ),
    );
  }

  Future<bool> importJson() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return false;
    final bytes = result.files.single.bytes;
    final content = bytes != null
        ? utf8.decode(bytes)
        : await File(result.files.single.path!).readAsString();
    final decoded = jsonDecode(content) as Map<String, dynamic>;
    final titulaires = (decoded['titulaires'] as List<dynamic>)
        .map((e) => Titulaire.fromJson(Map<String, Object?>.from(e as Map)))
        .toList();
    final documents = (decoded['documents'] as List<dynamic>)
        .map(
          (e) => PapierDocument.fromJson(Map<String, Object?>.from(e as Map)),
        )
        .toList();
    if (titulaires.isEmpty) return false;
    await _repository.replaceAll(titulaires: titulaires, documents: documents);
    return true;
  }
}
