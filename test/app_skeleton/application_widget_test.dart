import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/application_widget.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class MockWithExpandedToString extends Mock {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) =>
      super.toString();
}

class ApplicationMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fallback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: Text('App is Rendered')),
    );
  }
}

class BrowserRenderMock extends Mock implements BrowserPreview {
  Future<ApplicationMock> load() async {
    return ApplicationMock();
  }
}

class BrowserRenderMockError extends Mock implements BrowserPreview {
  Future<Application> load() async {
    throw Exception();
  }
}

void main() {
  testWidgets('it renders app isLoading', (WidgetTester tester) async {
    var appWidget = ApplicationWidget(preview: BrowserRenderMockError());
    await tester.pumpWidget(appWidget);
    final textFinder = find.text('App is Loading');

    expect(textFinder, findsOneWidget);
  });

  testWidgets('it renders loaded application', (WidgetTester tester) async {
    var appWidget = ApplicationWidget(preview: BrowserRenderMock());
    await tester.pumpWidget(appWidget);
    await tester.pumpAndSettle(Duration(seconds: 5));
    final textFinder = find.text('App is Rendered');

    expect(textFinder, findsOneWidget);
  });
}
