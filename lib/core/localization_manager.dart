import 'package:scoreboard/generated/l10n.dart';

import 'locator/locator.dart';

AppLocalization get l10n {
  try {
    return getIt<AppLocalization>();
  } catch (_) {
    return AppLocalization();
  }
}
