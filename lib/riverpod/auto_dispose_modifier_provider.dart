import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider.autoDispose => 필요가 없을 때, 자동으로 캐시를 삭제함
final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1,2,3,4,5];
});
