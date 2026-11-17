// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_database.dart';

// ignore_for_file: type=lint
class $FavoriteHeroesTable extends FavoriteHeroes
    with TableInfo<$FavoriteHeroesTable, FavoriteHeroe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteHeroesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _heroIdMeta = const VerificationMeta('heroId');
  @override
  late final GeneratedColumn<String> heroId = GeneratedColumn<String>(
    'hero_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [heroId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_heroes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteHeroe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('hero_id')) {
      context.handle(
        _heroIdMeta,
        heroId.isAcceptableOrUnknown(data['hero_id']!, _heroIdMeta),
      );
    } else if (isInserting) {
      context.missing(_heroIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {heroId};
  @override
  FavoriteHeroe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteHeroe(
      heroId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hero_id'],
      )!,
    );
  }

  @override
  $FavoriteHeroesTable createAlias(String alias) {
    return $FavoriteHeroesTable(attachedDatabase, alias);
  }
}

class FavoriteHeroe extends DataClass implements Insertable<FavoriteHeroe> {
  final String heroId;
  const FavoriteHeroe({required this.heroId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['hero_id'] = Variable<String>(heroId);
    return map;
  }

  FavoriteHeroesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteHeroesCompanion(heroId: Value(heroId));
  }

  factory FavoriteHeroe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteHeroe(heroId: serializer.fromJson<String>(json['heroId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'heroId': serializer.toJson<String>(heroId)};
  }

  FavoriteHeroe copyWith({String? heroId}) =>
      FavoriteHeroe(heroId: heroId ?? this.heroId);
  FavoriteHeroe copyWithCompanion(FavoriteHeroesCompanion data) {
    return FavoriteHeroe(
      heroId: data.heroId.present ? data.heroId.value : this.heroId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteHeroe(')
          ..write('heroId: $heroId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => heroId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteHeroe && other.heroId == this.heroId);
}

class FavoriteHeroesCompanion extends UpdateCompanion<FavoriteHeroe> {
  final Value<String> heroId;
  final Value<int> rowid;
  const FavoriteHeroesCompanion({
    this.heroId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteHeroesCompanion.insert({
    required String heroId,
    this.rowid = const Value.absent(),
  }) : heroId = Value(heroId);
  static Insertable<FavoriteHeroe> custom({
    Expression<String>? heroId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (heroId != null) 'hero_id': heroId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteHeroesCompanion copyWith({Value<String>? heroId, Value<int>? rowid}) {
    return FavoriteHeroesCompanion(
      heroId: heroId ?? this.heroId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (heroId.present) {
      map['hero_id'] = Variable<String>(heroId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteHeroesCompanion(')
          ..write('heroId: $heroId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$FavoritesDatabase extends GeneratedDatabase {
  _$FavoritesDatabase(QueryExecutor e) : super(e);
  $FavoritesDatabaseManager get managers => $FavoritesDatabaseManager(this);
  late final $FavoriteHeroesTable favoriteHeroes = $FavoriteHeroesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteHeroes];
}

typedef $$FavoriteHeroesTableCreateCompanionBuilder =
    FavoriteHeroesCompanion Function({
      required String heroId,
      Value<int> rowid,
    });
typedef $$FavoriteHeroesTableUpdateCompanionBuilder =
    FavoriteHeroesCompanion Function({Value<String> heroId, Value<int> rowid});

class $$FavoriteHeroesTableFilterComposer
    extends Composer<_$FavoritesDatabase, $FavoriteHeroesTable> {
  $$FavoriteHeroesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get heroId => $composableBuilder(
    column: $table.heroId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteHeroesTableOrderingComposer
    extends Composer<_$FavoritesDatabase, $FavoriteHeroesTable> {
  $$FavoriteHeroesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get heroId => $composableBuilder(
    column: $table.heroId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteHeroesTableAnnotationComposer
    extends Composer<_$FavoritesDatabase, $FavoriteHeroesTable> {
  $$FavoriteHeroesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get heroId =>
      $composableBuilder(column: $table.heroId, builder: (column) => column);
}

class $$FavoriteHeroesTableTableManager
    extends
        RootTableManager<
          _$FavoritesDatabase,
          $FavoriteHeroesTable,
          FavoriteHeroe,
          $$FavoriteHeroesTableFilterComposer,
          $$FavoriteHeroesTableOrderingComposer,
          $$FavoriteHeroesTableAnnotationComposer,
          $$FavoriteHeroesTableCreateCompanionBuilder,
          $$FavoriteHeroesTableUpdateCompanionBuilder,
          (
            FavoriteHeroe,
            BaseReferences<
              _$FavoritesDatabase,
              $FavoriteHeroesTable,
              FavoriteHeroe
            >,
          ),
          FavoriteHeroe,
          PrefetchHooks Function()
        > {
  $$FavoriteHeroesTableTableManager(
    _$FavoritesDatabase db,
    $FavoriteHeroesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteHeroesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteHeroesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteHeroesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> heroId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteHeroesCompanion(heroId: heroId, rowid: rowid),
          createCompanionCallback:
              ({
                required String heroId,
                Value<int> rowid = const Value.absent(),
              }) =>
                  FavoriteHeroesCompanion.insert(heroId: heroId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoriteHeroesTable, FavoriteHeroe>(table),
                  BaseReferences<
                    _$FavoritesDatabase,
                    $FavoriteHeroesTable,
                    FavoriteHeroe
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteHeroesTableProcessedTableManager =
    ProcessedTableManager<
      _$FavoritesDatabase,
      $FavoriteHeroesTable,
      FavoriteHeroe,
      $$FavoriteHeroesTableFilterComposer,
      $$FavoriteHeroesTableOrderingComposer,
      $$FavoriteHeroesTableAnnotationComposer,
      $$FavoriteHeroesTableCreateCompanionBuilder,
      $$FavoriteHeroesTableUpdateCompanionBuilder,
      (
        FavoriteHeroe,
        BaseReferences<
          _$FavoritesDatabase,
          $FavoriteHeroesTable,
          FavoriteHeroe
        >,
      ),
      FavoriteHeroe,
      PrefetchHooks Function()
    >;

class $FavoritesDatabaseManager {
  final _$FavoritesDatabase _db;
  $FavoritesDatabaseManager(this._db);
  $$FavoriteHeroesTableTableManager get favoriteHeroes =>
      $$FavoriteHeroesTableTableManager(_db, _db.favoriteHeroes);
}
