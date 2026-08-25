// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stats_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGameStatsModelCollection on Isar {
  IsarCollection<GameStatsModel> get gameStatsModels => this.collection();
}

const GameStatsModelSchema = CollectionSchema(
  name: r'GameStatsModel',
  id: 1182537479367887225,
  properties: {
    r'entries': PropertySchema(
      id: 0,
      name: r'entries',
      type: IsarType.objectList,

      target: r'GameOperationStatsEmbedded',
    ),
  },

  estimateSize: _gameStatsModelEstimateSize,
  serialize: _gameStatsModelSerialize,
  deserialize: _gameStatsModelDeserialize,
  deserializeProp: _gameStatsModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'GameOperationStatsEmbedded': GameOperationStatsEmbeddedSchema,
  },

  getId: _gameStatsModelGetId,
  getLinks: _gameStatsModelGetLinks,
  attach: _gameStatsModelAttach,
  version: '3.3.2',
);

int _gameStatsModelEstimateSize(
  GameStatsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entries.length * 3;
  {
    final offsets = allOffsets[GameOperationStatsEmbedded]!;
    for (var i = 0; i < object.entries.length; i++) {
      final value = object.entries[i];
      bytesCount += GameOperationStatsEmbeddedSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _gameStatsModelSerialize(
  GameStatsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<GameOperationStatsEmbedded>(
    offsets[0],
    allOffsets,
    GameOperationStatsEmbeddedSchema.serialize,
    object.entries,
  );
}

GameStatsModel _gameStatsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameStatsModel();
  object.entries =
      reader.readObjectList<GameOperationStatsEmbedded>(
        offsets[0],
        GameOperationStatsEmbeddedSchema.deserialize,
        allOffsets,
        GameOperationStatsEmbedded(),
      ) ??
      [];
  object.id = id;
  return object;
}

P _gameStatsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<GameOperationStatsEmbedded>(
                offset,
                GameOperationStatsEmbeddedSchema.deserialize,
                allOffsets,
                GameOperationStatsEmbedded(),
              ) ??
              [])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gameStatsModelGetId(GameStatsModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gameStatsModelGetLinks(GameStatsModel object) {
  return [];
}

void _gameStatsModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  GameStatsModel object,
) {
  object.id = id;
}

extension GameStatsModelQueryWhereSort
    on QueryBuilder<GameStatsModel, GameStatsModel, QWhere> {
  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GameStatsModelQueryWhere
    on QueryBuilder<GameStatsModel, GameStatsModel, QWhereClause> {
  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterWhereClause> idBetween(
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

extension GameStatsModelQueryFilter
    on QueryBuilder<GameStatsModel, GameStatsModel, QFilterCondition> {
  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'entries', length, true, length, true);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'entries', 0, true, 0, true);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'entries', 0, false, 999999, true);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'entries', 0, true, length, include);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'entries', length, include, 999999, true);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
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

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
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

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition> idBetween(
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
}

extension GameStatsModelQueryObject
    on QueryBuilder<GameStatsModel, GameStatsModel, QFilterCondition> {
  QueryBuilder<GameStatsModel, GameStatsModel, QAfterFilterCondition>
  entriesElement(FilterQuery<GameOperationStatsEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'entries');
    });
  }
}

extension GameStatsModelQueryLinks
    on QueryBuilder<GameStatsModel, GameStatsModel, QFilterCondition> {}

extension GameStatsModelQuerySortBy
    on QueryBuilder<GameStatsModel, GameStatsModel, QSortBy> {}

extension GameStatsModelQuerySortThenBy
    on QueryBuilder<GameStatsModel, GameStatsModel, QSortThenBy> {
  QueryBuilder<GameStatsModel, GameStatsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GameStatsModel, GameStatsModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GameStatsModelQueryWhereDistinct
    on QueryBuilder<GameStatsModel, GameStatsModel, QDistinct> {}

extension GameStatsModelQueryProperty
    on QueryBuilder<GameStatsModel, GameStatsModel, QQueryProperty> {
  QueryBuilder<GameStatsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<
    GameStatsModel,
    List<GameOperationStatsEmbedded>,
    QQueryOperations
  >
  entriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entries');
    });
  }
}
