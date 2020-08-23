import 'package:flutter/material.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockContext extends Mock implements BuildContext {}

abstract class MockWithExpandedToString extends Mock {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) =>
      super.toString();
}

class MockRenderBox extends MockWithExpandedToString implements RenderBox {}

void main() {
  group('calculate()', () {
    test('it returns new position for widget', () {
      final RenderBox box = MockRenderBox();
      final BuildContext context = MockContext();
      when(context.findRenderObject()).thenAnswer((_) => box);

      final Offset positionOffset = Offset(55, 33);
      when(box.localToGlobal(Offset.zero)).thenAnswer((_) => positionOffset);

      final Offset oldOffset = Offset(1, 2);
      final DragTargetDetails details = DragTargetDetails(offset: oldOffset);
      final WidgetPositionAfterDropOnPreview newPosition =
          WidgetPositionAfterDropOnPreview(context, details);
      final newCalculatedOffset =
          newPosition.calculate(350.0, 750.0, Offset(80, 80));

      expect(newCalculatedOffset.dx, equals(-54.0));
    });
  });
}
