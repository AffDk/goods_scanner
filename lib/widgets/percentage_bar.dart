import 'package:flutter/material.dart';

class PercentageBar extends StatelessWidget {
  final double percentage;

  const PercentageBar({super.key, required this.percentage});

  Color _color(double pct) {
    if (pct >= 50) return Colors.green;
    if (pct >= 25) return Colors.orange;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: percentage / 100,
        minHeight: 12,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation(_color(percentage)),
      ),
    );
  }
}
