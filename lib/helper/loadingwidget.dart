import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

loadingScreen() {
  return Center(
    child: Lottie.asset(
      'assets/animation_lk3nf8c0.json',
      height: 800,
      fit: BoxFit.contain,
    ),
  );
}
