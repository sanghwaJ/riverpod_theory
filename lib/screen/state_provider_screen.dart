import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/state_provider.dart';

// riverpod을 사용하려면 ConsumerWidget을 extends하면 됨
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch => provider의 변경이 발생하면, 빌드 재실행
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        // 가운데 정렬을 하기위해 SizedBox로 위젯을 감싸고, width를 화면의 최대로 줌
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => _NextScreen(),
                  ),
                );
              },
              child: Text('Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                // ref.read => 버튼을 눌렀을 때 상태 변경이 이뤄지는 경우에 사용
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('UP'),
            ),
            ElevatedButton(
              onPressed: () {
                // ref.read().state => provider의 값을 가져오고, 수정할 수 있음
                ref.read(numberProvider.notifier).state =
                    ref.read(numberProvider.notifier).state - 1;
              },
              child: Text('DOWN'),
            ),
          ],
        ),
      ),
    );
  }
}
