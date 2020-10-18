import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SchemaNode text;
  SchemaNodeProperty newProp;
  ChangeNodeProperty changeProp;
  SchemaStore schemaStore;
  Function selectNodeForEdit;

  ChangeNodeProperty changeBtnAction;
  SchemaNodeProperty goToScreen;
  SchemaNode btn;

  setUp(() {
    schemaStore = SchemaStore(components: []);
    text = SchemaNodeText();
    btn = SchemaNodeButton(position: Offset(1, 2));

    schemaStore.add(text);
    schemaStore.add(btn);

    selectNodeForEdit = (SchemaNode node) {};

    newProp = SchemaStringProperty('Text', '33');
    changeProp = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: schemaStore,
        node: text,
        newProp: newProp);

    goToScreen = GoToScreenAction('Tap', RandomKey());
    changeBtnAction = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: schemaStore,
        changeAction: ChangeAction.actions,
        node: btn,
        newProp: goToScreen);
  });

  group('undo()', () {
    test('it changes node to previous value', () {
      final oldValue = text.properties['Text'].value;
      changeProp.execute();
      changeProp.undo();

      expect(text.properties['Text'].value, equals(oldValue));
    });
  });

  group('execute()', () {
    test('it changes action', () {
      changeBtnAction.execute();
    });

    test('it changes node property to given', () {
      changeProp.execute();
      final textPropValue = text.properties['Text'].value;

      expect(textPropValue, equals(newProp.value));
    });
  });
}
