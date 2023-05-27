import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';
import 'package:riverpod_theory/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);

    return DefaultLayout(
      title: 'StateNotifierProvider',
      body: ListView(
        children: state
            .map(
              (e) => CheckboxListTile(
                // 체크박스
                title: Text(e.name),
                value: e.hasBought, // true면 checked, false면 unchecked
                onChanged: (value) {
                  ref.read(shoppingListProvider.notifier).toggleHasBought(
                        name: e.name,
                      );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
