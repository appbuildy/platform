import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/AppPreview.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(child: Toolbox()),
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.black))),
                ),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: Container(
                    child: AppPreview(
                      components: [],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          left: BorderSide(width: 1, color: Colors.black))),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
