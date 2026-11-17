import 'package:flutter/material.dart';
import 'data/favorites_database.dart';
import 'data/hero_api_service.dart';
import 'data/hero_repository.dart';
import 'l10n/app_localizations.dart';
import 'screens/catalog_screen.dart';
import 'state/heroes_controller.dart';

void main() => runApp(const MarvelHeroesApp());

class MarvelHeroesApp extends StatefulWidget {
  const MarvelHeroesApp({super.key, this.locale});
  final Locale? locale;
  @override
  State<MarvelHeroesApp> createState() => _MarvelHeroesAppState();
}

class _MarvelHeroesAppState extends State<MarvelHeroesApp> {
  late final HeroRepository repository = HeroRepository(FavoritesDatabase(), HeroApiService());
  late final HeroesController controller = HeroesController(repository)..loadFavorites();

  @override
  void dispose() {
    controller.dispose();
    repository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'MarvelHeroes UD3', debugShowCheckedModeBanner: false,
    locale: widget.locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: ThemeData(useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff33458f)),
      scaffoldBackgroundColor: const Color(0xfff5f6fa)),
    home: CatalogScreen(controller: controller),
  );
}
