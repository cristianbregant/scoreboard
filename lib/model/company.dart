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

  const Company(
      {required this.id,
      required this.name,
      required this.description,
      required this.industry,
      required this.location,
      required this.foundedYear,
      this.brand});

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
    );
  }
}
