
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DashLinewidget extends StatelessWidget {
  bool? isvertical;
  bool? ishorizontal;
  DashLinewidget({Key? key, this.isvertical, this.ishorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isvertical == true) {
      return bulidDashedLine1();
    }
    return bulidDashedLine();
  }

  Widget bulidDashedLine() => const Center(
        child: DottedLine(
          dashColor: Colors.grey,
          dashGapLength: 4,
        ),
      );
  Widget bulidDashedLine1() => (const DottedLine(
        lineLength: 40,
        dashLength: 2,
        lineThickness: 2,
        direction: Axis.vertical,
        dashColor: Colors.black45,
        dashGapLength: 4,
      ));
}
