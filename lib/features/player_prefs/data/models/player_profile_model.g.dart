// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_profile_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayerProfileModelCollection on Isar {
  IsarCollection<PlayerProfileModel> get playerProfileModels =>
      this.collection();
}

const PlayerProfileModelSchema = CollectionSchema(
  name: r'PlayerProfileModel',
  id: -675427074400610049,
  properties: {
    r'bestArcadeScore': PropertySchema(
      id: 0,
      name: r'bestArcadeScore',
      type: IsarType.long,
    ),
    r'playerName': PropertySchema(
      id: 1,
      name: r'playerName',
      type: IsarType.string,
    ),
  },

  estimateSize: _playerProfileModelEstimateSize,
  serialize: _playerProfileModelSerialize,
  deserialize: _playerProfileModelDeserialize,
  deserializeProp: _playerProfileModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _playerProfileModelGetId,
  getLinks: _playerProfileModelGetLinks,
  attach: _playerProfileModelAttach,
  version: '3.3.2',
);

int _playerProfileModelEstimateSize(
  PlayerProfileModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.playerName.length * 3;
  return bytesCount;
}

void _playerProfileModelSerialize(
  PlayerProfileModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bestArcadeScore);
  writer.writeString(offsets[1], object.playerName);
}

PlayerProfileModel _playerProfileModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayerProfileModel(
    bestArcadeScore: reader.readLongOrNull(offsets[0]) ?? 0,
    playerName: reader.readStringOrNull(offsets[1]) ?? 'Player',
  );
  object.id = id;
  return object;
}

P _playerProfileModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? 'Player') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playerProfileModelGetId(PlayerProfileModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playerProfileModelGetLinks(
  PlayerProfileModel object,
) {
  return [];
}

void _playerProfileModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  PlayerProfileModel object,
) {
  object.id = id;
}

extension PlayerProfileModelQueryWhereSort
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QWhere> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlayerProfileModelQueryWhere
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QWhereClause> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PlayerProfileModelQueryFilter
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QFilterCondition> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  bestArcadeScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bestArcadeScore', value: value),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  bestArcadeScoreGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bestArcadeScore',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  bestArcadeScoreLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bestArcadeScore',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  bestArcadeScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bestArcadeScore',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'playerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'playerName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playerName', value: ''),
      );
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterFilterCondition>
  playerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'playerName', value: ''),
      );
    });
  }
}

extension PlayerProfileModelQueryObject
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QFilterCondition> {}

extension PlayerProfileModelQueryLinks
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QFilterCondition> {}

extension PlayerProfileModelQuerySortBy
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QSortBy> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  sortByBestArcadeScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestArcadeScore', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  sortByBestArcadeScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestArcadeScore', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  sortByPlayerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerName', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  sortByPlayerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerName', Sort.desc);
    });
  }
}

extension PlayerProfileModelQuerySortThenBy
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QSortThenBy> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenByBestArcadeScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestArcadeScore', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenByBestArcadeScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestArcadeScore', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenByPlayerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerName', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QAfterSortBy>
  thenByPlayerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerName', Sort.desc);
    });
  }
}

extension PlayerProfileModelQueryWhereDistinct
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QDistinct> {
  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QDistinct>
  distinctByBestArcadeScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bestArcadeScore');
    });
  }

  QueryBuilder<PlayerProfileModel, PlayerProfileModel, QDistinct>
  distinctByPlayerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerName', caseSensitive: caseSensitive);
    });
  }
}

extension PlayerProfileModelQueryProperty
    on QueryBuilder<PlayerProfileModel, PlayerProfileModel, QQueryProperty> {
  QueryBuilder<PlayerProfileModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlayerProfileModel, int, QQueryOperations>
  bestArcadeScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bestArcadeScore');
    });
  }

  QueryBuilder<PlayerProfileModel, String, QQueryOperations>
  playerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerName');
    });
  }
}
