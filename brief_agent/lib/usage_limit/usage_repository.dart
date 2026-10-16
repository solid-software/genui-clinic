import 'package:brief_agent/usage_limit/models/usage.dart';
import 'package:google_cloud_firestore/google_cloud_firestore.dart';

/// Each user's [Usage], stored in `usage/{uid}`.
class const UsageRepository(final Firestore _firestore) {
  static const _collection = 'usage';

  /// Creates a repository over [_firestore].
  this;

  /// Updates [uid]'s usage in a transaction.
  Future<void> update(String uid, Usage Function(Usage usage) change) =>
      _firestore.runTransaction((tx) async {
        final document = _firestore.doc('$_collection/$uid');
        final snapshot = await tx.get(document);
        final usage = Usage.fromJson(snapshot.data());

        final updatedUsage = change(usage);
        tx.set(document, updatedUsage.toJson());
      });
}
