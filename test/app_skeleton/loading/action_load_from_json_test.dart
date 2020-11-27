import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/action_load_from_json.dart';
import 'package:flutter_test/flutter_test.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen(this.onTap);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('PRESS'),
          onPressed: onTap(context),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

void main() {
  var jsonAction = {
    "Tap": {
      "type": "SchemaActionType.goToScreen",
      "value": {"value": "5GsO8z9I0kdzQuENP0WOxVa960ZSIT"},
      "action": "Tap",
      "propertyClass": "GoToScreenAction"
    }
  };

  var loader = ActionLoadFromJson(jsonAction);

  testWidgets('it loads on Tap', (WidgetTester tester) async {
    var loadedAction = loader.load();
    var app = MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(loadedAction.functionAction),
        '5GsO8z9I0kdzQuENP0WOxVa960ZSIT': (context) => SecondScreen()
      },
    );
    await tester.pumpWidget(app);
    await tester.tap(find.text('PRESS'));
    await tester.pumpAndSettle();
    expect(find.text('Second Screen'), findsOneWidget);
  });
}
