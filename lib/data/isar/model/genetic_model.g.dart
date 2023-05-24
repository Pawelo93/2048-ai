// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genetic_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGeneticModelCollection on Isar {
  IsarCollection<GeneticModel> get geneticModels => this.collection();
}

const GeneticModelSchema = CollectionSchema(
  name: r'GeneticModel',
  id: -8210912352203517488,
  properties: {
    r'weights': PropertySchema(
      id: 0,
      name: r'weights',
      type: IsarType.objectList,
      target: r'Weights',
    )
  },
  estimateSize: _geneticModelEstimateSize,
  serialize: _geneticModelSerialize,
  deserialize: _geneticModelDeserialize,
  deserializeProp: _geneticModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Weights': WeightsSchema},
  getId: _geneticModelGetId,
  getLinks: _geneticModelGetLinks,
  attach: _geneticModelAttach,
  version: '3.1.0+1',
);

int _geneticModelEstimateSize(
  GeneticModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.weights.length * 3;
  {
    final offsets = allOffsets[Weights]!;
    for (var i = 0; i < object.weights.length; i++) {
      final value = object.weights[i];
      bytesCount += WeightsSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _geneticModelSerialize(
  GeneticModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Weights>(
    offsets[0],
    allOffsets,
    WeightsSchema.serialize,
    object.weights,
  );
}

GeneticModel _geneticModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GeneticModel(
    id,
    reader.readObjectList<Weights>(
          offsets[0],
          WeightsSchema.deserialize,
          allOffsets,
          Weights(),
        ) ??
        [],
  );
  return object;
}

P _geneticModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Weights>(
            offset,
            WeightsSchema.deserialize,
            allOffsets,
            Weights(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _geneticModelGetId(GeneticModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _geneticModelGetLinks(GeneticModel object) {
  return [];
}

void _geneticModelAttach(
    IsarCollection<dynamic> col, Id id, GeneticModel object) {}

extension GeneticModelQueryWhereSort
    on QueryBuilder<GeneticModel, GeneticModel, QWhere> {
  QueryBuilder<GeneticModel, GeneticModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GeneticModelQueryWhere
    on QueryBuilder<GeneticModel, GeneticModel, QWhereClause> {
  QueryBuilder<GeneticModel, GeneticModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<GeneticModel, GeneticModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GeneticModelQueryFilter
    on QueryBuilder<GeneticModel, GeneticModel, QFilterCondition> {
  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'weights',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension GeneticModelQueryObject
    on QueryBuilder<GeneticModel, GeneticModel, QFilterCondition> {
  QueryBuilder<GeneticModel, GeneticModel, QAfterFilterCondition>
      weightsElement(FilterQuery<Weights> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'weights');
    });
  }
}

extension GeneticModelQueryLinks
    on QueryBuilder<GeneticModel, GeneticModel, QFilterCondition> {}

extension GeneticModelQuerySortBy
    on QueryBuilder<GeneticModel, GeneticModel, QSortBy> {}

extension GeneticModelQuerySortThenBy
    on QueryBuilder<GeneticModel, GeneticModel, QSortThenBy> {
  QueryBuilder<GeneticModel, GeneticModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GeneticModel, GeneticModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GeneticModelQueryWhereDistinct
    on QueryBuilder<GeneticModel, GeneticModel, QDistinct> {}

extension GeneticModelQueryProperty
    on QueryBuilder<GeneticModel, GeneticModel, QQueryProperty> {
  QueryBuilder<GeneticModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GeneticModel, List<Weights>, QQueryOperations>
      weightsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weights');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WeightsSchema = Schema(
  name: r'Weights',
  id: -7796306184308874953,
  properties: {
    r'generation': PropertySchema(
      id: 0,
      name: r'generation',
      type: IsarType.long,
    ),
    r'score': PropertySchema(
      id: 1,
      name: r'score',
      type: IsarType.long,
    ),
    r'w1': PropertySchema(
      id: 2,
      name: r'w1',
      type: IsarType.double,
    ),
    r'w2': PropertySchema(
      id: 3,
      name: r'w2',
      type: IsarType.double,
    ),
    r'w3': PropertySchema(
      id: 4,
      name: r'w3',
      type: IsarType.double,
    ),
    r'w4': PropertySchema(
      id: 5,
      name: r'w4',
      type: IsarType.double,
    )
  },
  estimateSize: _weightsEstimateSize,
  serialize: _weightsSerialize,
  deserialize: _weightsDeserialize,
  deserializeProp: _weightsDeserializeProp,
);

int _weightsEstimateSize(
  Weights object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _weightsSerialize(
  Weights object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.generation);
  writer.writeLong(offsets[1], object.score);
  writer.writeDouble(offsets[2], object.w1);
  writer.writeDouble(offsets[3], object.w2);
  writer.writeDouble(offsets[4], object.w3);
  writer.writeDouble(offsets[5], object.w4);
}

Weights _weightsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Weights(
    generation: reader.readLongOrNull(offsets[0]),
    score: reader.readLongOrNull(offsets[1]),
    w1: reader.readDoubleOrNull(offsets[2]),
    w2: reader.readDoubleOrNull(offsets[3]),
    w3: reader.readDoubleOrNull(offsets[4]),
    w4: reader.readDoubleOrNull(offsets[5]),
  );
  return object;
}

P _weightsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension WeightsQueryFilter
    on QueryBuilder<Weights, Weights, QFilterCondition> {
  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'generation',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'generation',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generation',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'generation',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'generation',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> generationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'generation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> scoreBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'w1',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'w1',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1EqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1GreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1LessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w1',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w1Between(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'w2',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'w2',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2EqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2GreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2LessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w2Between(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'w3',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'w3',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3EqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w3',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3GreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w3',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3LessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w3',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w3Between(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'w4',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'w4',
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4EqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w4',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4GreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w4',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4LessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w4',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Weights, Weights, QAfterFilterCondition> w4Between(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WeightsQueryObject
    on QueryBuilder<Weights, Weights, QFilterCondition> {}
