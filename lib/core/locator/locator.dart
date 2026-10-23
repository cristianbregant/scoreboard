import 'package:get_it/get_it.dart';

import 'package:scoreboard/core/locator/locator_objects.dart';
import 'package:scoreboard/core/locator/locator_views.dart';
import 'package:scoreboard/core/locator/locator_interactors.dart';
import 'package:scoreboard/core/locator/locator_states.dart';
import 'package:scoreboard/core/locator/locator_view_models.dart';

GetIt getIt = GetIt.instance;

void setupLocator({bool isTesting = false, bool isIntegrationTesting = false}) {
  setupLocatorObjects();
  setupLocatorViews();
  setupLocatorInteractors();
  setupLocatorStates();
  setupLocatorViewModels();
}
