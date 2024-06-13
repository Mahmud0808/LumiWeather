import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/constants.dart';

class BackgroundStyle extends StatelessWidget {
  const BackgroundStyle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: const AlignmentDirectional(12, -0.1),
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundPurple,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(12, -0.1),
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black12,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-12, -0.1),
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundPurple,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(-12, -0.1),
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black12,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0, -1.2),
        child: Container(
          height: 300,
          width: 600,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: backgroundOrange,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0, -1.2),
        child: Container(
          height: 300,
          width: 600,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black12,
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    ]);
  }
}
