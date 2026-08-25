// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_operation_stats_embedded.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GameOperationStatsEmbeddedSchema = Schema(
  name: r'GameOperationStatsEmbedded',
  id: -2187848518048254755,
  properties: {
    r'attempts': PropertySchema(id: 0, name: r'attempts', type: IsarType.long),
    r'correctCount': PropertySchema(
      id: 1,
      name: r'correctCount',
      type: IsarType.long,
    ),
    r'currentTierIndex': PropertySchema(
      id: 2,
      name: r'currentTierIndex',
      type: IsarType.long,
    ),
    r'operationTypeKey': PropertySchema(
      id: 3,
      name: r'operationTypeKey',
      type: IsarType.string,
    ),
    r'recentResults': PropertySchema(
      id: 4,
      name: r'recentResults',
      type: IsarType.boolList,
    ),
  },

  estimateSize: _gameOperationStatsEmbeddedEstimateSize,
  serialize: _gameOperationStatsEmbeddedSerialize,
  deserialize: _gameOperationStatsEmbeddedDeserialize,
  deserializeProp: _gameOperationStatsEmbeddedDeserializeProp,
);

int _gameOperationStatsEmbeddedEstimateSize(
  GameOperationStatsEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.operationTypeKey.length * 3;
  bytesCount += 3 + object.recentResults.length;
  return bytesCount;
}

void _gameOperationStatsEmbeddedSerialize(
  GameOperationStatsEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attempts);
  writer.writeLong(offsets[1], object.correctCount);
  writer.writeLong(offsets[2], object.currentTierIndex);
  writer.writeString(offsets[3], object.operationTypeKey);
  writer.writeBoolList(offsets[4], object.recentResults);
}

GameOperationStatsEmbedded _gameOperationStatsEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameOperationStatsEmbedded();
  object.attempts = reader.readLong(offsets[0]);
  object.correctCount = reader.readLong(offsets[1]);
  object.currentTierIndex = reader.readLong(offsets[2]);
  object.operationTypeKey = reader.readString(offsets[3]);
  object.recentResults = reader.readBoolList(offsets[4]) ?? [];
  return object;
}

P _gameOperationStatsEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBoolList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GameOperationStatsEmbeddedQueryFilter
    on
        QueryBuilder<
          GameOperationStatsEmbedded,
          GameOperationStatsEmbedded,
          QFilterCondition
        > {
  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  attemptsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'attempts', value: value),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  attemptsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'attempts',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  attemptsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'attempts',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  attemptsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'attempts',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  correctCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctCount', value: value),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  correctCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'correctCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  correctCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'correctCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  correctCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'correctCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  currentTierIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentTierIndex', value: value),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  currentTierIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentTierIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  currentTierIndexLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentTierIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  currentTierIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentTierIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'operationTypeKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'operationTypeKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'operationTypeKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'operationTypeKey', value: ''),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  operationTypeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'operationTypeKey', value: ''),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'recentResults', value: value),
      );
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recentResults', length, true, length, true);
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recentResults', 0, true, 0, true);
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recentResults', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recentResults', 0, true, length, include);
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'recentResults', length, include, 999999, true);
    });
  }

  QueryBuilder<
    GameOperationStatsEmbedded,
    GameOperationStatsEmbedded,
    QAfterFilterCondition
  >
  recentResultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recentResults',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension GameOperationStatsEmbeddedQueryObject
    on
        QueryBuilder<
          GameOperationStatsEmbedded,
          GameOperationStatsEmbedded,
          QFilterCondition
        > {}
