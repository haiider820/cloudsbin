/// Standard list envelope from FLUTTER_API_GUIDE §5:
/// `{items:[...], page, per_page, total, has_more}`.
class Paged<T> {
  const Paged({
    required this.items,
    required this.page,
    required this.perPage,
    required this.total,
    required this.hasMore,
  });

  final List<T> items;
  final int page;
  final int perPage;
  final int total;
  final bool hasMore;

  static Paged<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemFromJson,
  ) {
    final rawItems = (json['items'] as List<dynamic>? ?? const []);
    return Paged<T>(
      items: rawItems
          .whereType<Map<dynamic, dynamic>>()
          .map((e) => itemFromJson(e.cast<String, dynamic>()))
          .toList(growable: false),
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? rawItems.length,
      total: (json['total'] as num?)?.toInt() ?? rawItems.length,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }

  static Paged<T> empty<T>() =>
      Paged<T>(items: const [], page: 1, perPage: 0, total: 0, hasMore: false);
}
