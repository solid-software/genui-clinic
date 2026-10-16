/// Where a catalog component comes from.
enum CatalogOrigin({
  /// The name on its filter, e.g. `A2UI basic`.
  required final String label,
}) {
  /// Drawn by this app for briefs.
  medical(label: 'Medical'),

  /// One of GenUI's basic A2UI components.
  basic(label: 'A2UI basic'),
}
