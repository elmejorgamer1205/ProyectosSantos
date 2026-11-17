import 'package:flutter/material.dart';

import 'app_texts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.playerName,
    required this.total,
    required this.rollCount,
  });

  final String playerName;
  final int total;
  final int rollCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.result)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.player(playerName)),
              const SizedBox(height: 12),
              Text(AppTexts.rolls(rollCount)),
              const SizedBox(height: 12),
              Text(AppTexts.total(total)),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(AppTexts.back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
