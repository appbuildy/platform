import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class ColumnDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Container(
        height: 1,
        width: 260,
        decoration: BoxDecoration(
            color: MyColors.gray, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
