import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';
import 'package:riverpod_theory/riverpod/state_notifier_provider.dart';

/**
 * 여러 Provider들을 한 Provider에서 사용하기
 * 각 Provider들의 로직과 상태가 그대로 유지됨!!!
 */
final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    final filterState = ref.watch(filterProvider);
    final shoppingListState = ref.watch(shoppingListProvider);

    if (filterState == FilterState.all) {
      return shoppingListState;
    }

    // 필터링
    return shoppingListState
        .where((element) => filterState == FilterState.spicy
            ? element.isSpicy
            : !element.isSpicy)
        .toList();
  },
);

enum FilterState {
  // 안매움
  notSpicy,
  // 매움
  spicy,
  // 전부
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
