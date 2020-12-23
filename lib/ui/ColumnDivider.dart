import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';

class ColumnDivider extends StatelessWidget {
  final String name;
  ColumnDivider({this.name = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: name.length == 0 ? 0 : 15,
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                  color: MyColors.gray, borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
