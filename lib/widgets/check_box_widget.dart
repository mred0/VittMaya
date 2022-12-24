
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget(
      {super.key,
      required this.on,
      required this.onbtn,
      required this.offbtn,
      required this.text});
  final bool? on;
  final Function()? onbtn;
  final Function()? offbtn;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (on == true)
            ? GestureDetector(
                onTap: onbtn,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              )
            : GestureDetector(
                onTap: offbtn,
                child: const Icon(
                  Icons.circle_outlined,
                ),
              ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text ?? '',
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
