import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: Offset(4, 4)
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(-4, -4)
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}