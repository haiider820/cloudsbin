import 'package:flutter/material.dart';

import '../../core/api/api_error.dart';
import '../../core/theme/app_colors.dart';
import '../models/paged.dart';
import 'app_state_widgets.dart';
import 'empty_state.dart';
import 'error_snackbar.dart';

typedef PageFetcher<T> = Future<Paged<T>> Function(int page);
typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

/// Infinite-scroll + pull-to-refresh list over the standard
/// `{items, page, per_page, total, has_more}` envelope.
///
/// Restyled: shimmer loading, branded error view, pull-to-refresh.
class PaginatedList<T> extends StatefulWidget {
  const PaginatedList({
    super.key,
    required this.fetcher,
    required this.itemBuilder,
    this.emptyState,
    this.padding = const EdgeInsets.all(16),
    this.separator,
  });

  final PageFetcher<T> fetcher;
  final ItemBuilder<T> itemBuilder;
  final Widget? emptyState;
  final EdgeInsets padding;
  final Widget? separator;

  @override
  State<PaginatedList<T>> createState() => _PaginatedListState<T>();
}

class _PaginatedListState<T> extends State<PaginatedList<T>> {
  final ScrollController _controller = ScrollController();
  final List<T> _items = [];

  int _page = 0;
  bool _loading = false;
  bool _hasMore = true;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _load(reset: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading || !_hasMore) return;
    final threshold = _controller.position.maxScrollExtent - 300;
    if (_controller.position.pixels >= threshold) {
      _load();
    }
  }

  Future<void> _load({bool reset = false}) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      if (reset) {
        _error = null;
        _hasMore = true;
      }
    });

    try {
      final nextPage = reset ? 1 : _page + 1;
      final result = await widget.fetcher(nextPage);
      if (!mounted) return;
      setState(() {
        if (reset) _items.clear();
        _items.addAll(result.items);
        _page = result.page;
        _hasMore = result.hasMore;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      final error = e is ApiError ? e : null;
      setState(() {
        if (reset) _items.clear();
        _error = error;
      });
      if (!reset || _items.isNotEmpty) {
        showErrorSnackBar(context, e);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty && _loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: AppShimmer(itemCount: 5),
      );
    }
    if (_items.isEmpty && _error != null) {
      return AppErrorView(
        message: _error!.userMessage,
        onRetry: () => _load(reset: true),
      );
    }
    if (_items.isEmpty) {
      return RefreshIndicator(
        color: AppColors.accent,
        backgroundColor: AppColors.bg2,
        onRefresh: () => _load(reset: true),
        child: ListView(
          controller: _controller,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: widget.emptyState ??
                  const EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'Nothing here yet',
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.accent,
      backgroundColor: AppColors.bg2,
      onRefresh: () => _load(reset: true),
      child: ListView.separated(
        controller: _controller,
        padding: widget.padding,
        itemCount: _items.length + (_hasMore ? 1 : 0),
        separatorBuilder: (context, index) =>
            widget.separator ?? const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(strokeWidth: 2.6),
                ),
              ),
            );
          }
          return widget.itemBuilder(context, _items[index]);
        },
      ),
    );
  }
}
