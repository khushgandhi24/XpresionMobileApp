import 'package:flutter/material.dart';

class ReportTile extends StatefulWidget {
  const ReportTile({super.key});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width * 0.9,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
