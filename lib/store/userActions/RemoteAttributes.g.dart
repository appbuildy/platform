// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RemoteAttributes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RemoteAttributes on _RemoteAttributes, Store {
  Computed<List<String>> _$tableNamesComputed;

  @override
  List<String> get tableNames =>
      (_$tableNamesComputed ??= Computed<List<String>>(() => super.tableNames,
              name: '_RemoteAttributes.tableNames'))
          .value;

  final _$attributesAtom = Atom(name: '_RemoteAttributes.attributes');

  @override
  ObservableList<IRemoteAttribute> get attributes {
    _$attributesAtom.reportRead();
    return super.attributes;
  }

  @override
  set attributes(ObservableList<IRemoteAttribute> value) {
    _$attributesAtom.reportWrite(value, super.attributes, () {
      super.attributes = value;
    });
  }

  final _$tablesAtom = Atom(name: '_RemoteAttributes.tables');

  @override
  ObservableMap<String, Map<String, RemoteList>> get tables {
    _$tablesAtom.reportRead();
    return super.tables;
  }

  @override
  set tables(ObservableMap<String, Map<String, RemoteList>> value) {
    _$tablesAtom.reportWrite(value, super.tables, () {
      super.tables = value;
    });
  }

  final _$fetchTablesAsyncAction = AsyncAction('_RemoteAttributes.fetchTables');

  @override
  Future<void> fetchTables(List<String> tableNames) {
    return _$fetchTablesAsyncAction.run(() => super.fetchTables(tableNames));
  }

  final _$updateAsyncAction = AsyncAction('_RemoteAttributes.update');

  @override
  Future<void> update([IRemoteTable fetchClient]) {
    return _$updateAsyncAction.run(() => super.update(fetchClient));
  }

  @override
  String toString() {
    return '''
attributes: ${attributes},
tables: ${tables},
tableNames: ${tableNames}
    ''';
  }
}
