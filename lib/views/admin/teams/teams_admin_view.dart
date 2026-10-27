import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/teams/teams_admin_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TeamsAdminView extends BaseStatefulWidget {
  TeamsAdminView({super.key}) : super(_TeamsAdminViewState());
}

class _TeamsAdminViewState extends BaseState<TeamsAdminView,
        TeamsAdminViewModelContract, TeamsAdminState>
    with AdminScreenMessages
    implements TeamsAdminViewContract {
  @override
  Future<({String name, String? managerId})?> askTeam(List<UserProfile> members,
          {Team? existing}) =>
      showDialog<({String name, String? managerId})>(
        context: context,
        builder: (_) => _TeamDialog(members: members, existing: existing),
      );

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TeamsAdminViewModelContract, TeamsAdminState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                  title: l10n.consoleTeams,
                  subtitle: l10n.teamsHint,
                  trailing: FilledButton.icon(
                    onPressed: viewModel.onTapNewTeam,
                    icon: const Icon(LucideIcons.plus),
                    label: Text(l10n.newTeam),
                  ),
                ),
                const SizedBox(height: 24),
                if (vmState.teams.isEmpty)
                  EmptyNote(icon: LucideIcons.users, message: l10n.teamsEmpty),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (final team in vmState.teams) _buildTeam(team),
                  ],
                ),
                SectionTitle(l10n.communityPeople),
                Card(
                  child: Column(
                    children: [
                      for (final member in vmState.members)
                        _buildMemberRow(member),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTeam(Team team) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final manager = vmState.manager(team);
    final members = vmState.membersOf(team);
    return SizedBox(
      width: 320,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 8, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(team.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  IconButton(
                      tooltip: l10n.editTeam,
                      onPressed: () => viewModel.onTapEditTeam(team),
                      icon: const Icon(LucideIcons.pencil, size: 20)),
                  IconButton(
                      tooltip: l10n.commonDelete,
                      onPressed: () => viewModel.onTapDeleteTeam(team),
                      icon: Icon(LucideIcons.trash2,
                          size: 20, color: colorScheme.error)),
                ],
              ),
              TagChip(
                  icon: LucideIcons.shieldCheck,
                  color: manager == null ? null : colorScheme.primary,
                  label: manager == null
                      ? l10n.noManager
                      : '${l10n.teamManager}: ${manager.name}'),
              const SizedBox(height: 12),
              Text(l10n.membersCount(members.length),
                  style: TextStyle(
                      fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 8),
              Wrap(
                spacing: -6,
                children: [
                  for (final member in members.take(8))
                    Tooltip(
                      message: member.name,
                      child: UserAvatar(
                          initials: member.initials,
                          imagePath: member.avatarPath,
                          radius: 15),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberRow(UserProfile member) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: UserAvatar(
          initials: member.initials, imagePath: member.avatarPath, radius: 18),
      title: Text(member.name),
      subtitle: Text(member.role,
          style: TextStyle(color: colorScheme.onSurfaceVariant)),
      trailing: SizedBox(
        width: 220,
        child: DropdownButtonFormField<String?>(
          initialValue: member.teamId,
          isExpanded: true,
          decoration: InputDecoration(
              labelText: l10n.memberTeamLabel(member.name), isDense: true),
          items: [
            DropdownMenuItem(value: null, child: Text(l10n.noTeam)),
            for (final team in vmState.teams)
              DropdownMenuItem(value: team.id, child: Text(team.name)),
          ],
          onChanged: (teamId) => viewModel.onMoveMember(member, teamId),
        ),
      ),
    );
  }
}

class _TeamDialog extends StatefulWidget {
  final List<UserProfile> members;
  final Team? existing;

  const _TeamDialog({required this.members, this.existing});

  @override
  State<_TeamDialog> createState() => _TeamDialogState();
}

class _TeamDialogState extends State<_TeamDialog> {
  late final _nameController =
      TextEditingController(text: widget.existing?.name);
  late String? _managerId = widget.existing?.managerId;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(widget.existing == null ? l10n.newTeam : l10n.editTeam),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              maxLength: 60,
              decoration: InputDecoration(labelText: l10n.teamName),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              initialValue: _managerId,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.teamManager),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.noManager)),
                for (final member in widget.members)
                  DropdownMenuItem(value: member.id, child: Text(member.name)),
              ],
              onChanged: (id) => setState(() => _managerId = id),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton(
          onPressed: _nameController.text.trim().isEmpty
              ? null
              : () => Navigator.of(context)
                  .pop((name: _nameController.text, managerId: _managerId)),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
