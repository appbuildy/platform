import 'package:flutter_app/features/entities/NotLoggedInUser.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SettingsParser.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:mobx/mobx.dart';

part 'CurrentUserStore.g.dart';

class CurrentUserStore = _CurrentUserStore with _$CurrentUserStore;

abstract class _CurrentUserStore with Store {
  _CurrentUserStore();

  @observable
  User currentUser = NotLoggedInUser();

  @observable
  Project project;

  @action
  Future<void> setupProject(dynamic window) async {
    final SettingsParser settings = SettingsParser(window);
    project = await SetupProject(this, settings).setup();
  }

  @action
  Future<void> tryLogIn(AuthenticationService authentication) async {
    currentUser = await authentication.authenticate();
  }
}
