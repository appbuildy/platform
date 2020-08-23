import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class RepositionAndResizeOffsets {
  Offset position;
  Offset size;

  RepositionAndResizeOffsets({Offset position, Offset size}) {
    this.position = position;
    this.size = size;
  }
}

class RepositionAndResize extends BaseAction {
  SchemaNode node;
  SchemaStore schemaStore;
  SchemaNode oldValue;

  RepositionAndResize({SchemaStore schemaStore, SchemaNode node}) {
    this.schemaStore = schemaStore;
    this.node = node;
    this.oldValue = node.copy();
  }

  @override
  void execute([SchemaNode prevValue]) {
    if (prevValue != null) {
      oldValue = prevValue.copy();
    } else {
      oldValue = node.copy();
    }

    if (oldValue == null) return;
    executed = true;
    schemaStore.update(node);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    log('old  ${oldValue.id} value x y ${oldValue.position.dx} ${oldValue.position.dy}');
    log('node ${node.id} value x y ${node.position.dx} ${node.position.dy}');
    if (!executed) return;
    schemaStore.update(oldValue.copy());
  }
}
