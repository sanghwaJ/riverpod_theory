import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(
      gStateMultiplyProvider(
        number1: 10,
        number2: 20,
      ),
    );

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('State1: $state1'),
          state2.when(
            data: (data) {
              return Text(
                'state2: $data',
                textAlign: TextAlign.center,
              );
            },
            error: (error, stack) => Text(
              error.toString(),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          state3.when(
            data: (data) {
              return Text(
                'state3: $data',
                textAlign: TextAlign.center,
              );
            },
            error: (error, stack) => Text(
              error.toString(),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text('State4: $state4'),
          // Consumer => 여러 Provider 중, 단 하나만 상태가 변경되어도 전체 build가 재실행되는 비효율 해결
          // 특정 provider의 상태가 변경되면 아래의 builder 함수만 실행
          Consumer(
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);
              return Row(
                children: [
                  Text('State5: $state5'),
                  if (child != null) child,
                ],
              );
            },
            // builder 함수 안에서 provider의 상태가 변경되어도, 다시 실행되지 않아도 되는 부분은 child에 구현
            // 즉, child는 단 한 번만 실행되기 때문에, 렌더링에 많은 자원을 사용하는 위젯을 child에 구현하면 효율적 (const와 비슷..)
            child: Text('hello'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: Text('Decrement'),
              ),
            ],
          ),
          // invalidate() => Provider를 초기화 함
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('Invalidate'),
          ),
        ],
      ),
    );
  }
}
