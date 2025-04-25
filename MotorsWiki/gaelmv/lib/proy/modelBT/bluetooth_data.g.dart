// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBluetoothDataCollection on Isar {
  IsarCollection<BluetoothData> get bluetoothDatas => this.collection();
}

const BluetoothDataSchema = CollectionSchema(
  name: r'BluetoothData',
  id: 6262036265405204172,
  properties: {
    r'deviceAddress': PropertySchema(
      id: 0,
      name: r'deviceAddress',
      type: IsarType.string,
    ),
    r'deviceName': PropertySchema(
      id: 1,
      name: r'deviceName',
      type: IsarType.string,
    ),
    r'receivedData': PropertySchema(
      id: 2,
      name: r'receivedData',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 3,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _bluetoothDataEstimateSize,
  serialize: _bluetoothDataSerialize,
  deserialize: _bluetoothDataDeserialize,
  deserializeProp: _bluetoothDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bluetoothDataGetId,
  getLinks: _bluetoothDataGetLinks,
  attach: _bluetoothDataAttach,
  version: '3.1.0+1',
);

int _bluetoothDataEstimateSize(
  BluetoothData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deviceAddress.length * 3;
  bytesCount += 3 + object.deviceName.length * 3;
  bytesCount += 3 + object.receivedData.length * 3;
  return bytesCount;
}

void _bluetoothDataSerialize(
  BluetoothData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.deviceAddress);
  writer.writeString(offsets[1], object.deviceName);
  writer.writeString(offsets[2], object.receivedData);
  writer.writeDateTime(offsets[3], object.timestamp);
}

BluetoothData _bluetoothDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BluetoothData();
  object.deviceAddress = reader.readString(offsets[0]);
  object.deviceName = reader.readString(offsets[1]);
  object.id = id;
  object.receivedData = reader.readString(offsets[2]);
  object.timestamp = reader.readDateTime(offsets[3]);
  return object;
}

P _bluetoothDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bluetoothDataGetId(BluetoothData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bluetoothDataGetLinks(BluetoothData object) {
  return [];
}

void _bluetoothDataAttach(
    IsarCollection<dynamic> col, Id id, BluetoothData object) {
  object.id = id;
}

extension BluetoothDataQueryWhereSort
    on QueryBuilder<BluetoothData, BluetoothData, QWhere> {
  QueryBuilder<BluetoothData, BluetoothData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BluetoothDataQueryWhere
    on QueryBuilder<BluetoothData, BluetoothData, QWhereClause> {
  QueryBuilder<BluetoothData, BluetoothData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<BluetoothData, BluetoothData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterWhereClause> idBetween(
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

extension BluetoothDataQueryFilter
    on QueryBuilder<BluetoothData, BluetoothData, QFilterCondition> {
  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      deviceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receivedData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receivedData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedData',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      receivedDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receivedData',
        value: '',
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BluetoothDataQueryObject
    on QueryBuilder<BluetoothData, BluetoothData, QFilterCondition> {}

extension BluetoothDataQueryLinks
    on QueryBuilder<BluetoothData, BluetoothData, QFilterCondition> {}

extension BluetoothDataQuerySortBy
    on QueryBuilder<BluetoothData, BluetoothData, QSortBy> {
  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByDeviceAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAddress', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByDeviceAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAddress', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> sortByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByReceivedData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedData', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByReceivedDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedData', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension BluetoothDataQuerySortThenBy
    on QueryBuilder<BluetoothData, BluetoothData, QSortThenBy> {
  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByDeviceAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAddress', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByDeviceAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAddress', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> thenByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByReceivedData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedData', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByReceivedDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedData', Sort.desc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension BluetoothDataQueryWhereDistinct
    on QueryBuilder<BluetoothData, BluetoothData, QDistinct> {
  QueryBuilder<BluetoothData, BluetoothData, QDistinct> distinctByDeviceAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QDistinct> distinctByDeviceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QDistinct> distinctByReceivedData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BluetoothData, BluetoothData, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension BluetoothDataQueryProperty
    on QueryBuilder<BluetoothData, BluetoothData, QQueryProperty> {
  QueryBuilder<BluetoothData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BluetoothData, String, QQueryOperations>
      deviceAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceAddress');
    });
  }

  QueryBuilder<BluetoothData, String, QQueryOperations> deviceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceName');
    });
  }

  QueryBuilder<BluetoothData, String, QQueryOperations> receivedDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedData');
    });
  }

  QueryBuilder<BluetoothData, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
