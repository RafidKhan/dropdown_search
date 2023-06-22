import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final String name;
  final String id;
  final Color color;

  const DataTile({
    Key? key,
    required this.name,
    required this.id,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        children: [
          Text(name),
          Text(id),
        ],
      ),
    );
  }
}
