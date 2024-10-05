import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectsPage extends StatefulWidget {
  const CollectsPage({super.key});

  @override
  State<CollectsPage> createState() => _CollectsPageState();
}

class _CollectsPageState extends State<CollectsPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
