import 'package:flutter/material.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/seasons/seasons_admin_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SeasonsAdminView extends BaseStatefulWidget {
  SeasonsAdminView({super.key}) : super(_SeasonsAdminViewState());
}

class _SeasonsAdminViewState extends BaseState<SeasonsAdminView,
        SeasonsAdminViewModelContract, SeasonsAdminState>
    with AdminScreenMessages
    implements SeasonsAdminViewContract {
  @override
  Future<SeasonDraft?> askSeason({Season? existing}) => showDialog<SeasonDraft>(
        context: context,
        builder: (_) => _SeasonDialog(existing: existing),
      );

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SeasonsAdminViewModelContract, SeasonsAdminState>(
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
                  title: l10n.consoleSeasons,
                  subtitle: l10n.seasonsHint,
                  trailing: FilledButton.icon(
                    onPressed: viewModel.onTapNewSeason,
                    icon: const Icon(LucideIcons.plus),
                    label: Text(l10n.newSeason),
                  ),
                ),
                const SizedBox(height: 24),
                if (vmState.seasons.isEmpty)
                  EmptyNote(icon: LucideIcons.flag, message: l10n.seasonsEmpty),
                for (final season in vmState.seasons) _buildSeason(season),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSeason(Season season) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final status = season.statusAt(DateTime.now());
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
          title: Row(
            children: [
              Flexible(
                child: Text(season.name,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 10),
              switch (status) {
                SeasonStatus.active => TagChip(
                    label: l10n.seasonActive,
                    icon: LucideIcons.circlePlay,
                    color: colorScheme.primary),
                SeasonStatus.upcoming =>
                  TagChip(label: l10n.seasonUpcoming, icon: LucideIcons.clock),
                SeasonStatus.ended =>
                  TagChip(label: l10n.seasonEnded, icon: LucideIcons.flag),
              },
            ],
          ),
          subtitle: Text(l10n.seasonRange(
              formatDate(season.start), formatDate(season.end))),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  tooltip: l10n.editSeason,
                  onPressed: () => viewModel.onTapEditSeason(season),
                  icon: const Icon(LucideIcons.pencil, size: 20)),
              IconButton(
                  tooltip: l10n.commonDelete,
                  onPressed: () => viewModel.onTapDeleteSeason(season),
                  icon: Icon(LucideIcons.trash2,
                      size: 20, color: colorScheme.error)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeasonDialog extends StatefulWidget {
  final Season? existing;

  const _SeasonDialog({this.existing});

  @override
  State<_SeasonDialog> createState() => _SeasonDialogState();
}

class _SeasonDialogState extends State<_SeasonDialog> {
  late final _nameController =
      TextEditingController(text: widget.existing?.name);
  late DateTimeRange? _range = widget.existing == null
      ? null
      : DateTimeRange(start: widget.existing!.start, end: widget.existing!.end);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDates() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDateRange: _range,
    );
    if (range != null) setState(() => _range = range);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final range = _range;
    return AlertDialog(
      title: Text(widget.existing == null ? l10n.newSeason : l10n.editSeason),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              maxLength: 40,
              decoration: InputDecoration(
                  labelText: l10n.seasonName, hintText: l10n.seasonNameHint),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Text(l10n.seasonDates,
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _pickDates,
              icon: const Icon(LucideIcons.calendarRange),
              label: Text(range == null
                  ? l10n.pickDates
                  : l10n.seasonRange(
                      formatDate(range.start), formatDate(range.end))),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton(
          onPressed: _nameController.text.trim().isEmpty || range == null
              ? null
              : () => Navigator.of(context).pop(SeasonDraft(
                  name: _nameController.text,
                  start: range.start,
                  end: range.end)),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
