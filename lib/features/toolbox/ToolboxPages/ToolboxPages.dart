import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/BottomNavigation/TabSelected.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/BottomNavigation/Tabs.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/Pages.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToolboxPages extends StatefulWidget {
  final UserActions userActions;

  const ToolboxPages({Key key, this.userActions}) : super(key: key);

  @override
  _ToolboxPagesState createState() => _ToolboxPagesState();
}

class _ToolboxPagesState extends State<ToolboxPages>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  TabNavigation selectedTab;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 1, vsync: this, duration: Duration(milliseconds: 250));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuad,
      reverseCurve: Curves.easeInOutQuad,
    );
  }

  void selectTabNavigation(TabNavigation tab) {
    // check if there a screen before navigation
//    if (widget.userActions.screens.all.screens
//            .where((element) => element.name == tab.target) !=
//        null) {
//      widget.userActions.screens.selectByName(tab.target);
//    }
    _controller.reverse();
    setState(() {
      selectedTab = tab;
    });
  }

  void goBack() {
    _controller.forward();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        selectedTab = null;
      });
    });
  }

  Widget _buildMain() {
    return Column(
      children: [
        ToolboxTitle(
          'Tabs & Pages',
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Column(
            children: [
              ToolBoxCaption('Pages'),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: MyButton(
                  text: 'Add Page',
                  icon: Image.network('assets/icons/meta/btn-plus.svg'),
                  onTap: () {
                    widget.userActions.screens
                        .create(moveToLastAfterCreated: true);
                    widget.userActions.selectNodeForEdit(null);
                  },
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Pages(userActions: widget.userActions),
              SizedBox(height: 24),
              Container(
                height: 1,
                width: 260,
                decoration: BoxDecoration(
                    color: MyColors.gray,
                    borderRadius: BorderRadius.circular(5)),
              ),
              ToolBoxCaption('Tabs'),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: MyButton(
                    text: 'Add Tab',
                    onTap: () {
                      final newTab = TabNavigation(
                          icon: FontAwesomeIcons.home,
                          target: widget.userActions.currentScreen.id,
                          label: widget.userActions.currentScreen.name);

                      widget.userActions.bottomNavigation.addTab(newTab);
                      selectTabNavigation(newTab);
                    },
                    icon: Image.network('assets/icons/meta/btn-plus.svg')),
              ),
              SizedBox(
                height: 17,
              ),
              Tabs(
                selectTab: selectTabNavigation,
                userActions: widget.userActions,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedTab() {
    if (selectedTab == null) {
      return Container();
    }

    return Column(
      children: [
        ToolboxHeader(
            leftWidget: IconCircleButton(
                onTap: goBack, assetPath: 'assets/icons/meta/btn-back.svg'),
            rightWidget: IconCircleButton(
                onTap: () {
                  widget.userActions.bottomNavigation.deleteTab(selectedTab);
                  goBack();
                },
                assetPath: 'assets/icons/meta/btn-delete.svg'),
            title: selectedTab.label),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 20),
          child: TabSelected(
              rerender: () {
                setState(() {});
              },
              tab: selectedTab,
              userActions: widget.userActions),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxSlide = 300;

    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        double reversedValue = (_animation.value - 1) * -1;
        double slideFirst = (-maxSlide / 2) * reversedValue;
        double slideSecond = maxSlide * (_animation.value);

        return Stack(children: [
          Transform(
              transform: Matrix4.identity()..translate(slideFirst),
              child: Container(
                  color: MyColors.white,
                  width: toolboxWidth,
                  child: _buildMain())),
          Transform(
              transform: Matrix4.identity()..translate(slideSecond),
              child: Container(
                  color: MyColors.white,
                  width: toolboxWidth,
                  child: _buildSelectedTab()))
        ]);
      },
      animation: _animation,
    );
  }
}
