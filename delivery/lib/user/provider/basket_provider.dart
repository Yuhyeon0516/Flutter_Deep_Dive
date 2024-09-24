import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:delivery/product/model/product_model.dart';
import 'package:delivery/user/model/basket_item_model.dart';
import 'package:delivery/user/model/patch_basket_body.dart';
import 'package:delivery/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketStateNotifier, List<BasketItemModel>>((ref) {
  final repository = ref.watch(userMeRepositoryProvider);

  return BasketStateNotifier(repository: repository);
});

class BasketStateNotifier extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  final updateBasketDebunce = Debouncer(
    const Duration(seconds: 1),
    initialValue: null,
    checkEquality: false,
  );

  BasketStateNotifier({
    required this.repository,
  }) : super([]) {
    updateBasketDebunce.values.listen((state) {
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    await repository.patchBasket(
      body: PatchBasketBody(
        basket: state
            .map((e) =>
                PatchBasketBodyBasket(productId: e.product.id, count: e.count))
            .toList(),
      ),
    );
  }

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

    // Optimistic Response(긍정적 응답)
    // 응답이 성공할것이라고 가정하고 상태를 먼저 변경하고 api 요청을 보냄
    // api 요청을 먼저하면 상태가 바뀌는데 딜레이가 생겨 UX적으로 좋지않음
    updateBasketDebunce.setValue(null);
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

    updateBasketDebunce.setValue(null);
  }
}
