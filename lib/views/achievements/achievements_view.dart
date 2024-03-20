import 'package:scoreboard/core/routing/dynamic_routes.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/achievements/achievements_contract.dart';

class AchievementsView extends BaseStatefulWidget {
  AchievementsView({Key? key}) : super(_AchievementsViewState(), key: key);
}

class _AchievementsViewState extends BaseState<
    AchievementsView,
    AchievementsViewModelContract,
    AchievementsState> implements AchievementsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AchievementsViewModelContract, AchievementsState>(
        model: viewModel,
        builder: (context, viewModel, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Your achievements",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: vmState.achievements
                          .map((achievement) => InteractiveCard(
                                achievement: achievement,
                                onPressed: () =>
                                    viewModel.onTapAchievement(achievement),
                              ))
                          .toList())
                ],
              ),
            ),
          ));
        });
  }

  @override
  void onTapAchievement(Achievement achievement) {
    Navigator.of(context).pushNamed(RouteNames.achievement,
        arguments: NavigatorArguments(nativeArgument: achievement));
  }
}
