import 'package:flutter_app/features/toolbox/ToolboxLayout.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    final appPreview = MyApp();

    await tester.pumpWidget(appPreview);
    expect(find.text('Button'), findsOneWidget);
  });

  testWidgets('Drag n drop toolbox component', (WidgetTester tester) async {
    final appPreview = MyApp();
    final component = find.byType(ToolboxComponent).first;

    await tester.pumpWidget(appPreview);
    await tester.drag(component, Offset(150, 400));
    await tester.pumpAndSettle();
    expect(find.text('Button'), findsNWidgets(3));
  });
}
