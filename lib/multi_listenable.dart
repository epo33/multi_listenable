library multi_listenable;

import 'package:flutter/widgets.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

class ListenableBuilder extends StatefulWidget {
  const ListenableBuilder({
    super.key,
    required this.listenables,
    required this.builder,
  });

  final Iterable<Listenable> listenables;

  final WidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState<T> extends State<ListenableBuilder> {
  Iterable<Listenable> get listenables => widget.listenables;

  @override
  void initState() {
    super.initState();
    for (final l in listenables) {
      l.addListener(_notified);
    }
  }

  @override
  void didUpdateWidget(ListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldList = oldWidget.listenables.toSet();
    final newList = listenables.toSet();
    if (newList.length == oldList.length &&
        !oldList.any((e) => !newList.contains(e))) return;
    for (final l in oldList) {
      l.removeListener(_notified);
    }
    for (final l in newList) {
      l.addListener(_notified);
    }
  }

  @override
  void dispose() {
    for (final l in listenables) {
      l.removeListener(_notified);
    }
    super.dispose();
  }

  void _notified() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
