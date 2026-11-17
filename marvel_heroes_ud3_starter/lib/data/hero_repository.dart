import '../model/hero_extra.dart';
import 'favorites_database.dart';
import 'hero_api_service.dart';

class HeroRepository {
  HeroRepository(this.database, this.api);
  final FavoritesDatabase database;
  final HeroApiService api;

  Future<Set<String>> favorites() => database.readIds();
  Future<void> saveFavorite(String id) => database.addId(id);
  Future<void> deleteFavorite(String id) => database.removeId(id);
  Future<HeroExtra> extra(String id) => api.fetch(id);

  Future<void> close() async {
    api.close();
    await database.close();
  }
}
