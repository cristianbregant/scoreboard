import 'package:flutter/material.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/localization_manager.dart';
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
  Widget build(BuildContext context) {
    return BaseWidget<MembersAdminViewModelContract, MembersAdminState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            final colorScheme = Theme.of(context).colorScheme;
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                  title: l10n.consoleMembers,
                  subtitle: l10n.membersHint,
                  trailing: FilledButton.icon(
                    onPressed: viewModel.onTapInvite,
                    icon: const Icon(Icons.person_add_alt_1_outlined),
                    label: Text(l10n.inviteMember),
                  ),
                ),
                SectionTitle(l10n.pendingInvites),
                if (vmState.invites.isEmpty)
                  Text(l10n.invitesEmpty,
                      style: TextStyle(color: colorScheme.onSurfaceVariant))
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
        child: Icon(Icons.mail_outline_rounded,
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
                  icon: Icons.schedule_rounded,
                  color: colorScheme.error),
            // Only in demo mode, where no email carries the code.
            if (code != null && !expired)
              TagChip(
                  label: l10n.inviteCodeChip(code), icon: Icons.key_rounded),
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
              icon: Icon(Icons.close_rounded, color: colorScheme.error)),
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
                  prefixIcon: const Icon(Icons.mail_outline_rounded)),
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
