import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/achievement/achievement_contract.dart';

class AchievementView extends BaseStatefulWidget {
  final Achievement achievement;
  AchievementView({Key? key, required this.achievement})
      : super(_AchievementViewState(), key: key);
}

class _AchievementViewState extends BaseState<
    AchievementView,
    AchievementViewModelContract,
    AchievementState> implements AchievementViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AchievementViewModelContract, AchievementState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: Column(
                children: [
                  const SizedBox(height: 28),
                  const Row(
                    children: [BackButton()],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: InteractiveCard(
                              achievement: widget.achievement,
                              onPressed: () {}),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: WelcomeDeployerColors.sidebarBackgroundColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Achievement: ${widget.achievement.name}"),
                              Text(
                                  "Description: ${widget.achievement.description}"),
                              Text("Date: ${widget.achievement.date}"),
                              Text("Points: ${widget.achievement.points}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ));
            }));
  }
}
