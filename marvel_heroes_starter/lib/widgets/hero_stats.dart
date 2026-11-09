import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class HeroStats extends StatelessWidget{
  const HeroStats({super.key, required this.power, required this.intelligence});

  final int power;
  final int intelligence;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        Chip(
          avatar: const Icon(Icons.flash_on, size: 18,),
          label: Text('${t.power}: $power'),
        ),
        Chip(
          avatar: const Icon(Icons.psychology, size: 18,),
          label: Text('${t.intelligence}: $intelligence'),
        )
      ],
    );
  }
}
