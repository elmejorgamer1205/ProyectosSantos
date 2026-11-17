import 'package:flutter/material.dart';
import '../data/heroes.dart';
import '../data/hero_api_service.dart';
import '../model/hero_item.dart';
import '../state/heroes_controller.dart';
import '../state/motion_picker.dart';
import '../widgets/hero_card.dart';
import '../l10n/app_localizations.dart';
import 'detail_screen.dart';
import 'peer_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.controller});
  final HeroesController controller;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final MotionPicker motion = MotionPicker();
  String query = '';
  int destination = 0;
  String sensorMessage = 'Sensor pendiente de activar';
  bool sensorActive = false;

  @override
  void dispose() {
    motion.stop();
    super.dispose();
  }

  void startSensor() {
    if (sensorActive) return;
    setState(() {
      sensorActive = true;
      sensorMessage = 'Agita el móvil para elegir un héroe';
    });
    try {
      motion.start((hero) {
        if (mounted) {
          setState(() => sensorMessage = 'Elegido al agitar: ${hero.name}');
        }
      }, (error) {
        if (mounted) {
          setState(() {
            sensorActive = false;
            sensorMessage = 'Sensor no disponible: $error';
          });
        }
      });
    } catch (error) {
      setState(() {
        sensorActive = false;
        sensorMessage = 'Sensor no disponible: $error';
      });
    }
  }

  Future<void> changeFavorite(HeroItem hero) async {
    final t = AppLocalizations.of(context)!;
    final favorite = widget.controller.isFavorite(hero.id);
    if (favorite) {
      final confirmed = await showDialog<bool>(context: context,
        builder: (context) => AlertDialog(title: Text(t.confirmTitle), content: Text(t.confirmMessage),
          actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
            FilledButton(key: const ValueKey('confirm-remove'),
              onPressed: () => Navigator.pop(context, true), child: Text(t.remove))]));
      if (!mounted || confirmed != true) {
        return;
      }
    }
    try {
      await widget.controller.setFavorite(hero.id, !favorite);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo guardar en SQLite: $error')));
      }
    }
  }

  Future<void> open(HeroItem hero) async {
    final changed = await Navigator.push<bool>(context, MaterialPageRoute(
      builder: (_) => DetailScreen(hero: hero, controller: widget.controller)));
    if (!mounted || changed != true) return;
    await changeFavorite(hero);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final t = AppLocalizations.of(context)!;
      final shown = heroes.where((hero) =>
        (destination == 0 || widget.controller.isFavorite(hero.id)) &&
        hero.name.toLowerCase().contains(query.trim().toLowerCase())).toList();
      return Scaffold(
        appBar: AppBar(title: const Text('MarvelHeroes'), actions: [
          IconButton(tooltip: 'Activar sensor', onPressed: startSensor,
            icon: const Icon(Icons.sensors)),
          IconButton(tooltip: 'Intercambio Wi-Fi',
            onPressed: () => Navigator.push(context,
              MaterialPageRoute<void>(builder: (_) => const PeerScreen())),
            icon: const Icon(Icons.wifi)),
        ]),
        body: SafeArea(child: Column(children: [
          if (HeroApiService.useSample) const MaterialBanner(
            content: Text('Datos remotos de muestra; no se está consultando Supabase'),
            actions: [SizedBox.shrink()]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(sensorMessage, key: const ValueKey('sensor-status'))),
          if (widget.controller.loadingFavorites) const LinearProgressIndicator(),
          if (widget.controller.favoritesError case final message?)
            Text(message, style: const TextStyle(color: Colors.red)),
          Padding(padding: const EdgeInsets.all(12), child: TextField(
            key: const ValueKey('search'),
            decoration: InputDecoration(labelText: t.search,
              prefixIcon: const Icon(Icons.search), border: const OutlineInputBorder()),
            onChanged: (value) => setState(() => query = value))),
          Expanded(child: shown.isEmpty
            ? Center(child: Padding(padding: const EdgeInsets.all(24),
                child: Text(destination == 1 && widget.controller.favorites.isEmpty
                  ? t.noFavorites : t.noResults)))
            : LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth <= 16) return const SizedBox.shrink();
                final columns = constraints.maxWidth >= 600 ? 2 : 1;
                return SingleChildScrollView(key: const ValueKey('catalog-scroll'),
                  padding: const EdgeInsets.all(8), child: Wrap(children: [
                    for (final hero in shown)
                      SizedBox(width: (constraints.maxWidth - 16) / columns,
                        child: HeroCard(hero: hero,
                          favorite: widget.controller.isFavorite(hero.id),
                          onOpen: () => open(hero),
                          onFavorite: () => changeFavorite(hero))),
                  ]));
              })),
        ])),
        bottomNavigationBar: NavigationBar(selectedIndex: destination,
          onDestinationSelected: (value) => setState(() => destination = value),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.grid_view), label: t.catalog),
            NavigationDestination(icon: const Icon(Icons.favorite), label: t.favorites),
          ]),
      );
    },
  );
}
