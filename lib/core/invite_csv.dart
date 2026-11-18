/// Reads a list of people to invite from a CSV file, the way HR tools and
/// spreadsheets export them: comma, semicolon (Excel in Italian, German,
/// French…) or tab separated, quoted fields, an optional header and an
/// optional UTF-8 byte order mark.
///
/// Columns are found by their header (email, role, team, in the app's
/// languages); without a header they are email, role and team, in order.
class InviteCsv {
  static const _emailHeaders = {'email', 'e-mail', 'mail', 'email address'};
  static const _roleHeaders = {
    'role',
    'ruolo',
    'rolle',
    'rôle',
    'rol',
    'puesto',
    'poste',
    'position',
    'job title',
    'title',
    'mansione',
    'funzione',
    'funktion'
  };
  static const _teamHeaders = {
    'team',
    'squadra',
    'équipe',
    'equipe',
    'equipo',
    'gruppo',
    'reparto',
    'department',
    'abteilung',
    'service',
    'departamento'
  };

  /// Rows found in [text], numbered as in the file (1 is the first line).
  static List<InviteCsvRow> parse(String text) {
    final lines = _records(text.startsWith('﻿') ? text.substring(1) : text)
        .where((r) => r.cells.any((c) => c.trim().isNotEmpty))
        .toList();
    if (lines.isEmpty) return const [];

    var emailColumn = 0, roleColumn = 1, teamColumn = 2;
    var first = 0;
    final header =
        lines.first.cells.map((c) => c.trim().toLowerCase()).toList();
    if (!header.any((c) => c.contains('@'))) {
      // A header: find the columns by name.
      first = 1;
      int find(Set<String> names) => header.indexWhere(names.contains);
      emailColumn = find(_emailHeaders);
      roleColumn = find(_roleHeaders);
      teamColumn = find(_teamHeaders);
      if (emailColumn == -1) {
        emailColumn = header.indexWhere((c) => c.contains('mail'));
      }
    }

    String? cell(List<String> cells, int column) {
      if (column < 0 || column >= cells.length) return null;
      final value = cells[column].trim();
      return value.isEmpty ? null : value;
    }

    return [
      for (final record in lines.skip(first))
        InviteCsvRow(
          line: record.line,
          email: cell(record.cells, emailColumn)?.toLowerCase() ?? '',
          role: cell(record.cells, roleColumn),
          team: cell(record.cells, teamColumn),
        ),
    ];
  }

  /// Splits [text] into records, honoring quotes (which may hold
  /// separators, quotes doubled as `""` and line breaks).
  static List<({int line, List<String> cells})> _records(String text) {
    final separator = _separator(text);
    final records = <({int line, List<String> cells})>[];
    var cells = <String>[];
    final cell = StringBuffer();
    var quoted = false;
    var line = 1;
    var recordLine = 1;

    void endCell() {
      cells.add(cell.toString());
      cell.clear();
    }

    void endRecord() {
      endCell();
      records.add((line: recordLine, cells: cells));
      cells = [];
    }

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (quoted) {
        if (char == '"') {
          if (i + 1 < text.length && text[i + 1] == '"') {
            cell.write('"');
            i++;
          } else {
            quoted = false;
          }
        } else {
          if (char == '\n') line++;
          cell.write(char);
        }
      } else if (char == '"') {
        quoted = true;
      } else if (char == separator) {
        endCell();
      } else if (char == '\n' || char == '\r') {
        if (char == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
        endRecord();
        line++;
        recordLine = line;
      } else {
        cell.write(char);
      }
    }
    if (cell.isNotEmpty || cells.isNotEmpty) endRecord();
    return records;
  }

  /// The separator used most on the first line, outside quotes.
  static String _separator(String text) {
    final firstLine = text.split(RegExp(r'\r?\n')).first;
    var best = ',';
    var bestCount = 0;
    for (final candidate in [',', ';', '\t']) {
      final count = candidate.allMatches(firstLine).length;
      if (count > bestCount) {
        best = candidate;
        bestCount = count;
      }
    }
    return best;
  }
}

/// One person from an import file; [email] is lowercased, the rest as
/// written.
class InviteCsvRow {
  final int line;
  final String email;
  final String? role;
  final String? team;

  const InviteCsvRow(
      {required this.line, required this.email, this.role, this.team});
}
