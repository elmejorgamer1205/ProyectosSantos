import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'favorites_database.g.dart';

// La tabla y el archivo generado se entregan preparados en el starter.
class FavoriteHeroes extends Table {
  TextColumn get heroId => text()();
  @override
  Set<Column> get primaryKey => {heroId};
}

@DriftDatabase(tables: [FavoriteHeroes])
class FavoritesDatabase extends _$FavoritesDatabase {
  FavoritesDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'marvel_heroes_ud3'));

  @override
  int get schemaVersion => 1;

  // RETO UD3 A1: sustituye los tres métodos por operaciones Drift reales.
  Future<Set<String>> readIds() async => {};

  Future<void> addId(String id) async {
    // RETO UD3 A1: insertar heroId sin duplicados.
  }

  Future<void> removeId(String id) async {
    // RETO UD3 A1: borrar solo este heroId.
  }

}
