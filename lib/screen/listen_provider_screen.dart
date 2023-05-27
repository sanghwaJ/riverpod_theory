import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ListenProviderScreen> createState() => _ListenProviderScreen();
}

class _ListenProviderScreen extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;


  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      // initState 한 번만 실행되기 때문에 ref.watch를 사용하면 안됨
      initialIndex: ref.read(listenProvider),
    );
  }
  // 참고로, listenProvider의 listen은 중복 실행이 되지 않게 설계되어 있어, dispose를 따로 해주지 않아도 됨

  // ConsumerStatefulWidget은 WidgetRef가 글로벌하게 지정되어 있기 때문에, WidgetRef를 바로 사용할 수 있음
  @override
  Widget build(BuildContext context) {
    // listen => 값이 변경될 때마다 아래의 코드 실행
    ref.listen<int>(
      listenProvider,
      (previous, next) {
        if (previous != next) {
          controller.animateTo(
            next,
          );
        }
      },
    );

    return DefaultLayout(
      title: 'ListenProviderScreen',
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(), // 좌우 스크롤 고정
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 10 ? 10 : state + 1);
                },
                child: Text('다음'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 0 : state - 1);
                },
                child: Text('이전'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
