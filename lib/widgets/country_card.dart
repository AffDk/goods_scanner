import 'package:flutter/material.dart';
import '../models/country_involvement.dart';
import 'percentage_bar.dart';

class CountryCard extends StatelessWidget {
  final CountryInvolvement country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  country.countryName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${country.percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            if (country.role != null) ...[
              const SizedBox(height: 4),
              Text(
                country.role!,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 8),
            PercentageBar(percentage: country.percentage),
          ],
        ),
      ),
    );
  }
}
