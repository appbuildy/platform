import 'package:flutter_app/features/entities/NotLoggedInUser.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/features/services/project_parameters_from_browser_query.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
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
  Future<void> setupProject(dynamic window, RemoteAttributes attrs) async {
    final settings = ProjectParametersFromBrowserQuery(window);
    project = await Project.setup(
        userStore: this, settings: settings, attributes: attrs);
  }

  @action
  Future<void> tryLogIn(AuthenticationService authentication) async {
    currentUser = await authentication.authenticate();
  }
}
