import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

/**
 * Riverpod CodeGeneration의 장점 1
 * => 어떤 Provider를 사용할지 결정할 고민이 없도록 해줌
 */
// 기존 방법
final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

// riverpod code generation
@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

// 파라미터를 받는 riverpod은 Riverpod으로 사
@Riverpod(
  // keepAlive의 Default는 false(AutoDispose), 따라서 AutoDispose 기능을 끄고 싶으면 keepAlive: true로 선언
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

/**
 * Riverpod CodeGeneration의 장점 2
 * => Family를 사용할 때, Parameter를 일반 함수처럼 사용할 수 있도록 해줌
 */
// 기존 방법
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}
final _testFamilyProvider = Provider.family<int, Parameter>(
  (ref, parameter) => parameter.number1 * parameter.number2,
);

// riverpod code generation
@riverpod
int gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

/**
 * Riverpod CodeGeneration의 장점 3
 * => StateNotifierProvider를 편하게 작성할 수 있음
 */

@riverpod
class GStateNotifier extends _$GStateNotifier {
  // 꼭 build 함수를 override하여 초기값을 지정해줘야 함
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}