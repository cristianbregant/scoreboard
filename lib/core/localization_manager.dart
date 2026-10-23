import 'package:flutter/widgets.dart';
import 'package:scoreboard/generated/l10n.dart';

/// Strings of the current locale, for code without a [BuildContext] such as
/// view models. Widgets should use [L10nContext.l10n], which rebuilds them
/// when the language changes.
AppLocalization get l10n => AppLocalization.current;

extension L10nContext on BuildContext {
  AppLocalization get l10n => AppLocalization.of(this);
}
