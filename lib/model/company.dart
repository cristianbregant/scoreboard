/// Visual identity of a company: a symbol and a brand color.
class CompanyBrand {
  /// Key of the symbol, see `companySymbols`.
  final String symbol;

  /// ARGB brand color.
  final int color;

  const CompanyBrand({required this.symbol, required this.color});

  factory CompanyBrand.fromJson(Map<String, dynamic> json) {
    return CompanyBrand(symbol: json['symbol'], color: json['color']);
  }

  Map<String, dynamic> toJson() => {'symbol': symbol, 'color': color};
}

class Company {
  final String id;
  final String name;
  final String description;
  final String industry;
  final String location;
  final int foundedYear;
  final CompanyBrand? brand;

  /// Mirrors [CompanySettings.individualRankings]: false keeps the
  /// company's people out of every individual leaderboard.
  final bool individualRankings;

  /// Mirrors [CompanySettings.recognitionGaps].
  final bool recognitionGaps;

  const Company(
      {required this.id,
      required this.name,
      required this.description,
      required this.industry,
      required this.location,
      required this.foundedYear,
      this.brand,
      this.individualRankings = true,
      this.recognitionGaps = true});

  /// This company with the privacy switches of its settings.
  Company withPrivacy(
          {required bool individualRankings, required bool recognitionGaps}) =>
      Company(
          id: id,
          name: name,
          description: description,
          industry: industry,
          location: location,
          foundedYear: foundedYear,
          brand: brand,
          individualRankings: individualRankings,
          recognitionGaps: recognitionGaps);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      industry: json['industry'],
      location: json['location'],
      foundedYear: json['founded_year'],
      brand:
          json['brand'] != null ? CompanyBrand.fromJson(json['brand']) : null,
      individualRankings: json['individual_rankings'] ?? true,
      recognitionGaps: json['recognition_gaps'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'industry': industry,
        'location': location,
        'founded_year': foundedYear,
        'brand': brand?.toJson(),
        'individual_rankings': individualRankings,
        'recognition_gaps': recognitionGaps,
      };
}
