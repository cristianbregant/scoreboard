import 'package:flutter/material.dart';
import 'package:scoreboard/model/company.dart';

/// Symbols a [CompanyBrand] can use, by key.
const Map<String, IconData> companySymbols = {
  'air': Icons.air_rounded,
  'terrain': Icons.terrain_rounded,
  'orbit': Icons.track_changes_rounded,
  'lumen': Icons.wb_sunny_rounded,
};

/// The company's brand symbol on its brand color, or its initial on the
/// accent color when the company has no brand.
class CompanyLogo extends StatelessWidget {
  final String name;
  final CompanyBrand? brand;
  final double size;

  const CompanyLogo(
      {super.key, required this.name, this.brand, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final symbol = companySymbols[brand?.symbol];

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: brand != null ? Color(brand!.color) : colorScheme.primary,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: symbol != null
          ? Icon(symbol, color: Colors.white, size: size * 0.6)
          : Text(name.isEmpty ? '?' : name[0].toUpperCase(),
              style: TextStyle(
                  color: brand != null ? Colors.white : colorScheme.onPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: size * 0.45)),
    );
  }
}
