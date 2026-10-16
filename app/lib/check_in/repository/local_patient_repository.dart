import 'dart:convert';

import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/repository/missing_record_exception.dart';
import 'package:clinical_brief/check_in/repository/patient_repository.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/demo/data/seed_patients.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [PatientRepository] keeping every chart on the device as one JSON list.
///
/// The first read adds the demo patients, so even a link opened on a fresh
/// install finds its patient.
class LocalPatientRepository(final SharedPreferencesAsync _preferences)
    implements PatientRepository {
  /// Versioned with the demo data, so a new set never mixes with an old one.
  static const _storageKey = 'clinical_brief.patients.v5';

  /// Keys of earlier demo data sets, removed before the first read.
  static const _retiredKeys = [
    'clinical_brief.patients',
    'clinical_brief.patients.v2',
    'clinical_brief.patients.v3',
    'clinical_brief.patients.v4',
  ];
  static const _idField = 'id';
  static const _patientField = 'patient';
  static const _recordField = 'record';
  final _log = AppLogger.of('LocalPatientRepository');

  /// The first read's [_addMissingDemoPatients], which later reads wait for
  /// too; cleared when it fails, so the next read tries again.
  Future<void>? _seeding;

  /// Creates a repository over the given preferences store.
  this;

  @override
  Future<List<Patient>> fetchPatients() async =>
      (await _documents()).map(_patientFromField).sortedBy((e) => e.slotTime);

  static Patient _patientFromField(Map<String, Object?> document) =>
      Patient.fromJson(document.readObject(_patientField));

  @override
  Future<Patient?> findPatient(String patientId) async =>
      switch (await _documentOf(patientId)) {
        final document? => _patientFromField(document),
        _ => null,
      };

  @override
  Future<ClinicalRecord> fetchRecord(String patientId) async =>
      switch (await _documentOf(patientId)) {
        final document? => ClinicalRecord.fromJson(
          document.readObject(_recordField),
        ),
        _ => throw MissingRecordException(patientId),
      };

  /// Every stored document, once the demo patients are in.
  Future<List<Map<String, Object?>>> _documents() async {
    try {
      await (_seeding ??= _addMissingDemoPatients());
    } on Exception {
      _seeding = null;
      rethrow;
    }

    return _readDocuments();
  }

  /// Adds demo patients missing by id; stored charts are never overwritten.
  Future<void> _addMissingDemoPatients() async {
    for (final key in _retiredKeys) {
      await _preferences.remove(key);
    }
    final stored = await _readDocuments();
    final storedIds = stored
        .map((document) => document.readString(_idField))
        .toSet();
    final missing = SeedPatients.all
        .where((document) => !storedIds.contains(document.readString(_idField)))
        .toList();
    if (missing.isEmpty) {
      return _log.fine(
        'All demo patients already stored, skipping generation.',
      );
    }
    _log.info('Storing ${missing.length} demo patients.');
    await _preferences.setString(
      _storageKey,
      jsonEncode([...stored, ...missing]),
    );
  }

  /// The stored document of [patientId], or `null`.
  Future<Map<String, Object?>?> _documentOf(String patientId) async =>
      (await _documents())
          .where((document) => document.readString(_idField) == patientId)
          .firstOrNull;

  /// What is stored, as it is.
  Future<List<Map<String, Object?>>> _readDocuments() async =>
      switch (await _preferences.getString(_storageKey)) {
        final stored? => switch (jsonDecode(stored)) {
          final List<Object?> decoded =>
            decoded.whereType<Map<String, Object?>>().toList(),
          _ => [],
        },
        _ => [],
      };
}
