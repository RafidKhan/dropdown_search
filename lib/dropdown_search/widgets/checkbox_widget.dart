import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final bool isCheck;

  const CheckboxWidget({
    Key? key,
    required this.isCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isCheck ? Colors.blue : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue),
      ),
      child: isCheck
          ? const Center(
              child: Icon(
                Icons.done,
                size: 12,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
