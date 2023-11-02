import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int totalIndicators;
  final int activeIndex;

  const Indicator({Key? key, required this.totalIndicators, required this.activeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalIndicators, (index) {
        return Container(
          width: 8,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == activeIndex ? const Color(0xFF22A45D) : const Color(0xFF868686),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}