import 'package:brief_agent/usage_limit/models/usage_limit.dart';
import 'package:brief_agent/usage_limit/usage_repository.dart';

/// Applies a usage limit to a user's requests.
class const UsageLimitEnforcer(final UsageRepository _usages) {
  /// Creates an enforcer over [_usages].
  this;

  /// Counts one request for [uid], or throws if a limit is reached.
  Future<void> gate(String uid) => _usages.update(uid, (stored) {
    final now = DateTime.now();
    final usage = stored.at(now);

    for (final limit in UsageLimit.values) {
      limit.admit(usage, now);
    }

    return usage.increment();
  });
}
