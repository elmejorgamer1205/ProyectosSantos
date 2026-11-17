import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
class HeroStats extends StatelessWidget {
  const HeroStats({super.key, required this.power, required this.intelligence});
  final int power;
  final int intelligence;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Padding(padding: const EdgeInsets.all(12), child: Wrap(spacing: 8, children: [
      Chip(label: Text('${t.power}: $power')),
      Chip(label: Text('${t.intelligence}: $intelligence')),
    ]));
  }
}
