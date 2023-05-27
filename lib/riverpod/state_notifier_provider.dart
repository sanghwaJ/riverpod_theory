// 상태 관리 할 값의 타입을 generic에 꼭 선언해야 함
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/model/shopping_item_model.dart';

// StateNotifierProvider는 StateNotifier를 상속한 클래스를 반환함
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
  (ref) => ShoppingListNotifier(),
);

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super(
          [
            // super 안에는 해당 provider를 초기화를 할 값들이 들어감
            ShoppingItemModel(
              name: '김치',
              quantity: 3,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '라면',
              quantity: 5,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '삼겹살',
              quantity: 10,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '수박',
              quantity: 2,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '계란',
              quantity: 14,
              hasBought: false,
              isSpicy: false,
            ),
          ],
        );

  void toggleHasBought({required String name}) {
    // map 함수를 통해 hasBought를 반대로 바꾼 새로운 리스트를 생성
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy,
              )
            : e)
        .toList();
  }
}
