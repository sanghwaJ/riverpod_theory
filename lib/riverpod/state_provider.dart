import 'package:flutter_riverpod/flutter_riverpod.dart';

// 관리할 값에대한 타입을 generic에 지정
final numberProvider = StateProvider<int>((ref) => 0);
