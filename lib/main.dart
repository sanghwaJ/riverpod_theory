import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/riverpod/provider_observer.dart';
import 'package:riverpod_theory/screen/home_screen.dart';

void main() {
  runApp(
    // riverpod을 사용하려면, main을 ProviderScope로 감싸야 함
    ProviderScope(
      // observers => 로깅 기능
      observers: [
        Logger(),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
