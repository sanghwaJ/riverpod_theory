import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleStreamProvider);

    return DefaultLayout(
      title: 'StreamProviderScreen',
      body: Center(
        child: state.when(
          // 데이터가 있을 때 실행
          data: (data) {
            return Text(
              data.toString(),
              textAlign: TextAlign.center,
            );
          },
          // 에러가 발생했을 때 실행
          error: (error, stack) => Text(
            error.toString(),
          ),
          // 로딩중일 때 실행 (stream은 캐싱이 되기 때문에 완전히 재시작한 경우에 실행됨)
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
