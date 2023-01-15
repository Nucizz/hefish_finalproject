import 'package:flutter/material.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget child;

  AnimatedPageRoute({required this.child}) : super(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, primaryAnimation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> primaryAnimation, Animation<double> secondaryAnimation, Widget child) => 
  SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0,0),
    ).animate(primaryAnimation),
    child: child);
}