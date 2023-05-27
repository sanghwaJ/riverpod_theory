import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider.family => provider를 생성할 때, 변수 데이터를 받아 provider의 로직을 변경해야 하는 경우 사용
final familyModifierProvider =
    FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2));

  return List.generate(5, (index) => index * data);
});
