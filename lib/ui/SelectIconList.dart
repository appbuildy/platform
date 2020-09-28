import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/BottomNavigation/iconsList.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectIconList extends StatelessWidget {
  final IconData selectedIcon;
  final Function(IconData icon) onChanged;
  final double subListHeight;

  const SelectIconList(
      {Key key,
      @required this.selectedIcon,
      @required this.onChanged,
      this.subListHeight})
      : super(key: key);

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, top: 17),
      child: Text(
        text,
        style: MyTextStyle.regularCaption,
      ),
    );
  }

  Widget _buildRowIcon(dynamic icon) {
    final isSelected = selectedIcon == icon;

    if (icon == null) {
      return Container(
        width: 52,
        height: 52,
      );
    }

    final borderRadius = BorderRadius.circular(8);

    final defaultDecoration = isSelected
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.plainWhite,
            borderRadius: borderRadius,
          );

    final hoverDecoration = isSelected
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.lightGray,
            borderRadius: borderRadius,
          );

    return GestureDetector(
      onTap: () {
        onChanged(icon);
      },
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: Container(
            width: 52,
            height: 52,
            child: HoverDecoration(
              defaultDecoration: defaultDecoration,
              hoverDecoration: hoverDecoration,
              child: Center(
                child: FaIcon(
                  icon,
                  color: MyColors.iconDarkGray,
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildRow(List<dynamic> category) {
    return Row(
      children: <Widget>[
        _buildRowIcon(category[0]),
        _buildRowIcon(category[1]),
        _buildRowIcon(category[2]),
        _buildRowIcon(category[3]),
        _buildRowIcon(category[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        Text(
          'Tab Icon',
          style: MyTextStyle.regularTitle,
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: FaIcon(
            selectedIcon,
            color: MyColors.iconDarkGray,
            size: 54,
          ),
        ),
        Container(
          width: 310,
          height: MediaQuery.of(context).size.height - subListHeight ?? 290,
          child: ListView.builder(
              itemCount: allIconsList.length,
              itemBuilder: (context, index) {
                if (allIconsList[index].length == 1) {
                  return _buildText(allIconsList[index][0]);
                } else {
                  return _buildRow(allIconsList[index]);
                }
              }),
        )
      ],
    );
  }
}
