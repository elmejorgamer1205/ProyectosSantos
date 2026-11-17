import 'package:flutter/foundation.dart';
import '../data/hero_repository.dart';
import '../model/hero_extra.dart';

class HeroesController extends ChangeNotifier {
  HeroesController(this.repository);
  final HeroRepository repository;

  Set<String> favorites = {};
  bool loadingFavorites = true;
  String? favoritesError;
  final Map<String, HeroExtra> extras = {};
  final Set<String> loadingExtra = {};
  final Map<String, String> extraErrors = {};

  bool isFavorite(String id) => favorites.contains(id);

  Future<void> loadFavorites() async {
    loadingFavorites = true;
    favoritesError = null;
    notifyListeners();
    try {
      favorites = await repository.favorites();
    } catch (error) {
      favoritesError = 'No se pudo leer SQLite: $error';
    } finally {
      loadingFavorites = false;
      notifyListeners();
    }
  }

  Future<void> setFavorite(String id, bool selected) async {
    if (selected) {
      await repository.saveFavorite(id);
      favorites = {...favorites, id};
    } else {
      await repository.deleteFavorite(id);
      favorites = {...favorites}..remove(id);
    }
    notifyListeners();
  }

  Future<void> loadExtra(String id) async {
    loadingExtra.add(id);
    extraErrors.remove(id);
    notifyListeners();
    try {
      extras[id] = await repository.extra(id);
    } catch (error) {
      extraErrors[id] = error.toString();
    } finally {
      loadingExtra.remove(id);
      notifyListeners();
    }
  }
}
