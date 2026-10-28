import 'package:flutter/material.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? marrgin;
  final Color? cardcolor;
  const CustomCardContainer({
    Key? key,
    required this.child,
    this.padding,
    this.marrgin,
    this.cardcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(16),
      margin: marrgin ?? EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardcolor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}