import 'package:flutter/material.dart';
import '../model/hero_item.dart';
import '../state/heroes_controller.dart';
import '../widgets/hero_stats.dart';
import '../l10n/app_localizations.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.hero, required this.controller});
  final HeroItem hero;
  final HeroesController controller;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.controller.loadExtra(widget.hero.id);
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final t = AppLocalizations.of(context)!;
      final id = widget.hero.id;
      final extra = widget.controller.extras[id];
      final error = widget.controller.extraErrors[id];
      return Scaffold(appBar: AppBar(title: Text(widget.hero.name)),
        body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
          child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 640),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Image.asset(widget.hero.image, height: 230, semanticLabel: widget.hero.name),
              const SizedBox(height: 16),
              Text(widget.hero.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 12),
              HeroStats(power: widget.hero.power, intelligence: widget.hero.intelligence),
              const Divider(height: 32),
              const Text('Información remota HTTPS'),
              if (widget.controller.loadingExtra.contains(id))
                const LinearProgressIndicator(key: ValueKey('api-loading')),
              if (extra != null) Text('${extra.team}: ${extra.extraInfo}',
                key: const ValueKey('api-data')),
              if (error != null) ...[
                Text('No se pudo cargar: $error', key: const ValueKey('api-error')),
                TextButton(onPressed: () => widget.controller.loadExtra(id),
                  child: const Text('Reintentar')),
              ],
              const SizedBox(height: 12),
              FilledButton.icon(key: const ValueKey('detail-action'),
                onPressed: () => Navigator.pop(context, true),
                icon: Icon(widget.controller.isFavorite(id) ? Icons.favorite : Icons.favorite_border),
                label: Text(widget.controller.isFavorite(id) ? t.removeFavorite : t.addFavorite)),
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.back)),
            ]))))));
    },
  );
}
