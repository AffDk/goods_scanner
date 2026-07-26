import 'product.dart';

class CountryInvolvement {
  final String countryName;
  final double percentage;
  final String? role;

  CountryInvolvement({
    required this.countryName,
    required this.percentage,
    this.role,
  });

  factory CountryInvolvement.fromJson(Map<String, dynamic> json) {
    return CountryInvolvement(
      countryName: json['country'] as String? ?? json['country_name'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'country': countryName,
        'percentage': percentage,
        'role': role,
      };

  @override
  String toString() => '$countryName: ${percentage.toStringAsFixed(1)}% (${role ?? "involved"})';
}

class AnalysisResult {
  final Product? product;
  final List<CountryInvolvement> countries;
  final String? summary;
  final String? benefitingCountry;
  final DateTime analyzedAt;

  AnalysisResult({
    this.product,
    required this.countries,
    this.summary,
    this.benefitingCountry,
    DateTime? analyzedAt,
  }) : analyzedAt = analyzedAt ?? DateTime.now();

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) =>
                  CountryInvolvement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      summary: json['summary'] as String?,
      benefitingCountry: json['benefiting_country'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product?.toJson(),
        'countries': countries.map((c) => c.toJson()).toList(),
        'summary': summary,
        'benefiting_country': benefitingCountry,
        'analyzed_at': analyzedAt.toIso8601String(),
      };
}
