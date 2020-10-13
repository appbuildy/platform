// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentUserStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentUserStore on _CurrentUserStore, Store {
  final _$currentUserAtom = Atom(name: '_CurrentUserStore.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$projectAtom = Atom(name: '_CurrentUserStore.project');

  @override
  Project get project {
    _$projectAtom.reportRead();
    return super.project;
  }

  @override
  set project(Project value) {
    _$projectAtom.reportWrite(value, super.project, () {
      super.project = value;
    });
  }

  final _$setupProjectAsyncAction =
      AsyncAction('_CurrentUserStore.setupProject');

  @override
  Future<void> setupProject(dynamic window, RemoteAttributes attrs) {
    return _$setupProjectAsyncAction
        .run(() => super.setupProject(window, attrs));
  }

  final _$tryLogInAsyncAction = AsyncAction('_CurrentUserStore.tryLogIn');

  @override
  Future<void> tryLogIn(AuthenticationService authentication) {
    return _$tryLogInAsyncAction.run(() => super.tryLogIn(authentication));
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
project: ${project}
    ''';
  }
}
