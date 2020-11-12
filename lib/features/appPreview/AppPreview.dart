import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DeltaPanDetector.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum SideEnum { topLeft, topRight, bottomRight, bottomLeft }

class AppPreview extends StatefulWidget {
  final UserActions userActions;
  final bool isPlayMode;
  final bool isPreview;
  final Function selectPlayModeToFalse;
  final Function selectStateToLayout;
  final FocusNode focusNode;

  const AppPreview({
    Key key,
    this.userActions,
    this.isPlayMode,
    this.selectPlayModeToFalse,
    this.isPreview = false,
    this.selectStateToLayout,
    this.focusNode,
  }): super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  UserActions userActions;

  @override
  void initState() {
    super.initState();
    userActions = widget.userActions;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<SchemaNode>(
      onAcceptWithDetails: (details) {
        final newPosition = WidgetPositionAfterDropOnPreview(context, details)
            .calculate(userActions.screens.currentScreenWorkspaceSize.dx, widget.userActions.screens.currentScreenWorkspaceSize.dy, details.data.size);
        userActions.placeWidget(details.data, newPosition);
        widget.selectPlayModeToFalse();

        widget.focusNode.requestFocus();
      },
      builder: (context, candidateData, rejectedData) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        double scale = 1;

        final heightScaled = height / 1000;
        final widthScaled = width / 1400;

        if (height <= 899 || width <= 1140) {
          scale = widget.isPreview
              ? 1
              : heightScaled < widthScaled
                  ? heightScaled
                  : widthScaled;
        }

        return Observer(builder: (context) {
          final theme = userActions.currentTheme;

          final UniqueKey selectedNodeId = userActions.selectedNode()?.id;

          return Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: Container(
              width: userActions.screens.currentScreenWorkspaceSize.dx + 4,
              // 4px is for border (2 px on both sides)
              height: userActions.screens.currentScreenWorkspaceSize.dy + userActions.screens.screenTabsHeight + 4,
              // 4px is for border (2 px on both sides)
              decoration: BoxDecoration(
                  color: userActions.screens.current.backgroundColor.color,
                  borderRadius: widget.isPreview
                      ? BorderRadius.zero
                      : BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 2),
                        color: MyColors.black.withOpacity(0.15))
                  ],
                  border: widget.isPreview
                      ? Border()
                      : Border.all(width: 2, color: MyColors.black)),
              child: ClipRRect(
                borderRadius: widget.isPreview
                    ? BorderRadius.zero
                    : BorderRadius.circular(39.0),
                child: Stack(
                  textDirection: TextDirection.ltr,
                  children: [
                    ...userActions.guidelineManager.buildAllLines(
                        screenSize: widget.userActions.screens.currentScreenWorkspaceSize
                    ),
                    ...userActions.screens.current.components.map((node) {
                      final Function onPanEnd = (_) {
                        userActions.guidelineManager.setAllInvisible();
                        userActions.rerenderNode();
                      };

                      Widget renderWithSelected() => (
                        SchemaNode.renderWithSelected(
                          onPanEnd: onPanEnd,
                          repositionAndResize: userActions.repositionAndResize,
                          currentScreenWorkspaceSize: userActions.screens.currentScreenWorkspaceSize,
                          isPlayMode: widget.isPlayMode,
                          isSelected: selectedNodeId == node.id,
                          node: node,
                          toWidgetFunction: node.toWidget,
                          isMagnetInteraction: true,
                        )
                      );

                      return
                        Positioned(
                          child: GestureDetector(
                            onTapDown: (details) {
                              widget.focusNode.requestFocus();
                              if (widget.isPlayMode) {
                                if (node.type == SchemaNodeType.list) {
                                  // чтобы прокидывать данные на каждый айтем листа
                                  return;
                                }
                                (node.actions['Tap'] as Functionable)
                                    .toFunction(userActions)();
                              } else {
                                userActions.selectNodeForEdit(node);
                                widget.selectStateToLayout(); // select menu layout
                              }
                            },
                            child: !widget.isPlayMode
                              ? renderWithSelected()
                              : node.toWidget(isPlayMode: widget.isPlayMode),
                          ),
                          top: node.position.dy,
                          left: node.position.dx,
                        );
                    }),
                    widget.isPreview
                        ? Container()
                        : Positioned(
                            top: 0,
                            left: 0,
                            child: Image.network(
                                'assets/icons/meta/status-bar.svg')),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: userActions.screens.current.bottomTabsVisible
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: theme.separators.color))),
                              child: Container(
                                child: AppTabs(userActions: userActions),
                                width: userActions.screens.currentScreenWorkspaceSize.dx,
                                height: userActions.screens.screenTabsHeight,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: widget.isPreview
                                      ? BorderRadius.zero
                                      : BorderRadius.only(
                                          bottomLeft: Radius.circular(37.0),
                                          bottomRight: Radius.circular(37.0)),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    widget.isPreview
                        ? Container()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 7.0),
                              child: Container(
                                width: 134,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Color(0xFF000000),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
