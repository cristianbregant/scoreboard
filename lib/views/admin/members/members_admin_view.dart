import 'package:flutter/material.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/members/members_admin_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MembersAdminView extends BaseStatefulWidget {
  MembersAdminView({super.key}) : super(_MembersAdminViewState());
}

class _MembersAdminViewState extends BaseState<MembersAdminView,
        MembersAdminViewModelContract, MembersAdminState>
    with AdminScreenMessages
    implements MembersAdminViewContract {
  @override
  Future<String?> askInviteEmail(String companyName) => showDialog<String>(
        context: context,
        builder: (_) => _InviteDialog(companyName: companyName),
      );

  @override
  Future<bool> confirmImport(InviteImport import) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => _ImportDialog(import: import),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MembersAdminViewModelContract, MembersAdminState>(
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
                  title: l10n.consoleMembers,
                  subtitle: l10n.membersHint,
                  trailing: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Tooltip(
                        message: l10n.importFormatHint,
                        child: OutlinedButton.icon(
                          onPressed: viewModel.onTapImport,
                          icon: const Icon(LucideIcons.fileSpreadsheet),
                          label: Text(l10n.importCsv),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: viewModel.onTapInvite,
                        icon: const Icon(LucideIcons.userPlus),
                        label: Text(l10n.inviteMember),
                      ),
                    ],
                  ),
                ),
                SectionTitle(l10n.pendingInvites),
                if (vmState.invites.isEmpty)
                  EmptyNote(icon: LucideIcons.mail, message: l10n.invitesEmpty)
                else
                  Card(
                    child: Column(
                      children: [
                        for (final invite in vmState.invites)
                          _buildInviteRow(invite),
                      ],
                    ),
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

  Widget _buildInviteRow(Invite invite) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final expired = invite.isExpiredAt(DateTime.now());
    final code = invite.code;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.surfaceContainerHighest,
        child: Icon(LucideIcons.mail,
            size: 20, color: colorScheme.onSurfaceVariant),
      ),
      title: Text(invite.email),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
                l10n.inviteDetails(
                    invite.invitedByName, formatDate(invite.expiresAt)),
                style: TextStyle(color: colorScheme.onSurfaceVariant)),
            if (expired)
              TagChip(
                  label: l10n.inviteExpired,
                  icon: LucideIcons.clock,
                  color: colorScheme.error),
            // Only in demo mode, where no email carries the code.
            if (code != null && !expired)
              TagChip(label: l10n.inviteCodeChip(code), icon: LucideIcons.key),
          ],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () => viewModel.onResendInvite(invite),
              child: Text(l10n.inviteResend)),
          IconButton(
              tooltip: l10n.inviteRevoke,
              onPressed: () => viewModel.onTapRevokeInvite(invite),
              icon: Icon(LucideIcons.x, color: colorScheme.error)),
        ],
      ),
    );
  }

  Widget _buildMemberRow(UserProfile member) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isYou = member.id == vmState.currentUserId;
    return ListTile(
      leading: UserAvatar(
          initials: member.initials, imagePath: member.avatarPath, radius: 18),
      title: Text(isYou ? '${member.name} ${l10n.youLabel}' : member.name),
      subtitle: Text(
          [member.role, if (member.email.isNotEmpty) member.email].join(' · '),
          style: TextStyle(color: colorScheme.onSurfaceVariant)),
      trailing: Tooltip(
        message: l10n.adminRoleTooltip,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Text(l10n.adminRole,
                  style: TextStyle(color: colorScheme.onSurfaceVariant)),
            ),
            const SizedBox(width: 8),
            Semantics(
              label: '${l10n.adminRole}, ${member.name}',
              child: Switch(
                value: member.isCompanyAdmin,
                onChanged: (value) => viewModel.onToggleAdmin(member, value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// How many people an import will invite, and which lines it leaves out.
class _ImportDialog extends StatelessWidget {
  final InviteImport import;

  const _ImportDialog({required this.import});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final count = import.drafts.length;
    final withTeam = import.drafts.where((d) => d.teamId != null).length;
    return AlertDialog(
      title: Text(l10n.importTitle),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.importSummary(count),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            if (withTeam > 0) ...[
              const SizedBox(height: 4),
              Text(l10n.importWithTeams(withTeam),
                  style: TextStyle(color: colorScheme.onSurfaceVariant)),
            ],
            if (import.problems.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(l10n.importLeftOut(import.problems.length),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final problem in import.problems)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(_describe(l10n, problem),
                            style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurfaceVariant)),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel)),
        FilledButton(
          onPressed: count == 0 ? null : () => Navigator.of(context).pop(true),
          child: Text(l10n.importConfirm(count)),
        ),
      ],
    );
  }

  static String _describe(AppLocalization l10n, InviteImportProblem problem) {
    final value = problem.value ?? '';
    return l10n.importProblemLine(
        problem.line,
        switch (problem.type) {
          InviteProblem.invalidEmail => l10n.importProblemInvalidEmail(value),
          InviteProblem.duplicate => l10n.importProblemDuplicate(value),
          InviteProblem.alreadyMember => l10n.importProblemMember(value),
          InviteProblem.unknownTeam => l10n.importProblemTeam(value),
        });
  }
}

class _InviteDialog extends StatefulWidget {
  final String companyName;

  const _InviteDialog({required this.companyName});

  @override
  State<_InviteDialog> createState() => _InviteDialogState();
}

class _InviteDialogState extends State<_InviteDialog> {
  final _emailController = TextEditingController();

  bool get _isValid => AuthInteractor.isValidEmail(_emailController.text);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isValid) Navigator.of(context).pop(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.inviteDialogTitle),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.inviteDialogBody(widget.companyName)),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: l10n.workEmail,
                  prefixIcon: const Icon(LucideIcons.mail)),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton(
          onPressed: _isValid ? _submit : null,
          child: Text(l10n.inviteSend),
        ),
      ],
    );
  }
}
