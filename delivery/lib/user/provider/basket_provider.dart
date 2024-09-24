import 'package:delivery/product/model/product_model.dart';
import 'package:delivery/user/model/basket_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketStateNotifier, List<BasketItemModel>>((ref) {
  return BasketStateNotifier();
});

class BasketStateNotifier extends StateNotifier<List<BasketItemModel>> {
  BasketStateNotifier() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    // 현재 장바구니에 상품이 존재하는지 확인
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    // 장바구니에 있다면 count만 1증가
    if (exists) {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    }
    // 장바구니에 없다면 count를 1로한 상품을 장바구니에 추가
    else {
      state = [
        ...state,
        BasketItemModel(product: product, count: 1),
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != product.id).toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
  }
}
