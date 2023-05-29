import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /**
     * 어떠한 특정 값이 변할 때, build를 재실행할지 말지, 렌더링을 할지 말지를 watch와 listen을 통해 컨트롤하여 App을 최적화 할 수 있음
     */
    // watch => selectProvider의 값이 변경될 때마다 build 재실행
    // 특정 값만 체크하여 build를 재실행하고 싶은 경우, provider.select()로 지정
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));

    // listen에 지정한 값이 변할 때 아래의 코드 실행
    ref.listen(
      selectProvider.select((value) => value.hasBought),
      (previous, next) {
        print('next: $next');
      },
    );

    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text('Spicy Toggle'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text('Bought Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
