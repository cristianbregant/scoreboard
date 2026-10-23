import 'package:scoreboard/views/community/community_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/leaderboard_tile.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/podium.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';

class CommunityView extends BaseStatefulWidget {
  CommunityView({
    Key? key,
  }) : super(_CommunityViewState(), key: key);
}

class _CommunityViewState
    extends BaseState<CommunityView, CommunityViewModelContract, CommunityState>
    implements CommunityViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommunityViewModelContract, CommunityState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: pagePadding.copyWith(bottom: 0),
                    child: Column(
                      children: [
                        PageHeader(
                          title: "Community",
                          subtitle: "See how you rank against everyone else",
                          trailing: SegmentedButton<CommunityTab>(
                            showSelectedIcon: false,
                            segments: const [
                              ButtonSegment(
                                  value: CommunityTab.people,
                                  icon: Icon(Icons.person_rounded),
                                  label: Text("People")),
                              ButtonSegment(
                                  value: CommunityTab.companies,
                                  icon: Icon(Icons.business_rounded),
                                  label: Text("Companies")),
                            ],
                            selected: {vmState.tab},
                            onSelectionChanged: (selection) =>
                                viewModel.onChangeTab(selection.first),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          onChanged: viewModel.onSearchChanged,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded),
                            hintText: vmState.tab == CommunityTab.people
                                ? "Search by name, role or company"
                                : "Search by name or industry",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ContentStateView(
                      state: vmState,
                      onRetry: viewModel.loadLeaderboards,
                      builder: (context) => vmState.tab == CommunityTab.people
                          ? _buildPeople()
                          : _buildCompanies(),
                    ),
                  ),
                ],
              ));
            }));
  }

  bool get _showPodium => vmState.query.trim().isEmpty;

  Widget _buildPeople() {
    final entries = vmState.filteredUsers;
    if (entries.isEmpty) return _buildEmpty();
    return ListView(
      padding: pagePadding.copyWith(top: 8),
      children: [
        if (_showPodium) ...[
          const SectionTitle("Top 3"),
          Podium(
            entries: entries
                .take(3)
                .map((entry) => PodiumEntry(
                      avatar: UserAvatar(
                          initials: entry.user.initials,
                          imagePath: entry.user.avatarPath,
                          radius: 26),
                      title: entry.user.name,
                      subtitle: entry.company.name,
                      points: entry.points,
                    ))
                .toList(),
          ),
          const SectionTitle("Leaderboard"),
        ] else
          const SizedBox(height: 16),
        ...entries.map((entry) => LeaderboardTile(
              rank: entry.rank,
              leading: UserAvatar(
                  initials: entry.user.initials,
                  imagePath: entry.user.avatarPath),
              title: entry.user.id == vmState.currentUserId
                  ? "${entry.user.name} (you)"
                  : entry.user.name,
              subtitle:
                  "${entry.user.role} at ${entry.company.name} · ${entry.achievementsCount} achievements",
              points: entry.points,
              highlighted: entry.user.id == vmState.currentUserId,
            )),
      ],
    );
  }

  Widget _buildCompanies() {
    final entries = vmState.filteredCompanies;
    if (entries.isEmpty) return _buildEmpty();
    return ListView(
      padding: pagePadding.copyWith(top: 8),
      children: [
        if (_showPodium) ...[
          const SectionTitle("Top 3"),
          Podium(
            entries: entries
                .take(3)
                .map((entry) => PodiumEntry(
                      avatar: CompanyLogo(
                          name: entry.company.name,
                          brand: entry.company.brand,
                          size: 52),
                      title: entry.company.name,
                      subtitle: entry.company.industry,
                      points: entry.points,
                    ))
                .toList(),
          ),
          const SectionTitle("Leaderboard"),
        ] else
          const SizedBox(height: 16),
        ...entries.map((entry) => LeaderboardTile(
              rank: entry.rank,
              leading: CompanyLogo(
                  name: entry.company.name, brand: entry.company.brand),
              title: entry.company.name,
              subtitle:
                  "${entry.company.industry} · ${entry.membersCount} members · ${entry.achievementsCount} achievements",
              points: entry.points,
              highlighted: entry.company.id == vmState.currentCompanyId,
            )),
      ],
    );
  }

  Widget _buildEmpty() {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 40, color: colorScheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text("No results match your search.",
              style: TextStyle(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
